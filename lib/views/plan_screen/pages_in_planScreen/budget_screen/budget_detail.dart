import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/model/Budget.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_update.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetDetail extends StatefulWidget {
  final List<Transactions> listTransaction;
  final List<Budget> listBudget;
  final Budget budget;

  const BudgetDetail({
    Key? key,
    required this.listTransaction,
    required this.budget,
    required this.listBudget,
  }) : super(key: key);

  @override
  State<BudgetDetail> createState() => _BudgetDetailState();
}

class _BudgetDetailState extends State<BudgetDetail> {
  final _random = Random();
  final nf = NumberFormat("###,###");
  List<Transactions> listTransaction = [];
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double total_spending = 0, percentSpending = 0, overSpending = 0;
    bool isOverSpending = false;
    listTransaction.clear();
    widget.listTransaction.forEach((element) {
      if (element.rap.id == widget.budget.rap.id) listTransaction.add(element);
    });
    listTransaction.forEach((element) {
      total_spending += element.transactionValue;
    });

    percentSpending = (total_spending / widget.budget.budgetValue) * 100;

    if (percentSpending > 100) {
      isOverSpending = true;
      overSpending = percentSpending - 100;
      percentSpending = 100;
    }

    print("over spending ${overSpending}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.xmark,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            widget.budget.rap.rapName,
            style: TextStyle(
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              splashRadius: size.width * 0.07,
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateBudget(
                        index: 1,
                        budget: widget.budget,
                        listBudget: widget.listBudget),
                  ),
                ).then((value) => setState(() {
                      if (value == "Update")
                        Fluttertoast.showToast(msg: "Cập nhật thành công !");
                    }));
              },
            ),
            IconButton(
              splashRadius: size.width * 0.07,
              icon: Icon(
                CupertinoIcons.delete_solid,
                color: Colors.black,
              ),
              onPressed: () {
                _showDeleteDialog(widget.budget);
              },
            ),
          ],
        ),
        body: Container(
          width: size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.06),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: size.width * 0.001,
                      color: Colors.black,
                    ),
                  ),
                  padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      right: size.width * 0.01,
                      top: size.width * 0.03,
                      bottom: size.width * 0.03),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.025),
                        child: Text(
                          "Tháng 9 năm 2022",
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.025,
                            bottom: size.width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  nf.format(total_spending),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "đ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  child: Visibility(
                                    visible: isOverSpending ? true : false,
                                    child: SvgPicture.asset(
                                      "images/WarningIcon.svg",
                                      width: size.width * 0.05,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: size.width * 0.045),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(size.width * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.01),
                                  color: Colors.grey,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      isOverSpending
                                          ? ("+ ${((overSpending - overSpending.toInt() == 0) == false) ? overSpending.toStringAsFixed(1) : overSpending.toInt().toString()}")
                                          : (((percentSpending -
                                                          percentSpending
                                                              .toInt() ==
                                                      0) ==
                                                  false)
                                              ? percentSpending
                                                  .toStringAsFixed(1)
                                              : percentSpending
                                                  .toInt()
                                                  .toString()),
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      " %",
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
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
                        width: size.width * 0.956,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.025, top: size.width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      nf.format(total_spending),
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "đ",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.01),
                                  child: Text(
                                    "Đã chi",
                                    style: TextStyle(
                                      fontSize: size.width * 0.03,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: size.width * 0.045),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        nf.format(widget.budget.budgetValue -
                                            total_spending),
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "đ",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: size.width * 0.04,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  (isOverSpending == false)
                                      ? Text(
                                          "Còn lại",
                                          style: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.black,
                                          ),
                                        )
                                      : Text(
                                          "OverSpending",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.width * 0.03,
                                            color: Colors.red,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (listTransaction.isEmpty)
                  ? Container(
                      padding: EdgeInsets.only(top: size.width * 0.5),
                      alignment: Alignment.center,
                      child: Text(
                        "Không có giao dịch",
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(
                      width: size.width,
                      height: size.width * 1.31,
                      child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: size.width * 0.2),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: size.width * 0.02,
                                    bottom: size.width * 0.02),
                                width: size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: size.width * 0.002,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Column(
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Hôm nay"),
                                                    Text("tháng 9 năm 2022"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "- ${nf.format(total_spending)}",
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.05,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: size.width *
                                                              0.03),
                                                      child: Text(
                                                        "đ",
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontSize:
                                                              size.width * 0.05,
                                                          color: Colors.black,
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
                                    ),
                                    Container(
                                      width: size.width,
                                      height: size.width *
                                          0.23 *
                                          listTransaction.length,
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: listTransaction.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.width * 0.02),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.02),
                                                  width: size.width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                            size.width * 0.05),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                                  .primaries[
                                                              _random.nextInt(
                                                                  Colors
                                                                      .primaries
                                                                      .length)][_random
                                                                  .nextInt(9) *
                                                              100],
                                                        ),
                                                        child: SvgPicture.asset(
                                                          listTransaction
                                                              .elementAt(index)
                                                              .rap
                                                              .rapUrlImage,
                                                          width:
                                                              size.width * 0.07,
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
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: size
                                                                              .width *
                                                                          0.03),
                                                                  child: Text(
                                                                    listTransaction
                                                                        .elementAt(
                                                                            index)
                                                                        .transactionName,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          size.width *
                                                                              0.045,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text("Đã chi"),
                                                              ],
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  (nf.format(listTransaction
                                                                      .elementAt(
                                                                          index)
                                                                      .transactionValue)),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: size
                                                                              .width *
                                                                          0.01),
                                                                  child: Text(
                                                                    "đ",
                                                                    style:
                                                                        TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
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
                      text: "${bg.rap.rapName}",
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
                    widget.listBudget
                        .removeWhere((element) => element.id == bg.id);
                    lsBudget = widget.listBudget;
                    Navigator.pop(
                      context,
                      BudgetScreen(
                          pageController: _pageController,
                          listBudget: lsBudget,
                          listTransaction: listTransaction),
                    );
                    Navigator.pop(context, "Delete");
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
