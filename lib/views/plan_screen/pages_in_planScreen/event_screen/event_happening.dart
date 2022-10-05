import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/dao/envent_dao.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_detail.dart';
import 'package:intl/intl.dart';

class EventHappening extends StatefulWidget {
  final List<Event> listEvent;
  final List<Transactions> listTransaction;

  const EventHappening({
    Key? key,
    required this.listEvent,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<EventHappening> createState() => _EventHappeningState();
}

class _EventHappeningState extends State<EventHappening> {
  bool isEmpty = false;

  final _random = Random();
  final NumberFormat nf = NumberFormat("###,###");
  final List<Event> lsEventHappenning = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    lsEventHappenning.clear();
    widget.listEvent.forEach((element) {
      if (element.status == false) lsEventHappenning.add(element);
    });

    return Scaffold(
      body: lsEventHappenning.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "images/CalendarIcon_2.svg",
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
                        Text("để thêm sự kiện"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: size.width,
              child: ListView.builder(
                  itemCount: lsEventHappenning.length,
                  itemBuilder: (context, index) {
                    return lsEventHappenning.elementAt(index).status
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(top: size.width * 0.07),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetail(
                                      event: lsEventHappenning.elementAt(index),
                                      listEvent: widget.listEvent,
                                    ),
                                  ),
                                ).then((value) => setState(() {
                                      if (value == "Delete") {
                                        Fluttertoast.showToast(
                                            msg: "Xóa sự kiện thành công !");
                                      } else if (value == "Save") {
                                        Fluttertoast.showToast(
                                            msg: "Thêm sự kiện thành công !");
                                      }
                                    }));
                              },
                              child: SingleRowContainer(
                                boxDecoration: BoxDecoration(
                                  border: Border.all(
                                      width: size.width * 0.001,
                                      color: Colors.black),
                                ),
                                paddingTop: size.width * 0.02,
                                paddingBottom: size.width * 0.02,
                                children: [
                                  Container(
                                    width: size.width * 0.2,
                                    child: CircleIconContainer(
                                      urlImage: lsEventHappenning
                                          .elementAt(index)
                                          .urlImage,
                                      iconSize: size.width * 0.08,
                                      backgroundColor: Colors.lightGreenAccent,
                                      padding: size.width*0.045,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.7,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: size.width * 0.03),
                                              child: TextContainer(
                                                text: lsEventHappenning
                                                    .elementAt(index)
                                                    .eventName,
                                                textColor: Colors.black,
                                                textSize: size.width * 0.045,
                                                textFontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            Text("Đã chi"),
                                          ],
                                        ),
                                        MoneyTextContainer(
                                          value: lsEventHappenning
                                              .elementAt(index)
                                              .totalSpending,
                                          textSize: size.width * 0.035,
                                          textFontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
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
