import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/dao/target_dao.dart';
import 'package:graduation_thesis_project/model/target.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/target_screen/target_detail.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TargetHappening extends StatefulWidget {
  final List<Target> listTarget;

  const TargetHappening({
    Key? key,
    required this.listTarget,
  }) : super(key: key);

  @override
  State<TargetHappening> createState() => _TargetHappeningState();
}

class _TargetHappeningState extends State<TargetHappening> {
  bool isEmpty = false;
  final _random = Random();
  final nf = NumberFormat("###,###");
  double targetPercent = 0;
  final List<Target> listTargetHappening = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    listTargetHappening.clear();
    widget.listTarget.forEach((element) {
      if (element.status == false) listTargetHappening.add(element);
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
                          child: Container(
                            width: size.width * 0.13,
                            padding: EdgeInsets.only(
                                top: size.width * 0.015,
                                bottom: size.width * 0.015,
                                right: size.width * 0.03,
                                left: size.width * 0.03),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.1),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Thêm",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                    targetPercent = (listTargetHappening
                                .elementAt(index)
                                .currentMoney /
                            listTargetHappening.elementAt(index).targetMoney) *
                        100;

                    return (listTargetHappening.elementAt(index).status ==
                            false)
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 0.07,
                                bottom: size.width * 0.07),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TargetDetail(
                                      target:
                                          listTargetHappening.elementAt(index),
                                      listTarget: widget.listTarget,
                                      index: index,
                                    ),
                                  ),
                                ).then((value) => setState(() {
                                      if (value == "Delete")
                                        Fluttertoast.showToast(
                                            msg: "Xóa mục tiêu thành công !");
                                    }));
                              },
                              child: SingleRowContainer(
                                paddingTop: size.width * 0.02,
                                paddingBottom: size.width * 0.02,
                                boxDecoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      width: size.width * 0.0015,
                                      color: Colors.black,
                                    ),
                                    bottom: BorderSide(
                                      width: size.width * 0.0015,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                children: [
                                  Container(
                                    width: size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width * 0.2,
                                          child: CircleIconContainer(
                                            urlImage: listTargetHappening
                                                .elementAt(index)
                                                .urlImage,
                                            iconSize: size.width * 0.08,
                                            backgroundColor: Colors.yellow,
                                            padding: size.width*0.045,
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 0.78,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextContainer(
                                                text: listTargetHappening
                                                    .elementAt(index)
                                                    .targetName,
                                                textColor: Colors.black,
                                                textSize: size.width * 0.05,
                                                textFontWeight: FontWeight.bold,
                                                decoration: TextDecoration.none,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  MoneyTextContainer(
                                                    value: listTargetHappening
                                                        .elementAt(index)
                                                        .currentMoney,
                                                    textSize: size.width * 0.03,
                                                    textFontWeight:
                                                        FontWeight.w300,
                                                    color: Colors.black,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: size.width*0.02),
                                                    child: MoneyTextContainer(
                                                      value: listTargetHappening
                                                          .elementAt(index)
                                                          .currentMoney,
                                                      textSize: size.width * 0.03,
                                                      textFontWeight:
                                                      FontWeight.w300,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: size.width*0.02),
                                                child: LinearPercentIndicator(
                                                  padding: EdgeInsets.only(right: size.width*0.02),
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
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  }),
            ),
    );
  }
}
