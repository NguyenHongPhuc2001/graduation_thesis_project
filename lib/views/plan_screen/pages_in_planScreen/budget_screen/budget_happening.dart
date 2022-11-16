import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';


import 'budget_update.dart';

class BudgetHappening extends StatefulWidget {
  final List<Budget>? listBudget;

  const BudgetHappening({ Key? key, this.listBudget, }) : super(key: key);

  @override
  State<BudgetHappening> createState() => _BudgetHappeningState();

}

class _BudgetHappeningState extends State<BudgetHappening> {

  bool isEmpty = false;
  final nf = NumberFormat("###,###");
  final df = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double totalSpending = 0, percentSpending = 0, percentOver = 0;
    bool isOverSpending = false;

    return Scaffold(
      body: widget.listBudget!.isEmpty
          ? SizedBox(
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
            )
          : SizedBox(
              width: size.width,
              child: ListView.builder(
                  itemCount: widget.listBudget!.length,
                  itemBuilder: (context, index) {

                    percentSpending = (widget.listBudget!.elementAt(index).budgetPresentValue! /
                        widget.listBudget!.elementAt(index).budgetValue) *
                        100;
                    if (widget.listBudget!.elementAt(index).budgetStatus!) {
                      isOverSpending = true;
                      percentOver = percentSpending - 100;
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: size.width * 0.07),
                      child: InkWell(
                        onTap: () {
                          Get.to(BudgetUpdate(budget: widget.listBudget!.elementAt(index)));
                        },
                          child:
                          SingleRowContainer(
                            boxDecoration: BoxDecoration(
                              border: Border.all(
                                  width: size.width * 0.001,
                                  color: Colors.black),
                            ),
                            paddingTop: size.width * 0.02,
                            paddingBottom: size.width * 0.02,
                            children: [
                              SizedBox(
                                width: size.width * 0.23,
                                child: CircleIconContainer(
                                  urlImage: widget.listBudget!.elementAt(index).budgetIcon,
                                  iconSize: size.width * 0.1,
                                  backgroundColor: Colors.orange,
                                  padding: size.width * 0.045,
                                ),
                              ),
                              Container(
                                width: size.width * 0.76,
                                padding:
                                EdgeInsets.only(right: size.width * 0.02),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.025),
                                      child: Row(
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
                                                    widget.listBudget!.elementAt(index).budgetName,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize:
                                                      size.width * 0.05,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                        size.width * 0.03),
                                                    child: Visibility(
                                                      visible: isOverSpending
                                                          ? true
                                                          : false,
                                                      child: SvgPicture.asset(
                                                        "images/WarningIcon.svg",
                                                        width:
                                                        size.width * 0.045,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Text(
                                                "Kỳ hạn: ${widget.listBudget!.elementAt(index).budgetMothYear}",
                                                style: TextStyle(
                                                  fontSize: size.width * 0.03,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.more_vert),
                                            onPressed: () {},
                                            splashRadius: size.width * 0.06,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.025,
                                          top: size.width * 0.01,
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
                                                    text: nf
                                                        .format(widget.listBudget!.elementAt(index).budgetPresentValue),
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                    FontWeight.bold,
                                                    decoration:
                                                    TextDecoration.none,
                                                  ),
                                                  TextContainer(
                                                    text: " đ  ",
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                    FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  TextContainer(
                                                    text: ((percentSpending -
                                                        percentSpending
                                                            .toInt() ==
                                                        0) ==
                                                        true)
                                                        ? percentSpending
                                                        .toInt()
                                                        .toStringAsFixed(1)
                                                        : percentSpending
                                                        .toStringAsFixed(1),
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                    FontWeight.w400,
                                                    decoration:
                                                    TextDecoration.none,
                                                  ),
                                                  TextContainer(
                                                    text: "%",
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                    FontWeight.w400,
                                                    decoration: TextDecoration
                                                        .none,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.023),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    TextContainer(
                                                      text: nf.format(
                                                          widget.listBudget!
                                                              .elementAt(
                                                              index)
                                                              .budgetValue -
                                                              totalSpending),
                                                      textColor: Colors.black,
                                                      textSize: size.width *
                                                          0.03,
                                                      textFontWeight:
                                                      FontWeight.bold,
                                                      decoration:
                                                      TextDecoration.none,
                                                    ),
                                                    TextContainer(
                                                      text: " đ  ",
                                                      textColor: Colors.black,
                                                      textSize: size.width *
                                                          0.03,
                                                      textFontWeight:
                                                      FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    TextContainer(
                                                      text: (((100 -
                                                          percentSpending) -
                                                          (100 -
                                                              percentSpending
                                                                  .toInt()) ==
                                                          0) ==
                                                          true)
                                                          ? (100 -
                                                          (percentSpending
                                                              .toInt()))
                                                          .toStringAsFixed(1)
                                                          : (100 -
                                                          percentSpending)
                                                          .toStringAsFixed(1),
                                                      textColor: Colors.black,
                                                      textSize: size.width *
                                                          0.03,
                                                      textFontWeight:
                                                      FontWeight.w400,
                                                      decoration:
                                                      TextDecoration.none,
                                                    ),
                                                    TextContainer(
                                                      text: "%",
                                                      textColor: Colors.black,
                                                      textSize: size.width *
                                                          0.03,
                                                      textFontWeight:
                                                      FontWeight.w400,
                                                      decoration: TextDecoration
                                                          .none,
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
                                          top: size.width * 0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          LinearPercentIndicator(
                                            barRadius: Radius.circular(
                                                size.width * 0.008),
                                            lineHeight: size.width * 0.02,
                                            percent: isOverSpending
                                                ? 1
                                                : percentSpending / 100,
                                            progressColor: isOverSpending
                                                ? Colors.red
                                                : Colors.green,
                                            width: size.width * 0.74,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.03),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.015),
                                                   decoration: const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: size.width * 0.01),
                                                  child: TextContainer(
                                                    text: "Đã chi",
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                    FontWeight.w300,
                                                    decoration:
                                                    TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.028),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.015),
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: size.width * 0.01),
                                                  child: TextContainer(
                                                    text: "Còn lại",
                                                    textColor: Colors.black,
                                                    textSize: size.width * 0.03,
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
                                            visible:
                                            isOverSpending ? true : false,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: size.width * 0.028),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        size.width * 0.015),
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: size.width * 0.01),
                                                    child: Text(
                                                      "Vượt ngưỡng",
                                                      style: TextStyle(
                                                        fontSize:
                                                        size.width * 0.03,
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
                          )
                        ),
                    );
                  }),
            ),
    );
  }
}
