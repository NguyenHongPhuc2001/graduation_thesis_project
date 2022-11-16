import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/goal_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/percent_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_detail.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../models/goal.dart';
import '../../../commons/widgets/custom_round_rectangle_button.dart';
import '../../../commons/widgets/single_row_container_2.dart';

class TargetHappening extends StatefulWidget {
   List<Goal> listTarget;

   TargetHappening({
    Key? key,
    required this.listTarget,
  }) : super(key: key);

  @override
  State<TargetHappening> createState() => _TargetHappeningState();
}

class _TargetHappeningState extends State<TargetHappening> {
  bool isEmpty = false;
  final nf = NumberFormat("###,###");
  double targetPercent = 0;
  final List<Goal> listTargetHappening = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoalController().getListGoal("Phuc").then((value) {
      value.forEach((item) {
        if (item.goalStatus == false) listTargetHappening.add(item);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    listTargetHappening.clear();
    widget.listTarget.forEach((element) {
      setState(() {
        if (element.goalStatus == false) listTargetHappening.add(element);
      });
    });

    return Scaffold(
      body: listTargetHappening.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "images/TargetIcon.svg",
                    width: size.width * 0.5,
                  ),
                  TextContainer(
                    text: "Không có sự kiện",
                    textColor: Colors.black,
                    textSize: size.width * 0.09,
                    textFontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Chọn nút "),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: CustomRoundRectangleButton(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.grey,
                                blurRadius: size.width * 0.02,
                                spreadRadius: size.width*0.001,
                              ),
                            ],
                            onTap: () {},
                            buttonWith: size.width * 0.13,
                            padding: size.width * 0.01,
                            borderRadius: size.width * 0.02,
                            text: TextContainer(
                              text: "Thêm",
                              textColor: Color(0xffFB8500),
                              textSize: size.width * 0.02,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Text("để thêm mục tiêu"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: size.width,
              child: ListView.builder(
                  itemCount: listTargetHappening.length,
                  itemBuilder: (context, index) {
                    targetPercent =
                        (listTargetHappening.elementAt(index).goalPresentCost /
                            listTargetHappening.elementAt(index).goalFinalCost);
                    return Padding(
                      padding: EdgeInsets.only(top: size.width * 0.07),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TargetDetail(
                                target: listTargetHappening.elementAt(index),
                              ),
                            ),
                          ).then((value) => setState(() {
                                if (value == "Delete") {
                                  widget.listTarget.clear();
                                  GoalController()
                                      .getListGoal("Phuc")
                                      .then((value) {
                                    value.forEach((element) {
                                      setState(() {
                                        widget.listTarget.add(element);
                                      });
                                    });
                                  });

                                  Fluttertoast.showToast(
                                      msg: "Xóa mục tiêu thành công !");
                                } else if (value == "Cancle") {
                                  widget.listTarget.clear();
                                  GoalController()
                                      .getListGoal("Phuc")
                                      .then((value) {
                                    value.forEach((element) {
                                      setState(() {
                                        widget.listTarget.add(element);
                                      });
                                    });
                                  });
                                }
                              }));
                        },
                        child: SingleRowContainer2(
                          paddingTop: size.width * 0.02,
                          paddingBottom: size.width * 0.02,
                          paddingLeft: 0,
                          paddingRight: 0,
                          background: Colors.white,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: size.width * 0.23,
                                  child: CircleIconContainer(
                                    urlImage: listTargetHappening
                                        .elementAt(index)
                                        .goalIcon,
                                    iconSize: size.width * 0.08,
                                    backgroundColor: Color(int.parse(
                                        listTargetHappening
                                            .elementAt(index)
                                            .goalColor)),
                                    padding: size.width * 0.045,
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextContainer(
                                        text: listTargetHappening
                                            .elementAt(index)
                                            .goalName,
                                        textColor: Colors.black,
                                        textSize: size.width * 0.05,
                                        textFontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MoneyTextContainer(
                                            value: listTargetHappening
                                                .elementAt(index)
                                                .goalPresentCost
                                                .toDouble(),
                                            textSize: size.width * 0.03,
                                            textFontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.02),
                                            child: PercentTextContainer(
                                              value: (targetPercent * 100)
                                                  .toStringAsFixed(1),
                                              textSize: size.width * 0.03,
                                              textFontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: size.width * 0.02),
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.only(
                                              right: size.width * 0.02),
                                          barRadius: Radius.circular(
                                              size.width * 0.008),
                                          lineHeight: size.width * 0.02,
                                          percent: targetPercent,
                                          progressColor: Colors.green,
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
                    );
                  }),
            ),
    );
  }
}
