import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_thesis_project/model/target.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TargetEnd extends StatefulWidget {
  final List<Target> listTarget;

  const TargetEnd({
    Key? key,
    required this.listTarget,
  }) : super(key: key);

  @override
  State<TargetEnd> createState() => _TargetEndState();
}

class _TargetEndState extends State<TargetEnd> {
  bool isEmpty = false;
  final _random = Random();
  final nf = NumberFormat("###,###");
  double targetPercent = 0;
  final List<Target> listTargetEnd = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    listTargetEnd.clear();

    widget.listTarget.forEach((element) {
      if (element.status == true) {
        listTargetEnd.add(element);
      }
    });

    return Scaffold(
      body: listTargetEnd.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "icons/icons_1/target_icon_1.png",
                    width: size.width * 0.5,
                  ),
                  Text(
                    "Không có sự kiện",
                    style: TextStyle(
                      fontSize: size.width * 0.09,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
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
                  itemCount: listTargetEnd.length,
                  itemBuilder: (context, index) {
                    targetPercent =
                        (listTargetEnd.elementAt(index).currentMoney /
                                listTargetEnd.elementAt(index).targetMoney) *
                            100;

                    return (listTargetEnd.elementAt(index).status == true)
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 0.07,
                                bottom: size.width * 0.07),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: size.width * 0.001,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(size.width * 0.04),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.primaries[
                                                  _random.nextInt(
                                                      Colors.primaries.length)]
                                              [_random.nextInt(9) * 100],
                                        ),
                                        child: (listTargetEnd
                                                    .elementAt(index)
                                                    .urlImage ==
                                                "")
                                            ? Icon(
                                                Icons.question_mark,
                                                color: Colors.grey,
                                                size: size.width * 0.08,
                                              )
                                            : SvgPicture.asset(
                                                listTargetEnd
                                                    .elementAt(index)
                                                    .urlImage,
                                                width: size.width * 0.08,
                                              ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02),
                                          child: Text(
                                            listTargetEnd
                                                .elementAt(index)
                                                .targetName,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.05,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              bottom: size.width * 0.01,
                                              top: size.width * 0.01),
                                          child: Container(
                                            width: size.width * 0.65,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      nf.format(listTargetEnd
                                                          .elementAt(index)
                                                          .currentMoney),
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.03,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: size.width *
                                                              0.01),
                                                      child: Text(
                                                        "đ",
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.width * 0.03,
                                                          color: Colors.black,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      (targetPercent != 0)
                                                          ? targetPercent
                                                              .toStringAsFixed(
                                                                  1)
                                                          : "0",
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.03,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      "%",
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.03,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.width * 0.01),
                                          child: LinearPercentIndicator(
                                            barRadius: Radius.circular(
                                                size.width * 0.008),
                                            lineHeight: size.width * 0.02,
                                            percent: targetPercent/100,
                                            progressColor: Colors.green,
                                            width: size.width * 0.7,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  }),
            ),
    );
  }
}
