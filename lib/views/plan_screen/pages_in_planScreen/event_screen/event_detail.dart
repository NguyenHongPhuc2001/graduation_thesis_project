import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_updateEvent.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  final Event event;
  final List<Event> listEvent;
  final int index;

  const EventDetail({
    Key? key,
    required this.event,
    required this.listEvent,
    required this.index,
  }) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final _random = Random();
  final PageController _pageController = PageController();
  final DateFormat df = DateFormat("yyy-MM-dd");

  var check;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Duration dayLeft =
        widget.event.endDate.difference(widget.event.createDate);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.xmark,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, widget.event.status);
            },
          ),
          centerTitle: true,
          title: Text(
            "Chi tiết",
            style: TextStyle(
              fontSize: size.width * 0.065,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              splashRadius: size.width * 0.07,
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () async {
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
            ),
            IconButton(
              splashRadius: size.width * 0.07,
              icon: Icon(
                CupertinoIcons.delete_solid,
                color: Colors.black,
              ),
              onPressed: () {
                _showDeleteDialog(widget.event);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(size.width * 0.03),
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.035),
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.045),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.primaries[
                                      _random.nextInt(Colors.primaries.length)]
                                  [_random.nextInt(9) * 100],
                            ),
                            child: SvgPicture.asset(
                              widget.event.urlImage,
                              width: size.width * 0.07,
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          child: Text(
                            widget.event.eventName,
                            style: TextStyle(
                              fontSize: size.width * 0.07,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.width * 0.07),
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.03),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(size.width * 0.045),
                            child: Image.asset(
                              "icons/icons_1/calendar_icon_3.png",
                              width: size.width * 0.14,
                            ),
                          ),
                          Container(
                            width: size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  df.format(widget.event.createDate),
                                  style: TextStyle(
                                    fontSize: size.width * 0.07,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Còn ${dayLeft.inDays} ngày",
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.width * 0.07),
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.03),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(size.width * 0.05),
                            child: Image.asset(
                              "icons/icons_1/wallet_icon_2.png",
                              width: size.width * 0.14,
                            ),
                          ),
                          Container(
                            width: size.width * 0.5,
                            child: Text(
                              widget.event.wallet.walletName,
                              style: TextStyle(
                                fontSize: size.width * 0.07,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              widget.event.status = false;
                              check = widget.event.status;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.85,
                            padding: EdgeInsets.all(size.width * 0.04),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.03)),
                            child: Text(
                              "ĐÁNH DẤU CHƯA HOÀN TẤT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              widget.event.status = true;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.85,
                            padding: EdgeInsets.all(size.width * 0.04),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.03)),
                            child: Text(
                              "ĐÁNH DẤU HOÀN TẤT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05),
                            ),
                          ),
                        ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.85,
                      padding: EdgeInsets.all(size.width * 0.04),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03)),
                      child: Text(
                        "XEM DANH SÁCH GIAO DỊCH",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05),
                      ),
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
                  List<Event> lsEvent = [];
                  setState(() {
                    widget.listEvent.removeAt(widget.index);
                    lsEvent = widget.listEvent;
                    Navigator.pop(
                      context,
                      EventScreen(
                        pageController: _pageController,
                        listEvent: widget.listEvent,
                        checkInserDelete: "Delete",
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
