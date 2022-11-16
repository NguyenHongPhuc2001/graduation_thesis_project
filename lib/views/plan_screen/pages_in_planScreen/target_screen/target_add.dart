import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/goal_controller.dart';
import 'package:intl/intl.dart';

import '../../../../models/goal.dart';
import '../../../commons/pages/select_icon.dart';
import '../../../commons/widgets/circle_icon_container.dart';
import '../../../commons/widgets/custom_round_rectangle_button.dart';
import '../../../commons/widgets/single_row_container.dart';
import '../../../commons/widgets/text_container.dart';

class AddTarget extends StatefulWidget {
  const AddTarget({Key? key}) : super(key: key);

  @override
  State<AddTarget> createState() => _AddTargetState();
}

class _AddTargetState extends State<AddTarget> {
  final _targetNameController = TextEditingController();
  final _targetMoneyController = MoneyMaskedTextController(
      thousandSeparator: ',',
      decimalSeparator: '',
      initialValue: 0,
      precision: 0);
  final DateFormat df = DateFormat("yyyy-MM-dd");
  var goalEndDate, goalIcon, colorSelectedIndex = 0, goalColor;

  List<Color> items = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.grey,
    Colors.brown,
    Colors.green,
    Colors.purple,
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.grey.shade500,
    Colors.brown.shade700,
    Colors.greenAccent,
    Colors.purpleAccent,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goalEndDate = DateTime.now();
    goalColor = items[0].value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade400,
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SingleRowContainer(
            mainAxisAlignment: MainAxisAlignment.center,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              InkWell(
                customBorder: CircleBorder(),
                splashColor: Colors.grey,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectIcons(),
                    ),
                  ).then((value) {
                    setState(() {
                      goalIcon = value;
                    });
                  });
                },
                child: CircleIconContainer(
                  urlImage:
                      (goalIcon != null) ? goalIcon : "images/QuestionIcon.svg",
                  iconSize: size.width * 0.14,
                  backgroundColor: Color(goalColor),
                  padding: size.width * 0.08,
                ),
              ),
            ],
          ),
          SingleRowContainer(
            width: size.width * 0.95,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: "Tên mục tiêu",
                      textColor: Colors.grey.shade600,
                      textSize: size.width * 0.055,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    SizedBox(height: size.width * 0.03),
                    TextField(
                      controller: _targetNameController,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixText: "  ",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: size.width * 0.05,
                        ),
                        hintText: "Nhập tên sự kiện",
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03),
                          borderSide: BorderSide(
                            width: size.width * 0.007,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03),
                          borderSide: BorderSide(
                            width: size.width * 0.0025,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SingleRowContainer(
            width: size.width * 0.95,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: "Số tiền mục tiêu",
                      textColor: Colors.grey.shade600,
                      textSize: size.width * 0.055,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    SizedBox(height: size.width * 0.03),
                    TextField(
                      controller: _targetMoneyController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: Color(0xffFB8500),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixText: "  ",
                        suffix: TextContainer(
                          text: "VNĐ",
                          textColor: Colors.grey.shade700,
                          textSize: size.width * 0.05,
                          textFontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: size.width * 0.05,
                        ),
                        hintText: "Nhập số tiền mục tiêu",
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03),
                          borderSide: BorderSide(
                            width: size.width * 0.007,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03),
                          borderSide: BorderSide(
                            width: size.width * 0.0025,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SingleRowContainer(
            width: size.width * 0.95,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: "Ngày kết thúc",
                      textColor: Colors.grey.shade600,
                      textSize: size.width * 0.055,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    SizedBox(height: size.width * 0.03),
                    InkWell(
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
                          goalEndDate = dateValue as DateTime;
                          final year1, year2, month1, month2, day1, day2;
                          DateTime t = goalEndDate;
                          DateTime t2 = DateTime.now();
                          year1 = t.year;
                          month1 = t.month;
                          day1 = t.day;
                          year2 = t2.year;
                          month2 = t2.month;
                          day2 = t2.day;

                          if (year1 < year2) {
                            setState(() {
                              goalEndDate = DateTime.now();
                            });
                            _showCalendarDialog();
                          } else if (year1 == year2 && month1 < month2) {
                            setState(() {
                              goalEndDate = DateTime.now();
                            });
                            _showCalendarDialog();
                          } else if (year1 == year2 &&
                              month1 == month2 &&
                              day1 < day2) {
                            setState(() {
                              goalEndDate = DateTime.now();
                            });
                            _showCalendarDialog();
                          }
                        });
                      },
                      child: SingleRowContainer(
                        boxDecoration: BoxDecoration(
                          border: Border.all(
                            width: size.width * 0.002,
                            color: Colors.grey,
                          ),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                        ),
                        paddingTop: size.width * 0.035,
                        paddingBottom: size.width * 0.035,
                        children: [
                          Container(
                            width: size.width * 0.18,
                            child: SvgPicture.asset(
                              "images/CalendarIcon_1.svg",
                              width: size.width * 0.09,
                            ),
                          ),
                          Container(
                            width: size.width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextContainer(
                                  text: df.format(goalEndDate),
                                  textColor: Colors.black,
                                  textSize: size.width * 0.055,
                                  textFontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: size.width * 0.1,
                                  color: Colors.grey.shade600,
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
            ],
          ),
          SingleRowContainer(
            width: size.width * 0.95,
            height: size.width * 0.28,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: "Màu sắc",
                      textColor: Colors.grey.shade600,
                      textSize: size.width * 0.055,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    SizedBox(height: size.width * 0.03),
                    Container(
                      width: size.width,
                      height: size.width * 0.13,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(right: size.width * 0.03),
                            padding: EdgeInsets.all(size.width * 0.01),
                            width: size.width * 0.13,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: (colorSelectedIndex == index)
                                      ? items[index]
                                      : Colors.white,
                                  width: size.width * 0.01),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {
                                setState(() {
                                  colorSelectedIndex = index;
                                  goalColor = items[index].value;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: items[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          top: size.width * 0.038,
          bottom: size.width * 0.038,
          left: size.width * 0.022,
          right: size.width * 0.022,
        ),
        width: size.width,
        height: size.width * 0.2,
        child: CustomRoundRectangleButton(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.grey,
              blurRadius: size.width * 0.04,
            ),
          ],
          onTap: () {
            setState(() {
              if (goalIcon != null &&
                  goalEndDate != null &&
                  goalColor != null) {
                GoalController()
                    .createGoal(
                        _targetNameController.text,
                        _targetMoneyController.numberValue,
                        df.format(goalEndDate),
                        goalColor.toString(),
                        goalIcon,
                        "Phuc")
                    .then((value) {
                  setState(() {
                    Navigator.pop(context, value);
                  });
                });

              } else {
                Fluttertoast.showToast(
                    msg: "Something wrong, please check again !");
              }
            });
          },
          buttonWith: size.width * 0.95,
          padding: size.width * 0.02,
          borderRadius: size.width * 0.02,
          text: Text(
            "Thêm mục tiêu",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.07,
            ),
          ),
          backgroundColor: Color(0xffFB8500),
        ),
      ),
    );
  }

  _showCalendarDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.02)),
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
