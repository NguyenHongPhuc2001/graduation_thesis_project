import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/wallet_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container_2.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_detail.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_screen.dart';
import 'package:intl/intl.dart';

import '../../../../models/event.dart';
import '../../../../models/wallet.dart';
import '../../../../un_used/WalletNew.dart';
import '../../../commons/pages/select_icon.dart';
import '../../../commons/pages/select_wallet.dart';

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
  final TextEditingController _eventNameController = TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");
  final PageController _pageController = PageController();
  var dateTime, linkIcon, wallet, eventNew;
  bool _onTextClick = true, _onTextFieldClick = false;
  List<Wallet> listWallet = [];

  @override
  void initState() {
    super.initState();
    _eventNameController.text = widget.event.eventName;
    linkIcon = widget.event.eventIcon;
    wallet = widget.event.wallet;

    WalletController().getList().then((value) {
      setState(() {
       listWallet = List.from(value!);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    DateTime date = DateTime.parse(widget.event.eventEndDate);
    String correctDate = "${date.year}-${date.month}-${date.day + 1}";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.black.withAlpha(160),
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
            color: Colors.black.withAlpha(160),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: size.width * 0.1),
          //   child: Container(
          //     padding: EdgeInsets.only(left: size.width * 0.04),
          //     height: size.width * 0.2,
          //     width: size.width,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         width: size.width * 0.001,
          //         color: Colors.black,
          //       ),
          //     ),
          //     child: IntrinsicHeight(
          //       child: Row(
          //         children: [
          //           InkWell(
          //             customBorder: CircleBorder(),
          //             onTap: () async {
          //               final data = await Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => SelectIcons(),
          //                 ),
          //               ).then((value) => setState(() {
          //                     linkIcon = value as String;
          //                   }));
          //             },
          //             child: Container(
          //               padding: EdgeInsets.all(size.width * 0.03),
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 color: Colors.primaries[
          //                         _random.nextInt(Colors.primaries.length)]
          //                     [_random.nextInt(9) * 100],
          //               ),
          //               child: (linkIcon == null)
          //                   ? SvgPicture.asset(
          //                       widget.event.eventIcon,
          //                       width: size.width * 0.09,
          //                     )
          //                   : SvgPicture.asset(
          //                       linkIcon,
          //                       width: size.width * 0.09,
          //                     ),
          //             ),
          //           ),
          //           VerticalDivider(
          //             thickness: size.width * 0.001,
          //             color: Colors.black,
          //             width: size.width * 0.1,
          //           ),
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Visibility(
          //                   visible: _onTextClick,
          //                   child: InkWell(
          //                     onTap: () {
          //                       setState(() {
          //                         _onTextClick = false;
          //                         _onTextFieldClick = true;
          //                         _eventNameController.text =
          //                             widget.event.eventName;
          //                       });
          //                     },
          //                     child: Text(
          //                       widget.event.eventName,
          //                       style: TextStyle(
          //                         color: Colors.black,
          //                         fontSize: size.width * 0.07,
          //                         decoration: TextDecoration.none,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Visibility(
          //                   visible: _onTextFieldClick,
          //                   child: TextField(
          //                     autofocus: true,
          //                     controller: _eventNameController,
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: size.width * 0.07,
          //                       decoration: TextDecoration.none,
          //                     ),
          //                     decoration: InputDecoration(
          //                       isCollapsed: true,
          //                       alignLabelWithHint: true,
          //                       enabledBorder: OutlineInputBorder(
          //                         borderSide: BorderSide.none,
          //                       ),
          //                       focusedBorder: OutlineInputBorder(
          //                         borderSide: BorderSide.none,
          //                       ),
          //                       hintText: "Tên",
          //                       hintStyle: TextStyle(
          //                         color: Colors.black,
          //                         fontSize: size.width * 0.07,
          //                         fontWeight: FontWeight.w400,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: size.width * 0.1),
          //   child: InkWell(
          //     onTap: () async {
          //       DateTime? dateValue = await showDatePicker(
          //         context: context,
          //         initialDate: DateTime.now(),
          //         firstDate: DateTime(2000),
          //         lastDate: DateTime(2200),
          //         fieldLabelText: "Ngày",
          //         cancelText: "THOÁT",
          //         confirmText: "XÁC NHẬN",
          //         helpText: "CHỌN NGÀY",
          //       );
          //
          //       setState(() {
          //         dateTime = dateValue as DateTime;
          //         final year1, year2, month1, month2, day1, day2;
          //         DateTime t = dateTime;
          //         DateTime t2 = DateTime.now();
          //         year1 = t.year;
          //         month1 = t.month;
          //         day1 = t.day;
          //         year2 = t2.year;
          //         month2 = t2.month;
          //         day2 = t2.day;
          //
          //         if (year1 < year2) {
          //           setState(() {
          //             dateTime = null;
          //           });
          //           showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return AlertDialog(
          //                   title: Text(
          //                     "Chờ chút",
          //                     style: TextStyle(
          //                       fontSize: size.width * 0.07,
          //                       color: Colors.black,
          //                     ),
          //                   ),
          //                   content: Text(
          //                     "Ngày không hợp lệ ! Vui lòng chọn lại !",
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: size.width * 0.04,
          //                     ),
          //                   ),
          //                   actions: [
          //                     InkWell(
          //                       onTap: () {
          //                         Navigator.pop(context);
          //                       },
          //                       child: Container(
          //                         alignment: Alignment.center,
          //                         padding: EdgeInsets.only(
          //                             top: size.width * 0.005,
          //                             bottom: size.width * 0.005),
          //                         width: size.width * 0.2,
          //                         decoration: BoxDecoration(
          //                           shape: BoxShape.rectangle,
          //                           borderRadius: BorderRadius.circular(
          //                               size.width * 0.016),
          //                           color: Colors.blueAccent,
          //                         ),
          //                         child: Text(
          //                           "OK",
          //                           style: TextStyle(
          //                             color: Colors.white,
          //                             fontSize: size.width * 0.05,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 );
          //               });
          //         } else if (year1 == year2 && month1 < month2) {
          //           setState(() {
          //             dateTime = null;
          //           });
          //           showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return AlertDialog(
          //                   title: Text(
          //                     "Chờ chút",
          //                     style: TextStyle(
          //                       fontSize: size.width * 0.07,
          //                       color: Colors.black,
          //                     ),
          //                   ),
          //                   content: Text(
          //                     "Ngày không hợp lệ ! Vui lòng chọn lại !",
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: size.width * 0.04,
          //                     ),
          //                   ),
          //                   actions: [
          //                     InkWell(
          //                       onTap: () {
          //                         Navigator.pop(context);
          //                       },
          //                       child: Container(
          //                         alignment: Alignment.center,
          //                         padding: EdgeInsets.only(
          //                             top: size.width * 0.005,
          //                             bottom: size.width * 0.005),
          //                         width: size.width * 0.2,
          //                         decoration: BoxDecoration(
          //                           shape: BoxShape.rectangle,
          //                           borderRadius: BorderRadius.circular(
          //                               size.width * 0.016),
          //                           color: Colors.blueAccent,
          //                         ),
          //                         child: Text(
          //                           "OK",
          //                           style: TextStyle(
          //                             color: Colors.white,
          //                             fontSize: size.width * 0.05,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 );
          //               });
          //         } else if (year1 == year2 &&
          //             month1 == month2 &&
          //             day1 < day2) {
          //           setState(() {
          //             dateTime = null;
          //           });
          //           _showCalendarDialog();
          //         }
          //       });
          //     },
          //     child: Container(
          //       padding: EdgeInsets.only(left: size.width * 0.04),
          //       height: size.width * 0.2,
          //       width: size.width,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           width: size.width * 0.001,
          //           color: Colors.black,
          //         ),
          //       ),
          //       child: IntrinsicHeight(
          //         child: Row(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.all(size.width * 0.025),
          //               child: Image.asset("icons/icons_1/calendar_icon_1.png",
          //                   width: size.width * 0.1),
          //             ),
          //             VerticalDivider(
          //               thickness: size.width * 0.001,
          //               color: Colors.black,
          //               width: size.width * 0.1,
          //             ),
          //             Expanded(
          //               child: dateTime == null
          //                   ? Text(
          //                       widget.event.eventEndDate,
          //                       style: TextStyle(
          //                         color: Colors.black,
          //                         fontSize: size.width * 0.07,
          //                         decoration: TextDecoration.none,
          //                       ),
          //                     )
          //                   : Text(
          //                       df.format(dateTime),
          //                       style: TextStyle(
          //                         color: Colors.black,
          //                         fontSize: size.width * 0.07,
          //                         decoration: TextDecoration.none,
          //                       ),
          //                     ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: size.width * 0.1),
          //   child: InkWell(
          //     onTap: () async {
          //       final data = await Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => SelectWallet(
          //             listWallet: listWallet,
          //           ),
          //         ),
          //       ).then((value) => setState(() {
          //             wallet = value;
          //           }));
          //     },
          //     child: Container(
          //       padding: EdgeInsets.only(left: size.width * 0.04),
          //       height: size.width * 0.2,
          //       width: size.width,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           width: size.width * 0.001,
          //           color: Colors.black,
          //         ),
          //       ),
          //       child: IntrinsicHeight(
          //         child: Row(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.all(size.width * 0.025),
          //               child: Image.asset(
          //                 "icons/icons_1/wallet_icon_1.png",
          //                 width: size.width * 0.1,
          //               ),
          //             ),
          //             VerticalDivider(
          //               thickness: size.width * 0.001,
          //               color: Colors.black,
          //               width: size.width * 0.1,
          //             ),
          //             Expanded(
          //               child: Text(
          //                 (wallet != null)
          //                     ? wallet.walletName
          //                     : widget.event.wallet!.walletName,
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: size.width * 0.07,
          //                   decoration: TextDecoration.none,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: size.width * 0.1),
          //   child: InkWell(
          //     onTap: () {},
          //     child: Container(
          //       padding: EdgeInsets.only(left: size.width * 0.04),
          //       height: size.width * 0.2,
          //       width: size.width,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           width: size.width * 0.001,
          //           color: Colors.black,
          //         ),
          //       ),
          //       child: IntrinsicHeight(
          //         child: Row(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.all(size.width * 0.01),
          //               child: Image.asset(
          //                 "icons/icons_1/money_icon_1.png",
          //                 width: size.width * 0.13,
          //               ),
          //             ),
          //             VerticalDivider(
          //               thickness: size.width * 0.001,
          //               color: Colors.black,
          //               width: size.width * 0.1,
          //             ),
          //             Expanded(
          //               child: Text(
          //                 "Việt nam đồng",
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: size.width * 0.07,
          //                   decoration: TextDecoration.none,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

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
                      (linkIcon != null) ? linkIcon : widget.event.eventIcon,
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
                              walletId: (wallet!=null)?wallet.walletId:null,
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
                                      : widget.event.wallet!.walletName,
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
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200),
                          fieldLabelText: "Ngày",
                          cancelText: "THOÁT",
                          confirmText: "XÁC NHẬN",
                          helpText: "CHỌN NGÀY",
                        ).then((value) {
                          setState(() {
                            dateTime = value;
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
                              _showCalendarDialog();
                            } else if (year1 == year2 && month1 < month2) {
                              setState(() {
                                dateTime = null;
                              });
                              _showCalendarDialog();
                            } else if (year1 == year2 &&
                                month1 == month2 &&
                                day1 < day2) {
                              setState(() {
                                dateTime = null;
                              });
                              _showCalendarDialog();
                            }
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
                                  text: (dateTime != null)
                                      ? df.format(dateTime)
                                      : correctDate,
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
                if (linkIcon != null && wallet != null) {
                  if (dateTime != null) {
                    EventController()
                        .updateEvent(
                            widget.event.eventId!,
                            _eventNameController.text,
                            linkIcon,
                            df.format(dateTime),
                            wallet.walletId,
                            "Phuc",
                            widget.event.eventStatus!)
                        .then((value) {
                      setState(() {
                        Navigator.pop(context, value);
                      });
                    });

                  }else{
                    EventController()
                        .updateEvent(
                        widget.event.eventId!,
                        _eventNameController.text,
                        linkIcon,
                        correctDate,
                        wallet.walletId,
                        "Phuc",
                        widget.event.eventStatus!)
                        .then((value) {
                      setState(() {
                        Navigator.pop(context, value);
                      });
                    });

                  }
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
              "Sửa sự kiện",
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
