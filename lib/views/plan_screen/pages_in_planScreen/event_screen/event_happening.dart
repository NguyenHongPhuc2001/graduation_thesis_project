import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_detail.dart';
import 'package:intl/intl.dart';

import '../../../../models/event.dart';
import '../../../commons/widgets/single_row_container_2.dart';

class EventHappening extends StatefulWidget {

    List<Event> listEvent;
  final List<Expense> listTransaction;

    EventHappening({
    Key? key,
    required this.listEvent,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<EventHappening> createState() => _EventHappeningState();
}

class _EventHappeningState extends State<EventHappening> {
  bool isEmpty = false;

  final NumberFormat nf = NumberFormat("###,###");

  final List<Event> lsEventHappenning = [];
  var val;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // EventAPI().getList("Phuc").then((value) {
    //   setState(() {
    //     value.forEach((element) {
    //       if (element.eventStatus == false) {
    //         lsEventHappenning.add(element);
    //       }
    //     });
    //   });
    // }, onError: (e) {
    //   print(e);
    // });
    EventController().getListEvent("Phuc").then((value) {
      value.forEach((element) {
        if(element.eventStatus==false){
          setState(() {
            lsEventHappenning.add(element);
          });
        }
      });
    }, onError: (e){
      e.printError();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    lsEventHappenning.clear();
    widget.listEvent.forEach((item) {
      if (item.eventStatus == false) {
        setState(() {
          lsEventHappenning.add(item);
        });
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      return lsEventHappenning.elementAt(index).eventStatus
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(top: size.width * 0.07),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventDetail(
                                        event:
                                            lsEventHappenning.elementAt(index),
                                      ),
                                    ),
                                  ).then((value) => setState(() {
                                        if (value == "Delete") {
                                          widget.listEvent.clear();
                                          // EventAPI().getList("Phuc").then(
                                          //     (value) =>
                                          //         value.forEach((element) {
                                          //           setState(() {
                                          //             widget.listEvent
                                          //                 .add(element);
                                          //           });
                                          //         }));


                                          EventController().getListEvent("Phuc").then((value) {
                                            setState(() {
                                              value.forEach((element) {
                                                widget.listEvent.add(element);
                                              });
                                            });
                                          });

                                          Fluttertoast.showToast(
                                              msg: "Xóa sự kiện thành công !");
                                        } else if (value == "Cancle") {
                                          widget.listEvent.clear();
                                          // EventAPI().getList("Phuc").then(
                                          //     (value) =>
                                          //         value.forEach((element) {
                                          //           setState(() {
                                          //             widget.listEvent
                                          //                 .add(element);
                                          //           });
                                          //         }));
                                          EventController().getListEvent("Phuc").then((value) {
                                            setState(() {
                                              value.forEach((element) {
                                                widget.listEvent.add(element);
                                              });
                                            });
                                          });
                                        }
                                      }));
                                },
                                child: SingleRowContainer2(
                                  paddingLeft: size.width * 0.01,
                                  paddingRight: size.width * 0.01,
                                  paddingTop: size.width * 0.02,
                                  paddingBottom: size.width * 0.02,
                                  background: Colors.white,
                                  children: [
                                    Container(
                                      width: size.width * 0.2,
                                      child: CircleIconContainer(
                                        urlImage: lsEventHappenning
                                            .elementAt(index)
                                            .eventIcon,
                                        iconSize: size.width * 0.045,
                                        backgroundColor: Color(0xffFB8500),
                                        padding: size.width * 0.045,
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
                                                  textFontWeight:
                                                      FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              Text(
                                                "Đã chi",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.01),
                                            child: MoneyTextContainer(
                                              value: 0,
                                              textSize: size.width * 0.035,
                                              textFontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
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
      ),
    );
  }
}
