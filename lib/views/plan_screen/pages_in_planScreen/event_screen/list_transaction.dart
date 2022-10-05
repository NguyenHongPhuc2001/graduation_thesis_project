import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_thesis_project/dao/transaction_dao.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/transaction_screen/transaction_detail.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatefulWidget {
  final Event event;
  final List<Transactions> listTransaction;

  const ListTransaction({
    Key? key,
    required this.event,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  final nf = NumberFormat("###,###");
  final _random = Random();
  final listDayTransaction = <int>[];
  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Transactions> listData = [];
    widget.listTransaction.forEach((element) {
      print("Event is  : ${element.event}");
      if (element.event?.id == widget.event.id) {
        listData.add(element);
      }
    });
    double totalSpending = 0, recieverMoney = 0;

    listData.forEach((element) {
      if (element.rap.rapCategory.rapCateType == "Chi") {
        totalSpending += element.transactionValue;
      } else {
        recieverMoney += element.transactionValue;
        print("Note : ${element.transactionNote}");
      }
    });


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Danh sách giao dịch",
            style: TextStyle(
              fontSize: size.width * 0.065,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          width: size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(size.width * 0.04),
                width: size.width,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: size.width * 0.001,
                      color: Colors.grey,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: size.width * 0.01,
                      color: Colors.grey,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _textContainer(
                          text: "${listData.length} kết quả",
                          textColor: Colors.black,
                          textSize: size.width * 0.05,
                          textFontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textContainer(
                          text: "Khoản thu",
                          textColor: Colors.grey,
                          textSize: size.width * 0.05,
                          textFontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
                        Row(
                          children: [
                            _textContainer(
                              text: "${nf.format(recieverMoney)} ",
                              textColor: Colors.green,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                            _textContainer(
                              text: "đ",
                              textColor: Colors.green,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textContainer(
                          text: "Khoản chi",
                          textColor: Colors.grey,
                          textSize: size.width * 0.05,
                          textFontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
                        Row(
                          children: [
                            _textContainer(
                              text: "${nf.format(totalSpending)} ",
                              textColor: Colors.red,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                            _textContainer(
                              text: "đ",
                              textColor: Colors.red,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            )
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: size.width * 0.001,
                      color: Colors.grey,
                      height: size.width * 0.05,
                      indent: size.width * 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textContainer(
                          text: "Còn lại",
                          textColor: Colors.grey,
                          textSize: size.width * 0.05,
                          textFontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
                        Row(
                          children: [
                            _textContainer(
                              text:
                                  "${nf.format(recieverMoney - totalSpending)} ",
                              textColor: Colors.grey.shade600,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                            _textContainer(
                              text: "đ",
                              textColor: Colors.grey.shade600,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              (listData.isEmpty)
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
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: size.width * 0.15),
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
                                                      "- ${nf.format(totalSpending)}",
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
                                      height:
                                          size.width * 0.23 * listData.length,
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: listData.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.width * 0.02),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TransactionDetail(
                                                        transaction: listData
                                                            .elementAt(index),
                                                        listTransaction: widget
                                                            .listTransaction,
                                                      ),
                                                    ),
                                                  );
                                                },
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
                                                          listData
                                                              .elementAt(index)
                                                              .rap
                                                              .rapUrlImage,
                                                          width:
                                                              size.width * 0.07,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: size.width * 0.7,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom:
                                                                      size.width *
                                                                          0.01),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    listData
                                                                        .elementAt(
                                                                            index)
                                                                        .rap
                                                                        .rapName,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          size.width *
                                                                              0.05,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        (nf.format(listData
                                                                            .elementAt(index)
                                                                            .transactionValue)),
                                                                        style: TextStyle(
                                                                            color: (listData.elementAt(index).rap.rapCategory.rapCateType == "Chi")
                                                                                ? Colors.red
                                                                                : Colors.green,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: size.width * 0.05),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: size.width * 0.01),
                                                                        child:
                                                                            Text(
                                                                          "đ",
                                                                          style:
                                                                              TextStyle(
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                            color: (listData.elementAt(index).rap.rapCategory.rapCateType == "Chi")
                                                                                ? Colors.red
                                                                                : Colors.green,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            _textContainer(
                                                              text: listData
                                                                  .elementAt(
                                                                      index)
                                                                  .transactionNote,
                                                              textColor: Colors
                                                                  .grey
                                                                  .shade600,
                                                              textSize:
                                                                  size.width *
                                                                      0.04,
                                                              textFontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
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
}

class _textContainer extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textFontWeight;
  final TextDecoration decoration;

  const _textContainer({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.textFontWeight,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: textFontWeight,
        decoration: decoration,
      ),
    );
  }
}
