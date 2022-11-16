import 'dart:math';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/remote/api/Wallet_API.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:intl/intl.dart';

import '../../../../models/event.dart';
import '../../../../remote/controllers/entites/wallet_controller.dart';
import '../../../../un_used/WalletNew.dart';
import '../../../commons/pages/select_icon.dart';
import '../../../commons/pages/select_wallet.dart';
import '../../../commons/widgets/circle_icon_container.dart';
import '../../../commons/widgets/custom_round_rectangle_button.dart';
import '../../../commons/widgets/single_row_container.dart';
import '../../../commons/widgets/text_container.dart';

class AddEvent extends StatefulWidget {
  final List<Event> listEvent;
  bool status;

  AddEvent({
    Key? key,
    required this.listEvent,
    required this.status,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _random = Random();
  final _eventNameController = TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");
  List<Wallet> listWallet = [];
  var dateTime, linkIcon, wallet;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.now();
    WalletController().getList("Phuc").then((value) {
      setState(() {
        listWallet = List.from(value!);
      });
    });


  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.black.withAlpha(160),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Thêm sự kiện",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black.withAlpha(160),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SingleRowContainer(
            mainAxisAlignment: MainAxisAlignment.center,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              InkWell(
                customBorder: CircleBorder(),
                splashColor: Colors.grey,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectIcons(),
                    ),
                  ).then((value) {
                    setState(() {
                      linkIcon = value;
                    });
                  });
                },
                child: CircleIconContainer(
                  urlImage:
                  (linkIcon != null) ? linkIcon : "images/QuestionIcon.svg",
                  iconSize: size.width * 0.14,
                  backgroundColor: Colors.greenAccent,
                  padding: size.width * 0.08,
                ),
              ),
            ],
          ),

          SingleRowContainer(
            width: size.width * 0.95,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: "Tên sự kiện",
                      textColor: Colors.grey.shade600,
                      textSize: size.width * 0.055,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    SizedBox(height: size.width * 0.03),
                    TextField(
                      controller: _eventNameController,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixText: "  ",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: size.width * 0.05,
                        ),
                        hintText: "Nhập tên sự kiện",
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(size.width * 0.03),
                          borderSide: BorderSide(
                            width: size.width * 0.007,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(size.width * 0.03),
                          borderSide: BorderSide(
                            width: size.width * 0.0025,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SingleRowContainer(
            width: size.width * 0.95,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: "Ví",
                      textColor: Colors.grey.shade600,
                      textSize: size.width * 0.055,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    SizedBox(height: size.width * 0.03),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectWallet(
                              listWallet: listWallet,
                              walletId: (wallet!=null) ? wallet.walletId:null,
                            ),
                          ),
                        ).then((value) {
                          setState(() {
                            wallet = value;
                          });
                        });
                      },
                      child: SingleRowContainer(
                        boxDecoration: BoxDecoration(
                          border: Border.all(
                            width: size.width * 0.002,
                            color: Colors.grey,
                          ),
                          borderRadius:
                          BorderRadius.circular(size.width * 0.02),
                        ),
                        paddingTop: size.width * 0.035,
                        paddingBottom: size.width * 0.035,
                        children: [
                          Container(
                            width: size.width * 0.18,
                            child: SvgPicture.asset(
                              "images/WalletIcon_2.svg",
                              width: size.width * 0.09,
                            ),
                          ),
                          Container(
                            width: size.width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextContainer(
                                  text: (wallet != null)
                                      ? wallet.walletName
                                      : "Chọn ví",
                                  textColor:(wallet != null)? Colors.black: Colors.grey,
                                  textSize: size.width * 0.055,
                                  textFontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: size.width * 0.1,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SingleRowContainer(
            width: size.width * 0.95,
            paddingTop: 0,
            paddingBottom: 0,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextContainer(
                      text: "Ngày kết thúc",
                      textColor: Colors.grey.shade600,
                      textSize: size.width * 0.055,
                      textFontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    SizedBox(height: size.width * 0.03),
                    InkWell(
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
                      child: SingleRowContainer(
                        boxDecoration: BoxDecoration(
                          border: Border.all(
                            width: size.width * 0.002,
                            color: Colors.grey,
                          ),
                          borderRadius:
                          BorderRadius.circular(size.width * 0.02),
                        ),
                        paddingTop: size.width * 0.035,
                        paddingBottom: size.width * 0.035,
                        children: [
                          Container(
                            width: size.width * 0.18,
                            child: SvgPicture.asset(
                              "images/CalendarIcon_1.svg",
                              width: size.width * 0.09,
                            ),
                          ),
                          Container(
                            width: size.width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextContainer(
                                  text: df.format(dateTime),
                                  textColor: Colors.black,
                                  textSize: size.width * 0.055,
                                  textFontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: size.width * 0.1,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          CustomRoundRectangleButton(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                color: Colors.grey,
                blurRadius: size.width * 0.04,
              ),
            ],
            onTap: () {
              setState(() {
                if (linkIcon != null && wallet != null && dateTime != null) {
                  EventController()
                      .createEvent(
                    _eventNameController.text,
                    linkIcon,
                    df.format(dateTime),
                    wallet.walletId,
                    "Phuc")
                      .then((value) {
                    setState(() {
                      Navigator.pop(context, value);
                    });
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: "Something wrong, please check again !");
                }
              });
            },
            buttonWith: size.width * 0.95,
            padding: size.width * 0.02,
            borderRadius: size.width * 0.02,
            text: Text(
              "Thêm sự kiện",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.07,
              ),
            ),
            backgroundColor: Color(0xffFB8500),
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
