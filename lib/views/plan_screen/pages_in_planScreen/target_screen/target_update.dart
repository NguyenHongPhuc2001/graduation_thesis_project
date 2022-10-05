import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_thesis_project/dao/target_dao.dart';
import 'package:graduation_thesis_project/model/target.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_screen.dart';
import 'package:intl/intl.dart';

import '../../../commons/pages/select_icon.dart';

class UpdateTarget extends StatefulWidget {
  final Target target;
  final List<Target> listTarget;
  final int index;

  const UpdateTarget({
    Key? key,
    required this.target,
    required this.listTarget,
    required this.index,
  }) : super(key: key);

  @override
  State<UpdateTarget> createState() => _UpdateTargetState();
}

class _UpdateTargetState extends State<UpdateTarget> {
  final PageController _pageController = PageController();
  final _random = Random();
  final TextEditingController _targetMoneyController = TextEditingController();
  final TextEditingController _targetNameController = TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");
  final NumberFormat nf = NumberFormat("###,###");
  var dateTime, linkIcon;
  bool _onTextClick = true, _onTextFieldClick = false;

  Target newTarget = TargetDAO().tg1;

  @override
  void initState() {
    _targetMoneyController.text = nf.format(widget.target.targetMoney);
    dateTime = widget.target.endDate;
    linkIcon = widget.target.urlImage;
    _targetNameController.text = widget.target.targetName;
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
          "Sửa mục tiêu",
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
                newTarget.targetName = _targetMoneyController.text;
                if (dateTime != null) newTarget.endDate = dateTime;
                newTarget.targetMoney = widget.target.targetMoney;
                newTarget.currentMoney = widget.target.currentMoney;
                if (linkIcon != null) newTarget.urlImage = linkIcon as String;

                TargetDAO().updateTarget(widget.target, newTarget);
              });
              Navigator.pop(context, "Update");
            },
          ),
          IconButton(
            splashRadius: size.width * 0.07,
            icon: Icon(
              Icons.delete,
              color: Colors.black,
              size: size.width * 0.08,
            ),
            onPressed: () {
              setState(() {
                _showDeleteDialog(widget.target);
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
                            ? SvgPicture.asset(
                                widget.target.urlImage,
                                width: size.width * 0.09,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: _onTextClick,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _onTextClick = false;
                                  _onTextFieldClick = true;
                                  _targetNameController.text =
                                      widget.target.targetName;
                                });
                              },
                              child: Text(
                                widget.target.targetName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.07,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _onTextFieldClick,
                            child: TextField(
                              autofocus: true,
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
                                hintText: "Tên",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.07,
                                  fontWeight: FontWeight.w400,
                                ),
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
                                df.format(widget.target.endDate),
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
                              text: "Số tiền mục tiêu",
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
                                  controller: _targetMoneyController,
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
              padding: EdgeInsets.only(
                  left: size.width * 0.04, right: size.width * 0.04),
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.026, right: size.width * 0.024),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RotationTransition(
                            turns: AlwaysStoppedAnimation(90 / 360),
                            child: Container(
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.01),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: size.width * 0.001,
                      color: Colors.black,
                      width: size.width * 0.1,
                    ),
                  ],
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

  _showDeleteDialog(Target tg) {
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
                  TextSpan(text: "Bạn có chắc muốn xóa mục tiêu "),
                  TextSpan(
                      text: "${tg.targetName}",
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
                  List<Target> lsTarget = [];
                  setState(() {
                    widget.listTarget.removeAt(widget.index);
                    lsTarget = widget.listTarget;
                    Navigator.pop(
                      context,
                      TargetScreen(
                        pageController: _pageController,
                        listTarget: lsTarget,
                      ),
                    );
                    Navigator.pop(context);
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
