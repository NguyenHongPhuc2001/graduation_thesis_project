import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_thesis_project/dao/target_dao.dart';
import 'package:graduation_thesis_project/model/target.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_select_icons.dart';
import 'package:intl/intl.dart';

class AddTarget extends StatefulWidget {
  final List<Target> listTarget;

  const AddTarget({Key? key, required this.listTarget}) : super(key: key);

  @override
  State<AddTarget> createState() => _AddTargetState();
}

class _AddTargetState extends State<AddTarget> {
  final _random = Random();
  final TextEditingController _targetNameController = TextEditingController();
  final TextEditingController _targetMoneyController = TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");
  final PageController _pageController = PageController();
  var dateTime, linkIcon;

  Target target = TargetDAO().tg1;

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
          "Thêm mục tiêu",
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
              List<Target> listTarget = [];
              setState(() {
                target.targetName = _targetNameController.text;
                if (linkIcon != null) target.urlImage = linkIcon;
                target.targetMoney = double.parse(_targetMoneyController.text);
                target.currentMoney = 0;
                if (dateTime != null) target.endDate = dateTime;
                target.status = false;
                target.createDate = DateTime.now();
                target.id = widget.listTarget.length + 1;
                // listTarget = widget.listTarget;
                // listTarget.add(target);
                widget.listTarget.add(target);
                Navigator.pop(
                  context,
                  "Save",
                );
              });
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
                    InkWell(
                      customBorder: CircleBorder(),
                      onTap: () async {
                        final data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectIcons(),
                          ),
                        ).then((value) => setState(() {
                              linkIcon = value as String;
                            }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.03),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.primaries[
                                  _random.nextInt(Colors.primaries.length)]
                              [_random.nextInt(9) * 100],
                        ),
                        child: (linkIcon == null)
                            ? Icon(
                                Icons.question_mark,
                                size: size.width * 0.09,
                              )
                            : SvgPicture.asset(
                                linkIcon,
                                width: size.width * 0.09,
                              ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: size.width * 0.001,
                      color: Colors.black,
                      width: size.width * 0.1,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _targetNameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.07,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Tên mục tiêu",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: size.width * 0.07,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
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
                                      top: size.width * 0.005,
                                      bottom: size.width * 0.005),
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.016),
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
                  } else if (year1 == year2 && month1 < month2) {
                    setState(() {
                      dateTime = null;
                    });
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
                                      top: size.width * 0.005,
                                      bottom: size.width * 0.005),
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.016),
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
                                "Ngày kết thúc",
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
                      padding: EdgeInsets.all(size.width * 0.025),
                      child: Image.asset(
                        "icons/icons_1/money_icon_2.png",
                        width: size.width * 0.1,
                      ),
                    ),
                    VerticalDivider(
                      thickness: size.width * 0.001,
                      color: Colors.black,
                      width: size.width * 0.1,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: size.width*0.04),
                            child: Text(
                              "đ",
                              style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width*0.08
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _targetMoneyController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Số tiền mục tiêu",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                                focusColor: Colors.white,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen,
                                fontSize: size.width * 0.07,
                                decoration: TextDecoration.none,
                              ),
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
          // Padding(
          //   padding: EdgeInsets.only(top: size.width * 0.1),
          //   child: InkWell(
          //     onTap: () {},
          //     child: Container(
          //       padding: EdgeInsets.only(left: size.width * 0.04),
          //       height: size.width * 0.2,
          //       width: size.width,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           width: size.width * 0.001,
          //           color: Colors.black,
          //         ),
          //       ),
          //       child: IntrinsicHeight(
          //         child: Row(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.all(size.width * 0.01),
          //               child: Image.asset(
          //                 "icons/icons_1/money_icon_1.png",
          //                 width: size.width * 0.13,
          //               ),
          //             ),
          //             VerticalDivider(
          //               thickness: size.width * 0.001,
          //               color: Colors.black,
          //               width: size.width * 0.1,
          //             ),
          //             Expanded(
          //               child: Text(
          //                 "Việt nam đồng",
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: size.width * 0.07,
          //                   decoration: TextDecoration.none,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
