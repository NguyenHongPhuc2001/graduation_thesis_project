import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/goal_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_detail.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../models/goal.dart';
import '../../../commons/widgets/custom_round_rectangle_button.dart';
import '../../../commons/widgets/percent_text_container.dart';
import '../../../commons/widgets/single_row_container_2.dart';

class TargetEnd extends StatefulWidget {

   const TargetEnd({
    Key? key,
  }) : super(key: key);

  @override
  State<TargetEnd> createState() => _TargetEndState();
}

class _TargetEndState extends State<TargetEnd> {
  bool isEmpty = false;
  final nf = NumberFormat("###,###");
  double targetPercent = 0;
  List<Goal> listTargetEnd = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoalController().getByStatus(true).then((value) {
      setState((){
        listTargetEnd = List.from(value);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: listTargetEnd.isEmpty
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
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chọn nút "),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CustomRoundRectangleButton(
                      onTap: () {},
                      buttonWith: size.width * 0.13,
                      padding: size.width * 0.01,
                      borderRadius: size.width * 0.02,
                      text: TextContainer(
                        text: "Thêm",
                        textColor: const Color(0xffffffff),
                        textSize: size.width * 0.02,
                        textFontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  const Text("để thêm mục tiêu"),
                ],
              ),
            ),
          ],
        ),
      )
          : SizedBox(
        width: size.width,
        child: ListView.builder(
            itemCount: listTargetEnd.length,
            itemBuilder: (context, index) {
              targetPercent =
              (listTargetEnd.elementAt(index).goalPresentCost /
                  listTargetEnd
                      .elementAt(index)
                      .goalFinalCost);

              return Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.07),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TargetDetail(
                          target: listTargetEnd.elementAt(index),
                        ),
                      ),
                    ).then((value) => setState(() {
                      if (value == "Delete") {
                        GoalController()
                            .getByStatus(true)
                            .then((value) {
                          setState(() {
                            listTargetEnd = List.from(value);
                          });
                        });

                        Fluttertoast.showToast(
                            msg: "Xóa mục tiêu thành công !");
                      } else if (value == "Cancle") {
                        GoalController()
                            .getByStatus(true)
                            .then((value) {
                          setState(() {
                            listTargetEnd = List.from(value);
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.23,
                            child: CircleIconContainer(
                              urlImage: listTargetEnd
                                  .elementAt(index)
                                  .goalIcon,
                              iconSize: size.width * 0.08,
                              backgroundColor: Color(int.parse(listTargetEnd.elementAt(index).goalColor)),
                              padding: size.width * 0.045,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.7,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                TextContainer(
                                  text: listTargetEnd
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
                                      value: listTargetEnd
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
                                        value: (targetPercent*100).toStringAsFixed(1),
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
                                    percent: targetPercent > 1.0 ? 1.0 : targetPercent,
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
