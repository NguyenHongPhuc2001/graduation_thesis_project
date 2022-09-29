import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_thesis_project/dao/budget_dao.dart';
import 'package:graduation_thesis_project/dao/wallet_dao.dart';
import 'package:graduation_thesis_project/model/Budget.dart';
import 'package:graduation_thesis_project/model/Wallet.dart';
import 'package:graduation_thesis_project/views/plan_screen/commons/pages/select_wallet.dart';
import 'package:intl/intl.dart';


class UpdateBudget extends StatefulWidget {
  final Budget budget;
  final List<Budget> listBudget;
  final int index;

  const UpdateBudget({
    Key? key,
    required this.index,
    required this.budget,
    required this.listBudget,
  }) : super(key: key);

  @override
  State<UpdateBudget> createState() => _UpdateBudgetState();
}

class _UpdateBudgetState extends State<UpdateBudget> {
  final PageController _pageController = PageController();
  final _random = Random();
  final TextEditingController _budgetMoneyController = TextEditingController();
  final TextEditingController _budgetRapNameController =
      TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");
  final NumberFormat nf = NumberFormat("###,###");
  var dateTime, linkIcon;
  final List<Wallet> listWallet = WalletDAO().getAllWallet();
  Budget newBudget = BudgetDAO().bg1;
  Wallet wallet = WalletDAO().wl1;
  bool _onTextClick = true, _onTextFieldClick = false;

  @override
  void initState() {
    _budgetMoneyController.text = nf.format(widget.budget.budgetValue);
    dateTime = widget.budget.endDate;
    linkIcon = widget.budget.rap.rapUrlImage;
    _budgetRapNameController.text = widget.budget.rap.rapName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          "Sửa ngân sách",
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
                newBudget = widget.budget;
              });
              Navigator.pop(context, "Update");
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
                      padding: EdgeInsets.all(size.width * 0.03),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.primaries[
                                _random.nextInt(Colors.primaries.length)]
                            [_random.nextInt(9) * 100],
                      ),
                      child: (linkIcon == null)
                          ? SvgPicture.asset(
                              widget.budget.rap.rapUrlImage,
                              width: size.width * 0.09,
                            )
                          : SvgPicture.asset(
                              linkIcon,
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
                            widget.budget.rap.rapName,
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
                  widget.budget.endDate = dateTime;
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
                                df.format(widget.budget.endDate),
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
                              Expanded(
                                child: TextField(
                                  controller: _budgetMoneyController,
                                  decoration: InputDecoration(
                                    prefix: Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.03),
                                      child: _textInTargetDetail(
                                        text: "đ",
                                        textColor: Color(0xff8AC926),
                                        textSize: size.width * 0.07,
                                        textFontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
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
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Visibility(
                              //         visible: _onTextClick,
                              //         child: InkWell(
                              //           onTap: () {
                              //             setState(() {
                              //               _onTextClick = false;
                              //               _onTextFieldClick = true;
                              //               _budgetMoneyController.text =
                              //                   nf.format(
                              //                       widget.budget.budgetValue);
                              //             });
                              //           },
                              //           child: Row(
                              //             children: [
                              //               Padding(
                              //                 padding: EdgeInsets.only(right: size.width*0.03),
                              //                 child: _textInTargetDetail(
                              //                   text: "đ",
                              //                   textColor: Color(0xff8AC926),
                              //                   textSize: size.width * 0.07,
                              //                   textFontWeight: FontWeight.bold,
                              //                   decoration: TextDecoration.none,
                              //                 ),
                              //               ),
                              //               _textInTargetDetail(
                              //                 text: nf.format(
                              //                     widget.budget.budgetValue),
                              //                 textColor: Color(0xff8AC926),
                              //                 textSize: size.width * 0.07,
                              //                 textFontWeight: FontWeight.bold,
                              //                 decoration: TextDecoration.none,
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       Visibility(
                              //         visible: _onTextFieldClick,
                              //         child: TextField(
                              //           inputFormatters: [
                              //             MaskTextInputFormatter(
                              //               mask: '###,###,###,###,###,###',
                              //               filter: {'#': RegExp(r'[0-9]')},
                              //               type: MaskAutoCompletionType.eager,
                              //             ),
                              //           ],
                              //           controller: _budgetMoneyController,
                              //           decoration: InputDecoration(
                              //             prefix: Padding(
                              //               padding: EdgeInsets.only(
                              //                   right: size.width * 0.03),
                              //               child: _textInTargetDetail(
                              //                 text: "đ",
                              //                 textColor: Color(0xff8AC926),
                              //                 textSize: size.width * 0.07,
                              //                 textFontWeight: FontWeight.bold,
                              //                 decoration: TextDecoration.none,
                              //               ),
                              //             ),
                              //             isDense: true,
                              //             border: InputBorder.none,
                              //           ),
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             color: Color(0xff8AC926),
                              //             fontSize: size.width * 0.07,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
                            SelectWallet(listWallet: listWallet),
                      ),
                    ).then((value) => setState(() {
                          wallet = value as Wallet;
                          widget.budget.wallet = wallet;
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
                              widget.budget.wallet.walletName,
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
    Size size = MediaQuery.of(context).size;
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
