import 'dart:math';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/dao/envent_dao.dart';
import 'package:graduation_thesis_project/dao/wallet_dao.dart';
import 'package:graduation_thesis_project/model/Event.dart';
import 'package:graduation_thesis_project/model/Wallet.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_selectWallet.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_select_icons.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final List<Event> listEvent;

  const AddEvent({
    Key? key,
    required this.listEvent,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _random = Random();
  final List<Wallet> listWallet = WalletDAO().getAllWallet();
  final TextEditingController _eventNameController = TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");

  var dateTime, linkIcon;

  Wallet wallet = Wallet(
      id: 1,
      walletName: "Chọn ví",
      walletBlanace: 111,
      createDate: DateTime.now(),
      updateDate: DateTime.now());

  Event event = Event(
    totalSpending: 123123,
    id: 0,
    endDate: DateTime.now(),
    createDate: DateTime.now(),
    eventName: "Initinal",
    status: false,
    wallet: null,
    urlImage: null,
  );

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
            Navigator.pop(context, event);
          },
        ),
        centerTitle: true,
        title: Text(
          "Thêm sự kiện",
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
              setState(() {
                event.eventName = _eventNameController.text;
                event.endDate = dateTime;
                event.totalSpending = 0;
                event.wallet = wallet;
                event.id = 5;
                event.urlImage = linkIcon;
                EventDAO().insertEvent(event);
              });
              Navigator.pop(context, event);
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
                            ? Icon(
                                Icons.question_mark,
                                size: size.width * 0.09,
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
                      child: TextField(
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
                            color: Colors.grey,
                            fontSize: size.width * 0.07,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
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
                                "Ngày kết thúc",
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
                      wallet = value;
                      print(wallet.walletName);
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
                          wallet.walletName,
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
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2000),
    );
  }
}
