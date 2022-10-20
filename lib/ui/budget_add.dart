import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_thesis_project/models/budget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../views/commons/pages/select_wallet.dart';

class AddBudget extends StatefulWidget {
  final List<Budget>? listBudget;

  const AddBudget({
    Key? key,
    this.listBudget,
  }) : super(key: key);

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  final PageController _pageController = PageController();
  final _random = Random();
  final _budgetMoneyController = MoneyMaskedTextController(
      thousandSeparator: ',',
      initialValue: 0,
      precision: 0,
      decimalSeparator: '');
  final DateFormat df = DateFormat("yyyy-MM-dd");
  final NumberFormat nf = NumberFormat("###,###");
  var dateTime, linkIcon;
  String budgetValue = "";
  final pageController = PageController();

  bool _onTextClick = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "Thêm ngân sách",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: size.width * 0.07,
            icon: Icon(
              Icons.save,
              color: Colors.black,
              size: size.width * 0.08,
            ),
            onPressed: () {
              setState(() {

              });
              // Navigator.of(context).pushReplacement<BudgetScreen, String>(
              //     MaterialPageRoute(builder: (context) =>
              //         BudgetScreen(pageController: pageController,
              //             listBudget: widget.listBudget,
              //             listTransaction: listTransaction)), result: "Save");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ((widget.rapFromTransaction == null) == true)
          //     ? Padding(
          //   padding: EdgeInsets.only(top: size.width * 0.1),
          //   child: Container(
          //     padding: EdgeInsets.only(left: size.width * 0.04),
          //     height: size.width * 0.2,
          //     width: size.width,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         width: size.width * 0.001,
          //         color: Colors.black,
          //       ),
          //     ),
          //     child: IntrinsicHeight(
          //       child: InkWell(
          //         onTap: () async {
          //           await Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => SelectRap(),
          //             ),
          //           ).then((value) =>
          //               setState(() {
          //
          //               }));
          //         },
          //         child: Row(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.all(size.width * 0.03),
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 color: Colors.primaries[_random
          //                     .nextInt(Colors.primaries.length)]
          //                 [_random.nextInt(9) * 100],
          //               ),
          //               child: SvgPicture.asset(
          //                 "",
          //                 width: size.width * 0.09,
          //               ),
          //             ),
          //             VerticalDivider(
          //               thickness: size.width * 0.001,
          //               color: Colors.black,
          //               width: size.width * 0.1,
          //             ),
          //             Expanded(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                     "rap.rapName",
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: size.width * 0.07,
          //                       decoration: TextDecoration.none,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          //     : Padding(
          //   padding: EdgeInsets.only(top: size.width * 0.1),
          //   child: Container(
          //     padding: EdgeInsets.only(left: size.width * 0.04),
          //     height: size.width * 0.2,
          //     width: size.width,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         width: size.width * 0.001,
          //         color: Colors.black,
          //       ),
          //     ),
          //     child: IntrinsicHeight(
          //       child: Row(
          //         children: [
          //           Container(
          //             padding: EdgeInsets.all(size.width * 0.03),
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.primaries[
          //               _random.nextInt(Colors.primaries.length)]
          //               [_random.nextInt(9) * 100],
          //             ),
          //             child: SvgPicture.asset(
          //               "",
          //               width: size.width * 0.09,
          //             ),
          //           ),
          //           VerticalDivider(
          //             thickness: size.width * 0.001,
          //             color: Colors.black,
          //             width: size.width * 0.1,
          //           ),
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "",
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: size.width * 0.07,
          //                     decoration: TextDecoration.none,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: InkWell(
              onTap: () async {
                DateTime? dateValue = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2200),
                  fieldLabelText: "Ngày",
                  cancelText: "THOÁT",
                  confirmText: "XÁC NHẬN",
                  helpText: "CHỌN NGÀY",
                );

                setState(() {
                  dateTime = dateValue as DateTime;
                  final year1, year2, month1, month2, day1, day2;
                  DateTime t = dateTime;
                  DateTime t2 = DateTime.now();
                  year1 = t.year;
                  month1 = t.month;
                  day1 = t.day;
                  year2 = t2.year;
                  month2 = t2.month;
                  day2 = t2.day;

                  if (year1 < year2) {
                    setState(() {
                      dateTime = null;
                    });
                    _showCalendarDialog();
                  } else if (year1 == year2 && month1 < month2) {
                    setState(() {
                      dateTime = null;
                    });
                    _showCalendarDialog();
                  } else if (year1 == year2 &&
                      month1 == month2 &&
                      day1 < day2) {
                    setState(() {
                      dateTime = null;
                    });
                    _showCalendarDialog();
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                height: size.width * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: Image.asset("icons/icons_1/calendar_icon_1.png",
                            width: size.width * 0.1),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: dateTime == null
                            ? Text(
                          df.format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        )
                            : Text(
                          df.format(dateTime),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: InkWell(
              onTap: () async {
                DateTime? dateValue = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2200),
                  fieldLabelText: "Ngày",
                  cancelText: "THOÁT",
                  confirmText: "XÁC NHẬN",
                  helpText: "CHỌN NGÀY",
                );

                setState(() {
                  dateTime = dateValue as DateTime;
                  final year1, year2, month1, month2, day1, day2;
                  DateTime t = dateTime;
                  DateTime t2 = DateTime.now();
                  year1 = t.year;
                  month1 = t.month;
                  day1 = t.day;
                  year2 = t2.year;
                  month2 = t2.month;
                  day2 = t2.day;

                  if (year1 < year2) {
                    setState(() {
                      dateTime = null;
                    });
                    _showCalendarDialog();
                  } else if (year1 == year2 && month1 < month2) {
                    setState(() {
                      dateTime = null;
                    });
                    _showCalendarDialog();
                  } else if (year1 == year2 &&
                      month1 == month2 &&
                      day1 < day2) {
                    setState(() {
                      dateTime = null;
                    });
                    _showCalendarDialog();
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                height: size.width * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: Image.asset("icons/icons_1/calendar_icon_1.png",
                            width: size.width * 0.1),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: dateTime == null
                            ? Text(
                          df.format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        )
                            : Text(
                          df.format(dateTime),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              height: size.width * 0.2,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: size.width * 0.001,
                  color: Colors.black,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      child: Image.asset(
                        "icons/icons_1/money_icon_1.png",
                        width: size.width * 0.13,
                      ),
                    ),
                    VerticalDivider(
                      thickness: size.width * 0.001,
                      color: Colors.black,
                      width: size.width * 0.1,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.02),
                            child: _textInTargetDetail(
                              text: "Số tiền ngân sách",
                              textColor: Colors.black,
                              textSize: size.width * 0.03,
                              textFontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible: _onTextClick,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(right: size.width * 0.03),
                                  child: _textInTargetDetail(
                                    text: "đ",
                                    textColor: Color(0xff8AC926),
                                    textSize: size.width * 0.07,
                                    textFontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      _onTextClick = true;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _budgetMoneyController,
                                  decoration: InputDecoration(
                                    hintText: "Nhập số tiền ngân sách",
                                    hintStyle: TextStyle(
                                      fontSize: size.width * 0.05,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff8AC926),
                                    fontSize: size.width * 0.07,
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
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              height: size.width * 0.2,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: size.width * 0.001,
                  color: Colors.black,
                ),
              ),
              child: IntrinsicHeight(
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SelectWallet(listWallet: null),
                      ),
                    ).then((value) =>
                        setState(() {
                          // widget.budget.wallet = wallet;
                        }));
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.03),
                        child: SvgPicture.asset(
                          "images/WalletIcon_1.svg",
                          width: size.width * 0.09,
                        ),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                             "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.07,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showCalendarDialog() {
    Size size = MediaQuery
        .of(context)
        .size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Chờ chút",
              style: TextStyle(
                fontSize: size.width * 0.07,
                color: Colors.black,
              ),
            ),
            content: Text(
              "Ngày không hợp lệ ! Vui lòng chọn lại !",
              style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.04,
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
                      top: size.width * 0.005, bottom: size.width * 0.005),
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    "OK",
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

class _textInTargetDetail extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textFontWeight;
  final TextDecoration decoration;

  const _textInTargetDetail({
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
