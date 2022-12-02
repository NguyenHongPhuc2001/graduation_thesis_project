import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/budget_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'budget_update.dart';

// ignore: must_be_immutable
class BudgetHappening extends StatefulWidget {
  final List<Budget> listBudget;
  bool check;

  BudgetHappening({
    Key? key,
    required this.listBudget,
    required this.check
  }) : super(key: key);

  @override
  State<BudgetHappening> createState() => _BudgetHappeningState();
}

class _BudgetHappeningState extends State<BudgetHappening> {

  bool isEmpty = false;
  final nf = NumberFormat("###,###");
  final df = DateFormat("dd-MM-yyyy");
  List<Budget> listBudgetHappening = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BudgetController().getListByStatus(false).then((value) {
      setState(() {
        listBudgetHappening = List.from(value);
        print("check lenght " + listBudgetHappening.length.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double totalSpending = 0, percentSpending = 0, percentOver = 0;
    bool isOverSpending = false;

    if (widget.check == true) {
      listBudgetHappening.clear();
      if (mounted) {
        setState(() {
          listBudgetHappening = List.from(widget.listBudget);
        });
        setState(() {
          widget.check = false;
        });
      }
    }

    return Scaffold(
      body: listBudgetHappening.isEmpty
          ? Container(
              margin: EdgeInsets.only(top: size.width * 0.2),
              child: SizedBox(
                width: size.width,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "images/MoneyIcon_3.svg",
                      width: size.width * 0.5,
                    ),
                    Text(
                      "Không có ngân sách",
                      style: TextStyle(
                        fontSize: size.width * 0.09,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Chọn nút "),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: size.width * 0.13,
                              padding: EdgeInsets.only(
                                  top: size.width * 0.015,
                                  bottom: size.width * 0.015,
                                  right: size.width * 0.03,
                                  left: size.width * 0.03),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.1),
                                color: Colors.blue,
                              ),
                              child: Text(
                                "Thêm",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.02,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Text("để thêm ngân sách"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox(
              width: size.width,
              child: ListView.builder(
                  itemCount: listBudgetHappening.length,
                  itemBuilder: (context, index) {
                    percentSpending = (listBudgetHappening
                                .elementAt(index)
                                .budgetPresentValue! /
                        listBudgetHappening.elementAt(index).budgetValue) *
                        100;

                    if (listBudgetHappening.elementAt(index).budgetStatus!) {
                      isOverSpending = true;
                      percentOver = percentSpending - 100;
                    }

                    return Padding(
                      padding: EdgeInsets.only(
                          top: size.width * 0.06,
                          left: size.width * 0.02,
                          right: size.width * 0.02),
                      child: InkWell(
                          onTap: () {
                            Get.to(BudgetUpdate(
                                budget: listBudgetHappening.elementAt(index)));
                          },
                          child: SingleRowContainer(
                            boxDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: size.width * 0.01,
                                    color: Colors.black38),
                              ],
                            ),
                            paddingTop: size.width * 0.02,
                            paddingBottom: size.width * 0.02,
                            children: [
                              SizedBox(
                                width: size.width * 0.20,
                                child: CircleIconContainer(
                                  urlImage: listBudgetHappening
                                      .elementAt(index)
                                      .budgetIcon,
                                  iconSize: size.width * 0.05,
                                  backgroundColor: Colors.orange,
                                  padding: size.width * 0.040,
                                ),
                              ),
                              Container(
                                width: size.width * 0.76,
                                padding: EdgeInsets.only(
                                    right: size.width * 0.01,
                                    top: size.width * 0.02),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listBudgetHappening
                                                      .elementAt(index)
                                                      .budgetName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        size.width * 0.045,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: size.width * 0.015,
                                                  ),
                                                  child: Visibility(
                                                    visible: isOverSpending
                                                        ? true
                                                        : false,
                                                    child: SvgPicture.asset(
                                                      "images/WarningIcon.svg",
                                                      width: size.width * 0.03,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Kỳ hạn: ${listBudgetHappening.elementAt(index).budgetMothYear}",
                                              style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.width * 0.025,
                                          bottom: size.width * 0.01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  TextContainer(
                                                    text: nf.format(listBudgetHappening
                                                        .elementAt(index)
                                                        .budgetPresentValue),
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                        FontWeight.bold,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                  TextContainer(
                                                    text: "VNĐ",
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                        FontWeight.bold,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.02),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    TextContainer(
                                                      text: nf.format(listBudgetHappening
                                                              .elementAt(index)
                                                              .budgetValue -
                                                          totalSpending),
                                                      textColor: Colors.black,
                                                      textSize:
                                                          size.width * 0.03,
                                                      textFontWeight:
                                                          FontWeight.bold,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                    TextContainer(
                                                      text: "VNĐ  ",
                                                      textColor: Colors.black,
                                                      textSize:
                                                          size.width * 0.03,
                                                      textFontWeight:
                                                          FontWeight.bold,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    TextContainer(
                                                      text: (((100 - percentSpending) -
                                                                      (100 -
                                                                          percentSpending
                                                                              .toInt()) ==
                                                                  0) ==
                                                              true)
                                                          ? (100 -
                                                                  (percentSpending
                                                                      .toInt()))
                                                              .toStringAsFixed(
                                                                  1)
                                                          : (100 -
                                                                  percentSpending)
                                                              .toStringAsFixed(
                                                                  1),
                                                      textColor: Colors.black,
                                                      textSize:
                                                          size.width * 0.03,
                                                      textFontWeight:
                                                          FontWeight.w400,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                    TextContainer(
                                                      text: "%",
                                                      textColor: Colors.black,
                                                      textSize:
                                                          size.width * 0.03,
                                                      textFontWeight:
                                                          FontWeight.w400,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.width * 0.01),
                                      child: LinearPercentIndicator(
                                        barRadius:
                                            Radius.circular(size.width * 0.5),
                                        lineHeight: size.width * 0.02,
                                        percent: listBudgetHappening
                                                .elementAt(index)
                                                .budgetStatus!
                                            ? 1.0
                                            : ((listBudgetHappening
                                                    .elementAt(index)
                                                    .budgetPresentValue!) /
                                                (listBudgetHappening
                                                    .elementAt(index)
                                                    .budgetValue)),
                                        progressColor: listBudgetHappening
                                                .elementAt(index)
                                                .budgetStatus!
                                            ? Colors.red
                                            : Colors.green,
                                        width: size.width * 0.75,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.width * 0.03),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    size.width * 0.01),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.01),
                                                child: TextContainer(
                                                  text: "Đã chi",
                                                  textColor: Colors.black,
                                                  textSize: size.width * 0.025,
                                                  textFontWeight:
                                                      FontWeight.w300,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.028),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.01),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: size.width * 0.01),
                                                  child: TextContainer(
                                                    text: "Còn lại",
                                                    textColor: Colors.black,
                                                    textSize:
                                                        size.width * 0.025,
                                                    textFontWeight:
                                                        FontWeight.w300,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: listBudgetHappening
                                                    .elementAt(index)
                                                    .budgetStatus!
                                                ? true
                                                : false,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: size.width * 0.028),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        size.width * 0.01),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            size.width * 0.01),
                                                    child: Text(
                                                      "Vượt ngưỡng",
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.025,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    );
                  }),
            ),
    );
  }
}
