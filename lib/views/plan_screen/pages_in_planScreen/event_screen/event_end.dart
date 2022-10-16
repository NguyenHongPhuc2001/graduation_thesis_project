import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/models/Event.dart';
import 'package:graduation_thesis_project/models/Transaction.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_detail.dart';
import 'package:intl/intl.dart';

class EventEnd extends StatefulWidget {
  final List<Event> listEvent;
  final List<Transactions> listTransaction;

  const EventEnd({
    Key? key,
    required this.listEvent,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<EventEnd> createState() => _EventEndState();
}

class _EventEndState extends State<EventEnd> {
  final _random = Random();
  final NumberFormat nf = NumberFormat("###,###");
  final List<Event> lsEventEnd = [];

  @override
  Widget build(BuildContext context) {
    lsEventEnd.clear();
    Size size = MediaQuery.of(context).size;
    widget.listEvent.forEach((element) {
      if (element.status == true) lsEventEnd.add(element);
    });

    print(lsEventEnd.length);
    return Scaffold(
      body: lsEventEnd.isEmpty
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
                  itemCount: lsEventEnd.length,
                  itemBuilder: (context, index) {
                    return (lsEventEnd.elementAt(index).status == false)
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(top: size.width * 0.07),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetail(
                                      event: lsEventEnd.elementAt(index),
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
                                      urlImage:
                                          lsEventEnd.elementAt(index).urlImage,
                                      iconSize: size.width * 0.073,
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
                                                text: lsEventEnd
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
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            TextContainer(
                                              text: nf.format(lsEventEnd
                                                  .elementAt(index)
                                                  .totalSpending),
                                              textColor: Colors.red,
                                              textSize: size.width * 0.035,
                                              textFontWeight: FontWeight.w500,
                                              decoration: TextDecoration.none,
                                            ),
                                            TextContainer(
                                              text: " đ",
                                              textColor: Colors.red,
                                              textSize: size.width * 0.035,
                                              textFontWeight: FontWeight.w500,
                                              decoration: TextDecoration.none,
                                            ),
                                          ],
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
