import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container_2.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_updateEvent.dart';
import 'package:graduation_thesis_project/views/transaction_screen/expense_screen/expense_list.dart';
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
  final DateFormat df = DateFormat("yyy-MM-dd");
  var event, check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EventController().getOneEvent(widget.event.eventId!).then((value) {
      setState(() {
        event = value;
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

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.15),
          child: AppBarContainer2(
            text: "Chi tiết",
            backIcon: CupertinoIcons.xmark,
            prefixIcon2: Icons.edit,
            onBackTap: () async {
              Navigator.pop(context, "Cancle");
            },
            onPrefixIcon2Tap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateEvent(
                    event: widget.event,
                  ),
                ),
              ).then((value) {
                  if (value == "Update") {
                    EventController().getOneEvent(widget.event.eventId!).then((value) {
                      setState((){
                        event = value;
                      });
                    });
                    Fluttertoast.showToast(msg: "Update success !");
                  }
              });
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleRowContainer(
                    width: size.width * 0.9,
                    boxDecoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(size.width * 0.05),
                      color: Colors.white,
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
                            backgroundColor: Colors.lightBlue,
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
                            textSize: size.width * 0.055,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SingleRowContainer(
                    height: size.height * 0.16,
                    paddingTop: size.width * 0.06,
                    paddingBottom: size.width * 0.01,
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.only(left: size.width*0.05),
                        child: CircleIconContainer(
                          urlImage: "images/CalendarIcon_4.svg",
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.white,
                          padding: size.width * 0.045,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: size.width*0.05),
                        width: size.width * 0.6,
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
                    height: size.height * 0.1,
                    paddingTop: size.width * 0.01,
                    paddingBottom: size.width * 0.01,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.06),
                        child: CircleIconContainer(
                          urlImage: "images/WalletIcon_1.svg",
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.white,
                          padding: size.width * 0.045,
                        ),
                      ),
                      SizedBox(
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
            SizedBox(
              height: size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (check == true)
                      ? CustomRoundRectangleButton(
                          backgroundColor: const Color(0xff3a86ff),
                          onTap: () {
                            setState(() {
                              if (check != null) {
                                check = !check;
                                EventController().updateEvent(
                                    widget.event.eventId!,
                                    widget.event.eventName,
                                    widget.event.eventIcon,
                                    widget.event.eventEndDate,
                                    int.parse(widget.event.wallet!.walletId
                                        .toString()),
                                    check);
                                event.eventStatus = check;
                              }
                            });
                          },
                          buttonWith: size.width * 0.85,
                          padding: size.width * 0.04,
                          borderRadius: size.width * 0.5,
                          text: TextContainer(
                            text: "ĐÁNH DẤU CHƯA HOÀN TẤT",
                            textColor: Colors.white,
                            textSize: size.width * 0.035,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 2,
                                spreadRadius: 2),
                          ],
                        )
                      : CustomRoundRectangleButton(
                          backgroundColor: const Color(0xff3a86ff),
                          onTap: () {
                            setState(() {
                              if (check != null) {
                                check = !check;
                                EventController().updateEvent(
                                    widget.event.eventId!,
                                    widget.event.eventName,
                                    widget.event.eventIcon,
                                    widget.event.eventEndDate,
                                    int.parse(widget.event.wallet!.walletId
                                        .toString()),
                                    check);

                                event.eventStatus = check;
                              }
                            });
                          },
                          buttonWith: size.width * 0.85,
                          padding: size.width * 0.04,
                          borderRadius: size.width * 0.5,
                          text: TextContainer(
                            text: "ĐÁNH DẤU HOÀN TẤT",
                            textColor: Colors.white,
                            textSize: size.width * 0.035,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 2,
                                spreadRadius: 2),
                          ],
                        ),
                  CustomRoundRectangleButton(
                    backgroundColor: const Color(0xff3A86FF),
                    onTap: () {
                      Get.to(ExpenseList(isLoadByBudget: true));
                    },
                    buttonWith: size.width * 0.85,
                    padding: size.width * 0.04,
                    borderRadius: size.width * 0.5,
                    text: TextContainer(
                      text: "XEM DANH SÁCH GIAO DỊCH",
                      textColor: Colors.white,
                      textSize: size.width * 0.035,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 2,
                          spreadRadius: 2),
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
                  const TextSpan(text: "Bạn có chắc muốn xóa sự kiện "),
                  TextSpan(
                      text: ev.eventName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  const TextSpan(text: " chứ ?"),
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
                backgroundColor: const Color(0xff3a86ff),
                onTap: () {
                  setState(() {
                    EventController()
                        .deleteEvent(widget.event.eventId!)
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
