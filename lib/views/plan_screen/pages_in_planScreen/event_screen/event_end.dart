import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_detail.dart';
import 'package:intl/intl.dart';

class EventEnd extends StatefulWidget {
  final List<Event> listEvent;

  const EventEnd({
    Key? key,
    required this.listEvent,
  }) : super(key: key);

  @override
  State<EventEnd> createState() => _EventEndState();
}

class _EventEndState extends State<EventEnd> {
  bool isEmpty = false;
  final _random = Random();
  final nf = NumberFormat("###,###");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "icons/icons_1/calendar_icon_3.png",
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
                    padding: EdgeInsets.only(top: size.width*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Chọn nút "),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.01,
                              right: size.width * 0.01),
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
                  itemCount: widget.listEvent.length,
                  itemBuilder: (context, index) {
                    return widget.listEvent.elementAt(index).status
                        ? Padding(
                            padding: EdgeInsets.only(top: size.width * 0.07),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetail(
                                      event: widget.listEvent.elementAt(index),
                                    ),
                                  ),
                                ).then((value) => setState(() {
                                      widget.listEvent.elementAt(index).status =
                                          value;
                                    }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(size.width * 0.02),
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: size.width * 0.001,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.all(size.width * 0.05),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.primaries[_random.nextInt(
                                                Colors.primaries.length)]
                                            [_random.nextInt(9) * 100],
                                      ),
                                      child: Image.asset(
                                        "icons/icons_1/wallet_icon_1.png",
                                        width: size.width * 0.06,
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
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: size.width * 0.03),
                                                child: Text(
                                                  widget.listEvent
                                                      .elementAt(index)
                                                      .eventName,
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.width * 0.045,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Text("Đã chi"),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                (nf.format(widget.listEvent
                                                    .elementAt(index)
                                                    .totalSpending)),
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.01),
                                                child: Text(
                                                  "đ",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
