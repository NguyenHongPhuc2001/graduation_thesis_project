import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/dao/transaction_dao.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container_2.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_updateEvent.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/list_transaction.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  final Event event;
  final List<Event> listEvent;

  const EventDetail({
    Key? key,
    required this.event,
    required this.listEvent,
  }) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final _random = Random();
  final PageController _pageController = PageController();
  final DateFormat df = DateFormat("yyy-MM-dd");
  final List<Transactions> listTransaction = TransactionDAO().getAll();

  var check;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Transactions> lsTransaction = [];
    final Duration dayLeft = widget.event.endDate.difference(DateTime.now());

    listTransaction.forEach((element) {
      if (element.event != null) {
        if (element.event!.id == widget.event.id) lsTransaction.add(element);
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.15),
          child: AppBarContainer2(
              text: "Chi tiết",
              backIcon: CupertinoIcons.xmark,
              prefixIcon1: Icons.edit,
              prefixIcon2: Icons.delete,
              onBackTap: () {
                Navigator.pop(context, widget.event.status);
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
                      if (value == "Update")
                        Fluttertoast.showToast(msg: "Cập nhật thành công !");
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
                    paddingTop: size.width * 0.01,
                    paddingBottom: size.width * 0.01,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.3,
                        child: CircleIconContainer(
                          urlImage: widget.event.urlImage,
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.green, padding: size.width*0.045,
                        ),
                      ),
                      Container(
                        width: size.width * 0.62,
                        child: TextContainer(
                          text: widget.event.eventName,
                          textColor: Colors.black,
                          textSize: size.width * 0.06,
                          textFontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
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
                          padding: size.width*0.045,
                        ),
                      ),
                      Container(
                        width: size.width * 0.62,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextContainer(
                              text: df.format(widget.event.createDate),
                              textColor: Colors.black,
                              textSize: size.width * 0.06,
                              textFontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                            TextContainer(
                              text: "Còn ${dayLeft.inDays} ngày",
                              textColor: Colors.black,
                              textSize: size.width * 0.03,
                              textFontWeight: FontWeight.w300,
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
                          padding: size.width*0.045,
                        ),
                      ),
                      Container(
                        width: size.width * 0.62,
                        child: TextContainer(
                          text: widget.event.wallet.walletName,
                          textColor: Colors.black,
                          textSize: size.width * 0.06,
                          textFontWeight: FontWeight.w400,
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
                  widget.event.status
                      ? CustomRoundRectangleButton(
                    backgroundColor: Colors.blue,
                          onTap: () {
                            setState(() {
                              widget.event.status = false;
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
                        )
                      : CustomRoundRectangleButton(
                    backgroundColor: Colors.blue,
                          onTap: () {
                            setState(() {
                              widget.event.status = true;
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
                        ),
                  CustomRoundRectangleButton(
                    backgroundColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListTransaction(
                            event: widget.event,
                            listTransaction:
                                lsTransaction.isEmpty ? [] : lsTransaction,
                          ),
                        ),
                      );
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
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: size.width * 0.009, bottom: size.width * 0.009),
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    border: Border.all(
                      width: size.width * 0.002,
                      color: Colors.black,
                    ),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Hủy",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.listEvent.removeWhere(
                        (element) => element.id == widget.event.id);
                    Navigator.pop(
                      context,
                      EventScreen(
                        pageController: _pageController,
                        listEvent: widget.listEvent,
                        listTransaction: [],
                      ),
                    );
                    Navigator.pop(context, "Delete");
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: size.width * 0.011, bottom: size.width * 0.011),
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
