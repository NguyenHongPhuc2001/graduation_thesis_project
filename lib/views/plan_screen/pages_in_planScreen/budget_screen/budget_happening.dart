import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/dao/transaction_dao.dart';
import 'package:graduation_thesis_project/model/Budget.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_detail.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetHappening extends StatefulWidget {
  final List<Budget> listBudget;
  final List<Transactions> listTransaction;

  const BudgetHappening({
    Key? key,
    required this.listBudget,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<BudgetHappening> createState() => _BudgetHappeningState();
}

class _BudgetHappeningState extends State<BudgetHappening> {
  bool isEmpty = false;
  final _random = Random();
  final nf = NumberFormat("###,###");
  final df = DateFormat("dd-MM-yyyy");

  // double targetPercent = 0;
  final List<Budget> listBudgetHappening = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    listBudgetHappening.clear();
    widget.listBudget.forEach((element) {
      if (element.status == false) {
        listBudgetHappening.add(element);
      }
    });

    double totalSpending = 0, percentSpending = 0, percentOver = 0;
    bool isOverSpending = false;

    return Scaffold(
      body: listBudgetHappening.isEmpty
          ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Chọn nút "),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
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
                  Text("để thêm ngân sách"),
                ],
              ),
            ),
          ],
        ),
      )
          : Container(
        width: size.width,
        child: ListView.builder(
            itemCount: listBudgetHappening.length,
            itemBuilder: (context, index) {
              widget.listTransaction.forEach((tran) {
                if (tran.rap.id ==
                    listBudgetHappening.elementAt(index).rap.id) {
                  totalSpending += tran.transactionValue;
                }
              });
              percentSpending = (totalSpending /
                  listBudgetHappening.elementAt(index).budgetValue) *
                  100;
              if (totalSpending >
                  listBudgetHappening.elementAt(index).budgetValue) {
                isOverSpending = true;
                percentOver = percentSpending - 100;

              }
              return Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.07, bottom: size.width * 0.07),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BudgetDetail(
                          listTransaction: widget.listTransaction,
                          budget: listBudgetHappening.elementAt(index),
                          listBudget: widget.listBudget,
                        ),
                      ),
                    ).then((value) => setState(() {
                      if (value == "Delete")
                        Fluttertoast.showToast(
                            msg: "Xóa ngân sách thành công !");
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: size.width * 0.02,
                        bottom: size.width * 0.02),
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: size.width * 0.001,
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.02),
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.04),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.primaries[_random
                                  .nextInt(Colors.primaries.length)]
                              [_random.nextInt(9) * 100],
                            ),
                            child: (listBudgetHappening
                                .elementAt(index)
                                .rap
                                .rapUrlImage ==
                                "")
                                ? Icon(
                              Icons.question_mark,
                              color: Colors.grey,
                              size: size.width * 0.08,
                            )
                                : SvgPicture.asset(
                              listBudgetHappening
                                  .elementAt(index)
                                  .rap
                                  .rapUrlImage,
                              width: size.width * 0.08,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.02),
                              child: Container(
                                width: size.width * 0.77,
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
                                              listBudgetHappening
                                                  .elementAt(index)
                                                  .rap
                                                  .rapName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize:
                                                size.width * 0.05,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: size.width*0.03),
                                              child: Visibility(
                                                visible: isOverSpending? true:false,
                                                child: SvgPicture.asset(
                                                  "images/WarningIcon.svg",
                                                  width: size.width * 0.045,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          df.format(listBudgetHappening
                                              .elementAt(index)
                                              .createDate),
                                          style: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: () {},
                                      splashRadius: size.width * 0.06,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.02,
                                  top: size.width * 0.01,
                                  bottom: size.width * 0.01),
                              child: Container(
                                width: size.width * 0.713,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                nf.format(totalSpending),
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize:
                                                  size.width * 0.03,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width *
                                                        0.007,
                                                    right: size.width *
                                                        0.015),
                                                child: Text(
                                                  "đ",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize:
                                                    size.width * 0.03,
                                                    color: Colors.black,
                                                    decoration:
                                                    TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                ((percentSpending -
                                                    percentSpending
                                                        .toInt() ==
                                                    0) ==
                                                    true)
                                                    ? "${percentSpending.toInt().toStringAsFixed(1)}"
                                                    : "${percentSpending.toStringAsFixed(1)}",
                                                style: TextStyle(
                                                  fontSize:
                                                  size.width * 0.03,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "%",
                                                style: TextStyle(
                                                  fontSize:
                                                  size.width * 0.03,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                nf.format(listBudgetHappening
                                                    .elementAt(index)
                                                    .budgetValue -
                                                    totalSpending),
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize:
                                                  size.width * 0.03,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width *
                                                        0.007,
                                                    right: size.width *
                                                        0.015),
                                                child: Text(
                                                  "đ",
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize:
                                                    size.width * 0.03,
                                                    color: Colors.black,
                                                    decoration:
                                                    TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                (((100 - percentSpending) -
                                                    (100 -
                                                        percentSpending
                                                            .toInt()) ==
                                                    0) ==
                                                    true)
                                                    ? "${(100 - (percentSpending.toInt())).toStringAsFixed(1)}"
                                                    : "${(100 - percentSpending).toStringAsFixed(1)}",
                                                style: TextStyle(
                                                  fontSize:
                                                  size.width * 0.03,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "%",
                                                style: TextStyle(
                                                  fontSize:
                                                  size.width * 0.03,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: size.width * 0.01),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  LinearPercentIndicator(
                                    barRadius: Radius.circular(
                                        size.width * 0.008),
                                    lineHeight: size.width * 0.02,
                                    percent: isOverSpending? 1:percentSpending/100,
                                    progressColor: isOverSpending ? Colors.red: Colors.green,
                                    width: size.width * 0.76,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: size.width * 0.01),
                                    width: size.width * 0.73,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Còn 3 ngày",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: size.width * 0.03,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.028),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  size.width * 0.015),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  size.width * 0.01),
                                              child: Text(
                                                "Đã chi",
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.028),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  size.width * 0.015),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  size.width * 0.01),
                                              child: Text(
                                                "Còn lại",
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
                                      Visibility(
                                        visible: isOverSpending?true:false,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.028),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    size.width * 0.015),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                    size.width * 0.01),
                                                child: Text(
                                                  "Overspending",
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
