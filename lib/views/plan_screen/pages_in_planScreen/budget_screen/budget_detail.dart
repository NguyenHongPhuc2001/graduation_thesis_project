import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/models/Transaction.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container_2.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/percent_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../controllers/entites/budget_controller.dart';

class BudgetDetail extends StatefulWidget {

  final _budgetController = Get.put(BudgetController());

  BudgetDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<BudgetDetail> createState() => _BudgetDetailState();
}

class _BudgetDetailState extends State<BudgetDetail> {
  final _random = Random();
  final nf = NumberFormat("###,###");
  List<Transactions> listTransaction = [];
  final _pageController = PageController();
  final df = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double total_spending = 0, percentSpending = 0, overSpending = 0;
    bool isOverSpending = false;

    listTransaction.clear();

    // percentSpending = (total_spending / widget.budget!.budgetValue) * 100;

    if (percentSpending > 100) {
      isOverSpending = true;
      overSpending = percentSpending - 100;
      percentSpending = 100;
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.145),
          child: AppBarContainer2(
              text: "Chi tiết",
              backIcon: CupertinoIcons.xmark,
              prefixIcon1: Icons.edit,
              prefixIcon2: Icons.delete,
              onBackTap: () {
                Navigator.pop(context);
              },
              onPrefixIcon1Tap: () async {

              },
              onPrefixIcon2Tap: () {
                // _showDeleteDialog(widget.budget);
              }),
        ),
        body: Container(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.06),
                child: SingleRowContainer(
                  boxDecoration: BoxDecoration(
                    border: Border.all(
                      width: size.width * 0.001,
                      color: Colors.black,
                    ),
                  ),
                  paddingTop: size.width * 0.05,
                  paddingBottom: size.width * 0.05,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.025),
                          child: TextContainer(
                            text:
                               "",
                            textColor: Colors.black,
                            textSize: size.width * 0.04,
                            textFontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.025,
                              bottom: size.width * 0.015),
                          width: size.width * 0.99,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoneyTextContainer(
                                value: total_spending,
                                textSize: size.width * 0.04,
                                textFontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: size.width * 0.02),
                                child: Container(
                                  padding: EdgeInsets.all(size.width * 0.01),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.01),
                                    color: Colors.grey,
                                  ),
                                  child: PercentTextContainer(
                                    value: isOverSpending
                                        ? ("+ ${((overSpending - overSpending.toInt() == 0) == false) ? overSpending.toStringAsFixed(1) : overSpending.toInt().toString()}")
                                        : (((percentSpending -
                                                        percentSpending
                                                            .toInt() ==
                                                    0) ==
                                                false)
                                            ? percentSpending.toStringAsFixed(1)
                                            : percentSpending
                                                .toInt()
                                                .toString()),
                                    textSize: size.width * 0.04,
                                    textFontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        LinearPercentIndicator(
                          barRadius: Radius.circular(size.width * 0.008),
                          lineHeight: size.width * 0.02,
                          percent: percentSpending / 100,
                          progressColor:
                              isOverSpending ? Colors.red : Colors.green,
                          width: size.width * 0.99,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.025, top: size.width * 0.02),
                          child: Container(
                            width: size.width * 0.973,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MoneyTextContainer(
                                      value: total_spending,
                                      textSize: size.width * 0.04,
                                      textFontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    TextContainer(
                                      text: "Đã chi",
                                      textColor: Colors.black,
                                      textSize: size.width * 0.03,
                                      textFontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: size.width * 0.043),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MoneyTextContainer(
                                        value: total_spending,
                                        textSize: size.width * 0.04,
                                        textFontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      (isOverSpending == false)
                                          ? TextContainer(
                                              text: "Còn lại",
                                              textColor: Colors.black,
                                              textSize: size.width * 0.03,
                                              textFontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none,
                                            )
                                          : TextContainer(
                                              text: "Over Spending",
                                              textColor: Colors.red,
                                              textSize: size.width * 0.03,
                                              textFontWeight: FontWeight.w400,
                                              decoration: TextDecoration.none,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (listTransaction.isEmpty) Container(
                      padding: EdgeInsets.only(top: size.width * 0.3),
                      child: Text(
                        "Không có giao dịch",
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ) else Container(
                      width: size.width,
                      height: size.width * 1.275,
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: size.width * 0.1),
                              child: SingleRowContainer(
                                boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      color: Colors.grey,
                                      blurRadius: size.width * 0.02,
                                    ),
                                  ],
                                ),
                                paddingTop: size.width * 0.01,
                                paddingBottom: size.width * 0.01,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.all(size.width * 0.02),
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: size.width * 0.002,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: size.width * 0.03),
                                              child: Text(
                                                "11",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * 0.07,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Hôm nay"),
                                                      Text(
                                                          ""),
                                                    ],
                                                  ),
                                                  MoneyTextContainer(
                                                    value: total_spending,
                                                    textSize: size.width * 0.05,
                                                    textFontWeight:
                                                        FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width,
                                        height: size.width *
                                            0.26 *
                                            listTransaction.length,
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: listTransaction.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    top: size.width * 0.035),
                                                child: InkWell(
                                                  onTap: () async {
                                                    // await Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) =>
                                                    //         TransactionDetail(
                                                    //       listTransaction: widget
                                                    //           .listTransaction,
                                                    //       transaction:
                                                    //           listTransaction
                                                    //               .elementAt(
                                                    //         index,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ).then((value) =>
                                                    //     setState(() {
                                                    //       if (value ==
                                                    //           "Delete") {
                                                    //         Fluttertoast.showToast(
                                                    //             msg:
                                                    //                 "Xóa giao dịch thành công !");
                                                    //       } else if (value ==
                                                    //           "Save") {
                                                    //         Fluttertoast.showToast(
                                                    //             msg:
                                                    //                 "Thêm giao dịch thành công !");
                                                    //       }
                                                    //     }));
                                                  },
                                                  child: SingleRowContainer(
                                                    boxDecoration:
                                                        BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: size.width *
                                                                0.0015,
                                                            color:
                                                                Colors.black),
                                                        bottom: BorderSide(
                                                            width: size.width *
                                                                0.0015,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    paddingTop:
                                                        size.width * 0.02,
                                                    paddingBottom:
                                                        size.width * 0.02,
                                                    children: [
                                                      Container(
                                                        width: size.width * 0.2,
                                                        child:
                                                            CircleIconContainer(
                                                          urlImage:
                                                              listTransaction
                                                                  .elementAt(
                                                                      index)
                                                                  .rap
                                                                  .rapUrlImage,
                                                          iconSize:
                                                              size.width * 0.08,
                                                          backgroundColor: Colors
                                                              .lightGreenAccent,
                                                          padding: size.width *
                                                              0.045,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: size.width * 0.7,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: size
                                                                              .width *
                                                                          0.03),
                                                                  child:
                                                                      TextContainer(
                                                                    text: listTransaction
                                                                        .elementAt(
                                                                            index)
                                                                        .rap
                                                                        .rapName,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    textSize:
                                                                        size.width *
                                                                            0.045,
                                                                    textFontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                  ),
                                                                ),
                                                                TextContainer(
                                                                  text: df.format(listTransaction
                                                                      .elementAt(
                                                                          index)
                                                                      .createDate),
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  textSize:
                                                                      size.width *
                                                                          0.03,
                                                                  textFontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                ),
                                                                // Text("Đã chi"),
                                                              ],
                                                            ),
                                                            MoneyTextContainer(
                                                              value: listTransaction
                                                                  .elementAt(
                                                                      index)
                                                                  .transactionValue,
                                                              textSize:
                                                                  size.width *
                                                                      0.035,
                                                              textFontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors.red,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _showDeleteDialog(Budget bg) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.06),
                  child: Text(
                    "Xin đợi chút !",
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(text: "Bạn có chắc muốn xóa ngân sách "),
                  TextSpan(
                      text: "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(text: " chứ ?"),
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: size.width * 0.009, bottom: size.width * 0.009),
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    border: Border.all(
                      width: size.width * 0.002,
                      color: Colors.black,
                    ),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Hủy",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  List<Budget> lsBudget = [];
                  setState(() {

                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: size.width * 0.011, bottom: size.width * 0.011),
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
