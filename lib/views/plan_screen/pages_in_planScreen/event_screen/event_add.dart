import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:intl/intl.dart';

import '../../../../remote/controllers/entites/wallet_controller.dart';
import '../../../commons/pages/select_icon.dart';
import '../../../commons/pages/select_wallet.dart';
import '../../../commons/widgets/text_container.dart';

// ignore: must_be_immutable
class AddEvent extends StatefulWidget {

  WalletController walletController = Get.put(WalletController());
  EventController eventController = Get.put(EventController());

  AddEvent({ Key? key }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  final _eventNameController = TextEditingController();
  final DateFormat df = DateFormat("yyyy-MM-dd");
  List<Wallet> listWallet = [];
  var dateTime, linkIcon, wallet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.now();
    widget.walletController.getList().then((value) {
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
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            "Thêm mới sự kiện",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.05
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.5,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 2,
                        color: Colors.grey
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          linkIcon = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const SelectIcons())
                          );
                        },
                        child: Container(
                          height: size.width * 0.2,
                          width: size.width * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          padding: const EdgeInsets.all(18),
                          child: SvgPicture.asset(linkIcon == null ? "" : linkIcon!),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(top: 10),
                      width: size.width * 0.8,
                      height: size.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2
                            )
                          ]
                      ),
                      child: TextField(
                        controller: _eventNameController,
                        textAlign: TextAlign.center,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Nhập tên sự kiện",
                          hintStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    SizedBox(
                      height: size.height * 0.05,
                      child: const VerticalDivider(
                        color: Colors.black,
                        thickness: 0.2,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: const Text(
                                'Ngày kết thúc',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              width: size.width * 0.4,
                              height: size.width * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: Container(
                                alignment: Alignment.center,
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
                                      final int year1, year2, month1, month2, day1, day2;
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
                                  child: TextContainer(
                                    text: df.format(dateTime),
                                    textColor: Colors.black,
                                    textSize: size.width * 0.03,
                                    textFontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: const Text(
                                'Chọn ví',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              width: size.width * 0.4,
                              height: size.width * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.push( context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectWallet( listWallet: listWallet, walletId: (wallet!=null) ? wallet.walletId:null,
                                      ),
                                    ),
                                  ).then((value) {
                                    setState(() {
                                      wallet = value;
                                    });
                                  });
                                },
                                child: SizedBox(
                                    child:  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        wallet == null ? "" : wallet.walletName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.03,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async{
                  await widget.eventController.createEvent(_eventNameController.text, linkIcon, df.format(dateTime), wallet.walletId);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)
                ),
                child: const Text(
                    "Tạo mới sự kiện"
                ),
              ),
            ],
          ),
        )
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
