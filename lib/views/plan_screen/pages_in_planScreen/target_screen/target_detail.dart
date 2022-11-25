import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/goal_controller.dart';
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

import '../../../../models/goal.dart';

class TargetDetail extends StatefulWidget {
  final Goal target;

  const TargetDetail({
    Key? key,
    required this.target,
  }) : super(key: key);

  @override
  State<TargetDetail> createState() => _TargetDetailState();
}

class _TargetDetailState extends State<TargetDetail> {
  final DateFormat df = DateFormat("dd-MM-yyyy");
  final NumberFormat nf = NumberFormat("###,###");
  double percentTarget = 0;
  final _moneyTextController = MoneyMaskedTextController(
      thousandSeparator: ',',
      decimalSeparator: '',
      initialValue: 0,
      precision: 0);
  var goalName,
      goalEndDate,
      goalPresentCost,
      goalFinalCost,
      goalIcon,
      goalColor,
      target;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goalName = widget.target.goalName;
    goalEndDate = widget.target.goalEndDate;
    goalPresentCost = widget.target.goalPresentCost;
    goalFinalCost = widget.target.goalFinalCost;
    target = widget.target;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (goalPresentCost != null && goalFinalCost != null) {
      percentTarget = (goalPresentCost / goalFinalCost);
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.15),
          child: AppBarContainer2(
              text: "Chi tiết",
              backIcon: Icons.arrow_back,
              prefixIcon1: Icons.edit,
              prefixIcon2: Icons.delete,
              onBackTap: () {
                Navigator.pop(context, "Cancle");
              },
              onPrefixIcon1Tap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTarget(
                      target: target,
                    ),
                  ),
                ).then((value) {
                  if (value == "Update") {
                    Fluttertoast.showToast(msg: "Update success!");
                    GoalController()
                        .getOneGoal(widget.target.goalId)
                        .then((value) {
                      setState(() {
                        target = value;
                      });
                    });
                  }
                });
              },
              onPrefixIcon2Tap: () {
                _showDeleteDialog(target);
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
                      urlImage: target.goalIcon,
                      iconSize: size.width * 0.1,
                      backgroundColor:
                          Color(int.parse(widget.target.goalColor)),
                      padding: size.width * 0.045,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextContainer(
                            text: target.goalName,
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
                                  text: target.goalEndDate,
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
                      progressColor: Color(int.parse(target.goalColor)),
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
                                  value:
                                      (percentTarget * 100).toStringAsFixed(1),
                                  textSize: size.width * 0.055,
                                  textFontWeight: FontWeight.bold,
                                  color: Color(int.parse(target.goalColor)),
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
                                                (goalPresentCost != null)
                                                    ? goalPresentCost
                                                    : target.goalPresentCost),
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
                                            text:
                                                nf.format(target.goalFinalCost),
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
                                  value: target.goalFinalCost - goalPresentCost,
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
                  backgroundColor: Color(int.parse(widget.target.goalColor)),
                  onTap: () {
                    _showEnterMoneyDialog();
                  },
                  buttonWith: size.width * 0.8,
                  padding: size.width * 0.03,
                  borderRadius: size.width * 0.02,
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
                // CustomRoundRectangleButton(
                //   backgroundColor: Colors.transparent,
                //   onTap: () async {
                //     await GoalController().updateGoal(
                //         target.goalId,
                //         target.goalName,
                //         target.goalIcon,
                //         target.goalEndDate,
                //         target.goalFinalCost,
                //         target.goalColor,
                //         target.goalPresentCost,
                //         true).then((value) {
                //           Navigator.pop(context,"Finish");
                //     });
                //   },
                //   buttonWith: size.width * 0.8,
                //   padding: size.width * 0.03,
                //   borderRadius: size.width * 0.02,
                //   text: TextContainer(
                //     text: "HOÀN THÀNH MỤC TIÊU",
                //     textColor: Color(int.parse(widget.target.goalColor)),
                //     textSize: size.width * 0.05,
                //     textFontWeight: FontWeight.bold,
                //     decoration: TextDecoration.none,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showEnterMoneyDialog() {
    Size size = MediaQuery.of(context).size;
    _moneyTextController.clear();
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
            keyboardType: TextInputType.number,
            controller: _moneyTextController,
            decoration: InputDecoration(
              hintText: "Số tiền",
              isDense: true,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            CustomRoundRectangleButton(
              onTap: () {
                Navigator.pop(context);
              },
              buttonWith: size.width * 0.3,
              padding: size.width * 0.02,
              borderRadius: size.width * 0.01,
              text: TextContainer(
                text: "HỦY",
                textColor: Colors.black,
                textSize: size.width * 0.03,
                textFontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              backgroundColor: Colors.white,
              border: Border.all(
                width: size.width * 0.005,
                color: Colors.grey,
              ),
            ),
            CustomRoundRectangleButton(
              onTap: () {
                setState(() {
                  if (goalName != null &&
                      goalPresentCost != null &&
                      goalFinalCost != null &&
                      goalEndDate != null) {
                    GoalController()
                        .updateGoal(
                            widget.target.goalId,
                            widget.target.goalName,
                            widget.target.goalIcon,
                            widget.target.goalEndDate,
                            widget.target.goalFinalCost,
                            widget.target.goalColor,
                            goalPresentCost + _moneyTextController.numberValue,
                    target.goalStatus)
                        .then((value) {
                      GoalController()
                          .getOneGoal(widget.target.goalId)
                          .then((value) {
                        setState(() {
                          goalName = value.goalName;
                          goalIcon = value.goalIcon;
                          goalEndDate = value.goalEndDate;
                          goalFinalCost = value.goalFinalCost;
                          goalPresentCost = value.goalPresentCost;
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Add money success!");
                        });
                      });
                    });
                  }
                });
              },
              buttonWith: size.width * 0.3,
              padding: size.width * 0.02,
              borderRadius: size.width * 0.01,
              text: TextContainer(
                text: "XÁC NHẬN",
                textColor: Colors.white,
                textSize: size.width * 0.03,
                textFontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              backgroundColor: Color(0xff2B4BF2),
            ),
          ],
        );
      },
    );
  }

  _showDeleteDialog(Goal tg) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
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
                      text: "${tg.goalName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(text: " chứ ?"),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              CustomRoundRectangleButton(
                onTap: () {
                  Navigator.pop(context);
                },
                buttonWith: size.width * 0.3,
                padding: size.width * 0.02,
                borderRadius: size.width * 0.01,
                text: TextContainer(
                  text: "HỦY",
                  textColor: Colors.black,
                  textSize: size.width * 0.03,
                  textFontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
                backgroundColor: Colors.white,
                border: Border.all(
                  width: size.width * 0.005,
                  color: Colors.grey,
                ),
              ),
              CustomRoundRectangleButton(
                onTap: () {
                  setState(() async{
                    await GoalController()
                        .deleteGoal(target.goalId)
                        .then((value) {
                      Navigator.pop(context);
                      Navigator.pop(context, "Delete");
                    });
                  });
                },
                buttonWith: size.width * 0.3,
                padding: size.width * 0.02,
                borderRadius: size.width * 0.01,
                text: TextContainer(
                  text: "XÁC NHẬN",
                  textColor: Colors.white,
                  textSize: size.width * 0.03,
                  textFontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
                backgroundColor: Color(0xff2B4BF2),
              ),
            ],
          );
        });
  }
}
