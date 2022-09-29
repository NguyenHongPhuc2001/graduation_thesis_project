import 'dart:math';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/dao/envent_dao.dart';
import 'package:graduation_thesis_project/dao/wallet_dao.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/model/Wallet.dart';
import 'package:graduation_thesis_project/views/plan_screen/commons/pages/select_icon.dart';
import 'package:graduation_thesis_project/views/plan_screen/commons/pages/select_wallet.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_selectWallet.dart';
import 'package:intl/intl.dart';

class UpdateEvent extends StatefulWidget {
  final Event event;

  UpdateEvent({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  final _random = Random();
  final List<Wallet> listWallet = WalletDAO().getAllWallet();
  final TextEditingController _eventNameController = TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");
  final PageController _pageController = PageController();
  var dateTime, linkIcon;
  bool _onTextClick = true, _onTextFieldClick = false;



  Event newEvent = EventDAO().ev_1;

  @override
  void initState() {
    _eventNameController.text = widget.event.eventName;
    dateTime = widget.event.endDate;
    linkIcon = widget.event.urlImage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Sửa sự kiện",
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
              Icons.save,
              color: Colors.black,
              size: size.width * 0.08,
            ),
            onPressed: () {
              print("i'm update in update !");
              setState(() {
                newEvent.eventName = _eventNameController.text;
                if (dateTime != null) newEvent.endDate = dateTime;
                newEvent.wallet = widget.event.wallet;
                if (linkIcon != null) newEvent.urlImage = linkIcon as String;

                EventDAO().updateEvent(widget.event, newEvent);
              });
              Navigator.pop(context, "Update");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              height: size.width * 0.2,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: size.width * 0.001,
                  color: Colors.black,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    InkWell(
                      customBorder: CircleBorder(),
                      onTap: () async {
                        final data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectIcons(),
                          ),
                        ).then((value) => setState(() {
                              linkIcon = value as String;
                            }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.03),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.primaries[
                                  _random.nextInt(Colors.primaries.length)]
                              [_random.nextInt(9) * 100],
                        ),
                        child: (linkIcon == null)
                            ? Image.asset(
                                widget.event.urlImage,
                                width: size.width * 0.09,
                              )
                            : Image.asset(
                                linkIcon,
                                width: size.width * 0.09,
                              ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: size.width * 0.001,
                      color: Colors.black,
                      width: size.width * 0.1,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: _onTextClick,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _onTextClick = false;
                                  _onTextFieldClick = true;
                                  _eventNameController.text =
                                      widget.event.eventName;
                                });
                              },
                              child: Text(
                                widget.event.eventName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.07,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _onTextFieldClick,
                            child: TextField(
                              autofocus: true,
                              controller: _eventNameController,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.07,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                alignLabelWithHint: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Tên",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.07,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: InkWell(
              onTap: () async {
                DateTime? dateValue = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2200),
                  fieldLabelText: "Ngày",
                  cancelText: "THOÁT",
                  confirmText: "XÁC NHẬN",
                  helpText: "CHỌN NGÀY",
                );

                setState(() {
                  dateTime = dateValue as DateTime;
                  final year1, year2, month1, month2, day1, day2;
                  DateTime t = dateTime;
                  DateTime t2 = DateTime.now();
                  year1 = t.year;
                  month1 = t.month;
                  day1 = t.day;
                  year2 = t2.year;
                  month2 = t2.month;
                  day2 = t2.day;

                  if (year1 < year2) {
                    setState(() {
                      dateTime = null;
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Chờ chút",
                              style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.black,
                              ),
                            ),
                            content: Text(
                              "Ngày không hợp lệ ! Vui lòng chọn lại !",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.04,
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
                                      top: size.width * 0.005,
                                      bottom: size.width * 0.005),
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.016),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Text(
                                    "OK",
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
                  } else if (year1 == year2 && month1 < month2) {
                    setState(() {
                      dateTime = null;
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Chờ chút",
                              style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.black,
                              ),
                            ),
                            content: Text(
                              "Ngày không hợp lệ ! Vui lòng chọn lại !",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.04,
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
                                      top: size.width * 0.005,
                                      bottom: size.width * 0.005),
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.016),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Text(
                                    "OK",
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
                  } else if (year1 == year2 &&
                      month1 == month2 &&
                      day1 < day2) {
                    setState(() {
                      dateTime = null;
                    });
                    _showCalendarDialog();
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                height: size.width * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: Image.asset("icons/icons_1/calendar_icon_1.png",
                            width: size.width * 0.1),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: dateTime == null
                            ? Text(
                                df.format(widget.event.endDate),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.07,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            : Text(
                                df.format(dateTime),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.07,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: InkWell(
              onTap: () async {
                final data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectWallet(
                      listWallet: listWallet,
                    ),
                  ),
                ).then((value) => setState(() {
                      widget.event.wallet = value;
                    }));
              },
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                height: size.width * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: Image.asset(
                          "icons/icons_1/wallet_icon_1.png",
                          width: size.width * 0.1,
                        ),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: Text(
                           widget.event.wallet.walletName ,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.1),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                height: size.width * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.01),
                        child: Image.asset(
                          "icons/icons_1/money_icon_1.png",
                          width: size.width * 0.13,
                        ),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: Text(
                          "Việt nam đồng",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showCalendarDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Chờ chút",
              style: TextStyle(
                fontSize: size.width * 0.07,
                color: Colors.black,
              ),
            ),
            content: Text(
              "Ngày không hợp lệ ! Vui lòng chọn lại !",
              style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.04,
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
                      top: size.width * 0.005, bottom: size.width * 0.005),
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    "OK",
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
