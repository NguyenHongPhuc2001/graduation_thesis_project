import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  final Event event;

  const EventDetail({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final _random = Random();

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
              check = widget.event.status;
              Navigator.pop(context, check);
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
              onPressed: () {},
            ),
            IconButton(
              splashRadius: size.width * 0.07,
              icon: Icon(
                CupertinoIcons.delete_solid,
                color: Colors.black,
              ),
              onPressed: () {},
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
                        Container(
                          padding: EdgeInsets.all(size.width * 0.045),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.primaries[
                                    _random.nextInt(Colors.primaries.length)]
                                [_random.nextInt(9) * 100],
                          ),
                          child: Image.asset(
                            "icons/icons_1/money_icon_3.png",
                            width: size.width * 0.14,
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.primaries[
                                      _random.nextInt(Colors.primaries.length)]
                                  [_random.nextInt(9) * 100],
                            ),
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.primaries[
                                      _random.nextInt(Colors.primaries.length)]
                                  [_random.nextInt(9) * 100],
                            ),
                            child: Image.asset(
                              "icons/icons_1/wallet_icon_2.png",
                              width: size.width * 0.14,
                            ),
                          ),
                          Container(
                            width: size.width * 0.5,
                            child: Text(
                              "Wallet",
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
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.85,
                    padding: EdgeInsets.all(size.width * 0.04),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(size.width * 0.03)),
                    child: Text(
                      "XEM DANH SÁCH GIAO DỊCH",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05),
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
}
