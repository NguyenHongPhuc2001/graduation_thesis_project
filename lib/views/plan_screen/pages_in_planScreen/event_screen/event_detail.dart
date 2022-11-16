import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/remote/api/Event_API.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container_2.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_updateEvent.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/list_transaction.dart';
import 'package:intl/intl.dart';

import '../../../../models/event.dart';

class EventDetail extends StatefulWidget {
  final Event event;

  const EventDetail({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final PageController _pageController = PageController();
  final DateFormat df = DateFormat("yyy-MM-dd");
  var event, check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // EventAPI().getOne(widget.event.eventId!).then((value) {
    //   setState(() {
    //     event = value as Event;
    //     check = value.eventStatus;
    //   });
    // });
    EventController().getOneEvent(widget.event.eventId!).then((value) {
      setState(() {
        event = value as Event;
        check = event.eventStatus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Expense> lsTransaction = [];
    final Duration dayLeft =
        DateTime.parse(widget.event.eventEndDate).difference(DateTime.now());

    DateTime dateTime = DateTime.parse(event.eventEndDate);
    String correctDate =
        "${dateTime.year}-${dateTime.month}-${dateTime.day + 1}";

    print(dateTime);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.15),
          child: AppBarContainer2(
              text: "Chi tiết",
              backIcon: CupertinoIcons.xmark,
              prefixIcon1: Icons.edit,
              prefixIcon2: Icons.delete,
              onBackTap: () async {
                Navigator.pop(context, "Cancle");
              },
              onPrefixIcon1Tap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateEvent(
                      event: widget.event,
                    ),
                  ),
                ).then((value) => setState(() {
                      if (value == "Update") {
                        // EventAPI().getOne(widget.event.eventId!).then((value) {
                        //   setState(() {
                        //     event = value as Event;
                        //   });
                        // });
                        event = EventController()
                            .getOneEvent(widget.event.eventId!);
                        Fluttertoast.showToast(msg: "Update success !");
                      }
                    }));
              },
              onPrefixIcon2Tap: () {
                _showDeleteDialog(widget.event);
              }),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleRowContainer(
                    width: size.width * 0.9,
                    boxDecoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5),
                          color: Colors.grey,
                          blurRadius: size.width * 0.02,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(size.width * 0.05),
                      color: Color(0xffedf2f4),
                    ),
                    mainAxisAlignment: MainAxisAlignment.center,
                    paddingTop: size.width * 0.03,
                    paddingBottom: size.width * 0.03,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleIconContainer(
                            urlImage: (event != null)
                                ? event.eventIcon
                                : widget.event.eventIcon,
                            iconSize: size.width * 0.1,
                            backgroundColor: Colors.green,
                            padding: size.width * 0.045,
                          ),
                          SizedBox(
                            height: size.width * 0.03,
                          ),
                          TextContainer(
                            text: (event != null)
                                ? event.eventName
                                : widget.event.eventName,
                            textColor: Colors.black,
                            textSize: size.width * 0.06,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SingleRowContainer(
                    paddingTop: size.width * 0.1,
                    paddingBottom: size.width * 0.01,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.3,
                        child: CircleIconContainer(
                          urlImage: "images/CalendarIcon_4.svg",
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.transparent,
                          padding: size.width * 0.045,
                        ),
                      ),
                      Container(
                        width: size.width * 0.62,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextContainer(
                              text: correctDate,
                              textColor: Colors.black,
                              textSize: size.width * 0.06,
                              textFontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                            TextContainer(
                              text: "Còn ${dayLeft.inDays} ngày",
                              textColor: Colors.black,
                              textSize: size.width * 0.03,
                              textFontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SingleRowContainer(
                    paddingTop: size.width * 0.01,
                    paddingBottom: size.width * 0.01,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.3,
                        child: CircleIconContainer(
                          urlImage: "images/WalletIcon_1.svg",
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.transparent,
                          padding: size.width * 0.045,
                        ),
                      ),
                      Container(
                        width: size.width * 0.62,
                        child: TextContainer(
                          text: (event != null)
                              ? event.wallet!.walletName
                              : ((widget.event.wallet != null)
                                  ? widget.event.wallet!.walletName
                                  : "Không có ví"),
                          textColor: Colors.black,
                          textSize: size.width * 0.06,
                          textFontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (check == true)
                      ? CustomRoundRectangleButton(
                          backgroundColor: Color(0xff3a86ff),
                          onTap: () {
                            setState(() {
                              if (check != null) {
                                check = !check;
                                // EventAPI()
                                //     .update(
                                //         widget.event.eventId!,
                                //         widget.event.eventName,
                                //         widget.event.eventIcon,
                                //         widget.event.eventEndDate,
                                //         int.parse(widget.event.wallet!.walletId
                                //             .toString()),
                                //         "Phuc",
                                //         check)
                                //     .then((value) {
                                //   event.eventStatus = check;
                                // });
                                EventController().updateEvent(
                                    widget.event.eventId!,
                                    widget.event.eventName,
                                    widget.event.eventIcon,
                                    widget.event.eventEndDate,
                                    int.parse(widget.event.wallet!.walletId
                                        .toString()),
                                    "Phuc",
                                    check);
                                event.eventStatus = check;
                              }
                            });
                          },
                          buttonWith: size.width * 0.85,
                          padding: size.width * 0.04,
                          borderRadius: size.width * 0.015,
                          text: TextContainer(
                            text: "ĐÁNH DẤU CHƯA HOÀN TẤT",
                            textColor: Colors.white,
                            textSize: size.width * 0.05,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                color: Colors.grey.shade400,
                                blurRadius: size.width * 0.03,
                                spreadRadius: size.width * 0.005),
                          ],
                        )
                      : CustomRoundRectangleButton(
                          backgroundColor: Color(0xff3a86ff),
                          onTap: () {
                            setState(() {
                              if (check != null) {
                                check = !check;
                                // EventAPI()
                                //     .update(
                                //     widget.event.eventId!,
                                //     widget.event.eventName,
                                //     widget.event.eventIcon,
                                //     widget.event.eventEndDate,
                                //     int.parse(widget.event.wallet!.walletId
                                //         .toString()),
                                //     "Phuc",
                                //     check)
                                //     .then((value) {
                                //   event.eventStatus = check;
                                // });
                                EventController().updateEvent(
                                    widget.event.eventId!,
                                    widget.event.eventName,
                                    widget.event.eventIcon,
                                    widget.event.eventEndDate,
                                    int.parse(widget.event.wallet!.walletId
                                        .toString()),
                                    "Phuc",
                                    check);

                                print("Check = ${check}");
                                event.eventStatus = check;
                              }
                            });
                          },
                          buttonWith: size.width * 0.85,
                          padding: size.width * 0.04,
                          borderRadius: size.width * 0.015,
                          text: TextContainer(
                            text: "ĐÁNH DẤU HOÀN TẤT",
                            textColor: Colors.white,
                            textSize: size.width * 0.05,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                color: Colors.grey.shade400,
                                blurRadius: size.width * 0.03,
                                spreadRadius: size.width * 0.005),
                          ],
                        ),
                  CustomRoundRectangleButton(
                    backgroundColor: Color(0xff3A86FF),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ListTransaction(
                      //       event: ,
                      //       listTransaction:
                      //           lsTransaction.isEmpty ? [] : lsTransaction,
                      //     ),
                      //   ),
                      // );
                    },
                    buttonWith: size.width * 0.85,
                    padding: size.width * 0.04,
                    borderRadius: size.width * 0.015,
                    text: TextContainer(
                      text: "XEM DANH SÁCH GIAO DỊCH",
                      textColor: Colors.white,
                      textSize: size.width * 0.05,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          color: Colors.grey.shade400,
                          blurRadius: size.width * 0.03,
                          spreadRadius: size.width * 0.005),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDeleteDialog(Event ev) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.02)),
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
                  TextSpan(text: "Bạn có chắc muốn xóa sự kiện "),
                  TextSpan(
                      text: "${ev.eventName}",
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
                border: Border.all(
                  width: size.width * 0.004,
                  color: Colors.grey.shade500,
                ),
                backgroundColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                },
                buttonWith: size.width * 0.25,
                padding: size.width * 0.035,
                borderRadius: size.width * 0.015,
                text: TextContainer(
                  text: "HỦY",
                  textColor: Colors.black,
                  textSize: size.width * 0.05,
                  textFontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              CustomRoundRectangleButton(
                border: Border.all(
                  width: size.width * 0.002,
                  color: Colors.grey,
                ),
                backgroundColor: Color(0xff3a86ff),
                onTap: () {
                  setState(() {
                    // EventAPI()
                    //     .delete(widget.event.eventId!, "Phuc")
                    //     .then((value) {
                    //   if (value == "Delete") {
                    //     Navigator.pop(context);
                    //     Navigator.pop(context, value);
                    //   } else {
                    //     Navigator.pop(context);
                    //     Fluttertoast.showToast(msg: "Delete fail !");
                    //   }
                    // });
                    EventController()
                        .deleteEvent(widget.event.eventId!, "Phuc")
                        .then((value) {
                      if (value == "Delete") {
                        Navigator.pop(context);
                        Navigator.pop(context, value);
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Delete fail !");
                      }
                    });
                  });
                },
                buttonWith: size.width * 0.25,
                padding: size.width * 0.035,
                borderRadius: size.width * 0.015,
                text: TextContainer(
                  text: "OK",
                  textColor: Colors.white,
                  textSize: size.width * 0.05,
                  textFontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          );
        });
  }
}
