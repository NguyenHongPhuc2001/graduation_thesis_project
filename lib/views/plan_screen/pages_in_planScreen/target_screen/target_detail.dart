import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/model/target.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_update.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TargetDetail extends StatefulWidget {
  final Target target;
  final List<Target> listTarget;
  final int index;

  const TargetDetail({
    Key? key,
    required this.target,
    required this.listTarget,
    required this.index,
  }) : super(key: key);

  @override
  State<TargetDetail> createState() => _TargetDetailState();
}

class _TargetDetailState extends State<TargetDetail> {
  final _random = Random();
  final DateFormat df = DateFormat("dd-MM-yyyy");
  final NumberFormat nf = NumberFormat("###,###");
  double percentTarget = 0;
  final TextEditingController _moneyTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    percentTarget =
        (widget.target.currentMoney / widget.target.targetMoney) * 100;

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
            "Chi tiết mục tiêu",
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
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTarget(
                      target: widget.target,
                      listTarget: widget.listTarget,
                      index: widget.index,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: size.width * 0.02,
                right: size.width * 0.02,
                top: size.width * 0.04),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width * 0.045),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.primaries[
                                _random.nextInt(Colors.primaries.length)]
                            [_random.nextInt(9) * 100],
                      ),
                      child: (widget.target.urlImage == "")
                          ? Icon(
                              Icons.question_mark,
                              color: Colors.black,
                            )
                          : SvgPicture.asset(
                              widget.target.urlImage,
                              width: size.width * 0.1,
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.target.targetName,
                            style: TextStyle(
                              fontSize: size.width * 0.055,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Ngày hoàn thành: ",
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  df.format(widget.target.endDate),
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
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
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.1),
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: CircularPercentIndicator(
                      radius: size.width * 0.3,
                      progressColor: Color(0xff70E000),
                      percent: percentTarget / 100,
                      lineWidth: size.width * 0.06,
                      center: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _textInTargetDetail(
                                  text: (percentTarget == 0)
                                      ? "0"
                                      : percentTarget.toStringAsFixed(1),
                                  textColor: Color(0xff70E000),
                                  textSize: size.width * 0.055,
                                  textFontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                                _textInTargetDetail(
                                  text: " %",
                                  textColor: Color(0xff70E000),
                                  textSize: size.width * 0.055,
                                  textFontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.07),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    _textInTargetDetail(
                                      text:
                                          nf.format(widget.target.currentMoney),
                                      textColor: Colors.grey,
                                      textSize: size.width * 0.045,
                                      textFontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                    _textInTargetDetail(
                                      text: " / ",
                                      textColor: Colors.grey,
                                      textSize: size.width * 0.045,
                                      textFontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                    _textInTargetDetail(
                                      text:
                                          nf.format(widget.target.targetMoney),
                                      textColor: Colors.grey,
                                      textSize: size.width * 0.045,
                                      textFontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.05),
                            child: _textInTargetDetail(
                              text: "đ",
                              decoration: TextDecoration.underline,
                              textColor: Colors.grey,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.width * 0.07),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          _textInTargetDetail(
                            text: "Số tiền còn lại để đạt được mục tiêu",
                            textColor: Colors.black,
                            textSize: size.width * 0.04,
                            textFontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _textInTargetDetail(
                                  text: nf.format(widget.target.targetMoney -
                                      widget.target.currentMoney),
                                  textColor: Colors.black,
                                  textSize: size.width * 0.04,
                                  textFontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.01),
                                  child: _textInTargetDetail(
                                    text: "đ",
                                    textColor: Colors.black,
                                    textSize: size.width * 0.04,
                                    textFontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.width * 0.07),
                        child: Column(
                          children: [
                            _textInTargetDetail(
                              text: "Số tiền tích lũy gần nhất",
                              textColor: Colors.black,
                              textSize: size.width * 0.04,
                              textFontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.width * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _textInTargetDetail(
                                    text: "100,000",
                                    textColor: Colors.black,
                                    textSize: size.width * 0.04,
                                    textFontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.01),
                                    child: _textInTargetDetail(
                                      text: "đ",
                                      textColor: Colors.black,
                                      textSize: size.width * 0.04,
                                      textFontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.width * 0.1),
                  width: size.width,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _showEnterMoneyDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: size.width * 0.02,
                              bottom: size.width * 0.02,
                              right: size.width * 0.05,
                              left: size.width * 0.05),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.01),
                            color: Color(0xff70E000),
                          ),
                          child: _textInTargetDetail(
                            text: "THÊM SỐ TIỀN VÀO MỤC TIÊU",
                            textColor: Colors.white,
                            textSize: size.width * 0.05,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.width * 0.05),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(
                                top: size.width * 0.01,
                                bottom: size.width * 0.01,
                                right: size.width * 0.05,
                                left: size.width * 0.05),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.01),
                              color: Colors.white,
                            ),
                            child: _textInTargetDetail(
                              text: "HOÀN THÀNH MỤC TIÊU",
                              textColor: Colors.blue,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
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
    );
  }

  _showEnterMoneyDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.03),
          ),
          title: Container(
            alignment: Alignment.center,
            width: size.width,
            child: _textInTargetDetail(
              text: "Nhập số tiền tích lũy",
              textColor: Colors.black,
              textSize: size.width * 0.06,
              textFontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          content: TextField(
            controller: _moneyTextController,
            // autofocus: true,
            decoration: InputDecoration(
              hintText: "Số tiền",
              isDense: true,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: size.width * 0.3,
                padding: EdgeInsets.only(
                    top: size.width * 0.01,
                    bottom: size.width * 0.01,
                    left: size.width * 0.02,
                    right: size.width * 0.02),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: size.width * 0.003,
                    color: Colors.black,
                  ),
                ),
                child: _textInTargetDetail(
                  text: "Hủy",
                  textColor: Colors.black,
                  textSize: size.width * 0.05,
                  textFontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  double addMoney = double.parse(_moneyTextController.text);
                  if ((addMoney + widget.target.currentMoney >=
                      widget.target.targetMoney)) {
                    widget.target.currentMoney = widget.target.targetMoney;
                    widget.target.status = true;
                  } else {
                    widget.target.currentMoney += addMoney;
                  }
                });
                _moneyTextController.clear();
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: size.width * 0.3,
                padding: EdgeInsets.only(
                    top: size.width * 0.01,
                    bottom: size.width * 0.01,
                    left: size.width * 0.02,
                    right: size.width * 0.02),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blue,
                ),
                child: _textInTargetDetail(
                  text: "Xác nhận",
                  textColor: Colors.white,
                  textSize: size.width * 0.05,
                  textFontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        );
      },
    );
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
