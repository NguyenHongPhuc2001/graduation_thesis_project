import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_thesis_project/models/target.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container_2.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/percent_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_screen.dart';
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
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    percentTarget =
        (widget.target.currentMoney / widget.target.targetMoney) * 100;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        //   centerTitle: true,
        //   title: Text(
        //     "Chi tiết mục tiêu",
        //     style: TextStyle(
        //       fontSize: size.width * 0.065,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black,
        //     ),
        //   ),
        //   actions: [
        //     IconButton(
        //       splashRadius: size.width * 0.07,
        //       icon: Icon(
        //         Icons.edit,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => UpdateTarget(
        //               target: widget.target,
        //               listTarget: widget.listTarget,
        //               index: widget.index,
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // ),
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.15),
          child: AppBarContainer2(
              text: "Chi tiết",
              backIcon: Icons.arrow_back,
              prefixIcon1: Icons.edit,
              prefixIcon2: Icons.delete,
              onBackTap: () {
                Navigator.pop(context);
              },
              onPrefixIcon1Tap: () {
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
              onPrefixIcon2Tap: () {
                _showDeleteDialog(widget.target);
              }),
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
                    CircleIconContainer(
                        urlImage: widget.target.urlImage,
                        iconSize: size.width * 0.1,
                        backgroundColor: Colors.blueAccent,padding: size.width*0.045,),
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextContainer(
                            text: widget.target.targetName,
                            textColor: Colors.black,
                            textSize: size.width * 0.055,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextContainer(
                                  text: "Ngày hoàn thành: ",
                                  textColor: Colors.black,
                                  textSize: size.width * 0.04,
                                  textFontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                ),
                                TextContainer(
                                  text: df.format(widget.target.endDate),
                                  textColor: Colors.black,
                                  textSize: size.width * 0.04,
                                  textFontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
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
                      percent: percentTarget,
                      lineWidth: size.width * 0.06,
                      center: Container(
                        padding: EdgeInsets.only(top: size.width * 0.15),
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                PercentTextContainer(
                                  value: "0",
                                  textSize: size.width * 0.055,
                                  textFontWeight: FontWeight.bold,
                                  color: Colors.lightGreen,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.width * 0.07),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          TextContainer(
                                            text: nf.format(
                                                widget.target.currentMoney),
                                            textColor: Colors.grey,
                                            textSize: size.width * 0.045,
                                            textFontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                          ),
                                          TextContainer(
                                            text: "/",
                                            textColor: Colors.grey,
                                            textSize: size.width * 0.045,
                                            textFontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                          ),
                                          TextContainer(
                                            text: nf.format(
                                                widget.target.targetMoney),
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
                                  padding:
                                      EdgeInsets.only(top: size.width * 0.05),
                                  child: TextContainer(
                                    text: "đ",
                                    textColor: Colors.grey,
                                    textSize: size.width * 0.05,
                                    textFontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.width * 0.07),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              TextContainer(
                                text: "Số tiền còn lại để đạt được mục tiêu",
                                textColor: Colors.grey,
                                textSize: size.width * 0.045,
                                textFontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.width * 0.03),
                                child: MoneyTextContainer(
                                  value: widget.target.targetMoney -
                                      widget.target.currentMoney,
                                  textSize: size.width * 0.04,
                                  textFontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.05),
                            child: Column(
                              children: [
                                TextContainer(
                                  text: "Số tiền tích lũy gần nhất",
                                  textColor: Colors.grey,
                                  textSize: size.width * 0.045,
                                  textFontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.width * 0.03),
                                  child: MoneyTextContainer(
                                    value: 1000000,
                                    textSize: size.width * 0.04,
                                    textFontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                CustomRoundRectangleButton(
                  backgroundColor: Colors.lightGreen,
                  onTap: () {
                    _showEnterMoneyDialog();
                  },
                  buttonWith: size.width * 0.8,
                  padding: size.width * 0.03,
                  borderRadius: size.width * 0.01,
                  text: TextContainer(
                    text: "THÊM SỐ TIỀN VÀO MỤC TIÊU",
                    textColor: Colors.white,
                    textSize: size.width * 0.05,
                    textFontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                CustomRoundRectangleButton(
                  backgroundColor: Colors.transparent,
                  onTap: () {},
                  buttonWith: size.width * 0.8,
                  padding: size.width * 0.03,
                  borderRadius: size.width * 0.01,
                  text: TextContainer(
                    text: "HOÀN THÀNH MỤC TIÊU",
                    textColor: Colors.lightGreen,
                    textSize: size.width * 0.05,
                    textFontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
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
            child: TextContainer(
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
                child: TextContainer(
                  text: "Hủy",
                  textColor: Colors.black,
                  textSize: size.width * 0.05,
                  textFontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
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
                child: TextContainer(
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
