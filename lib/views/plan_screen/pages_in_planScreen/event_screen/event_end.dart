import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/history_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_detail.dart';
import 'package:intl/intl.dart';

import '../../../../models/event.dart';
import '../../../../models/response/total_cost.dart';
import '../../../commons/widgets/custom_round_rectangle_button.dart';
import '../../../commons/widgets/money_text_container.dart';
import '../../../commons/widgets/single_row_container_2.dart';

// ignore: must_be_immutable
class EventEnd extends StatefulWidget {

  EventEnd({
    Key? key,
  }) : super(key: key);

  @override
  State<EventEnd> createState() => _EventEndState();
}

class _EventEndState extends State<EventEnd> {
  bool isEmpty = false,checkTotal =false;

  final NumberFormat nf = NumberFormat("###,###");

  List<Event> lsEnd = [];
  List<TotalCost> listValue = [];


  var check = true;

  @override
  void initState() {
    // TODO: implement initState
    EventController().getByStatus(true).then((value) {
      setState(() {
        lsEnd = List.from(value);
      });
    });
    super.initState();
    checkTotal=true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (checkTotal == true) {
      lsEnd.forEach((element) {
        HistoryController()
            .getTotalCostByEvent(element.eventId!, "WITHDRAW")
            .then((value) {
          setState(() {
            listValue.add(value);
          });
        });
      });
    }

    // if (checkTotal == true) {
    //   listValue.clear();
    //   lsEnd.forEach((element) {
    //     HistoryController()
    //         .getTotalCostByEvent(element.eventId!, "WITHDRAW")
    //         .then((value) {
    //       setState(() {
    //         listValue.add(value);
    //       });
    //     });
    //   });
    //   checkTotal = false;
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: lsEnd.isEmpty
          ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "images/CalendarIcon_2.svg",
              width: size.width * 0.5,
            ),
            Text(
              "Không có sự kiện",
              style: TextStyle(
                fontSize: size.width * 0.09,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chọn nút "),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CustomRoundRectangleButton(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.2,
                          spreadRadius: 0.2,
                        ),
                      ],
                      onTap: () {},
                      buttonWith: size.width * 0.13,
                      padding: size.width * 0.01,
                      borderRadius: size.width * 0.02,
                      text: TextContainer(
                        text: "Thêm",
                        textColor: Colors.white,
                        textSize: size.width * 0.02,
                        textFontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  const Text("để thêm sự kiện"),
                ],
              ),
            ),
          ],
        ),
      )
          : SizedBox(
        width: size.width,
        child: ListView.builder(
            itemCount: lsEnd.length,
            itemBuilder: (context, index) {
              // var spending;
              //
              // HistoryController().getTotalCostByEvent(lsEventHappening[index].eventId!, "WITHDRAW").then((value) {
              //   setState((){
              //     spending = value;
              //   });
              // });

              return Padding(
                padding: EdgeInsets.only(top: size.width * 0.07),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetail(
                          event: lsEnd.elementAt(index),
                        ),
                      ),
                    ).then((value) => setState(() {
                      if (value == "Delete") {
                        EventController()
                            .getByStatus(false)
                            .then((value) {
                          setState(() {
                            lsEnd = List.from(value);
                          });
                        });
                        Fluttertoast.showToast(
                            msg: "Xóa sự kiện thành công !");
                      } else if (value == "Cancel") {
                        EventController()
                            .getByStatus(false)
                            .then((value) {
                          setState(() {
                            lsEnd = List.from(value);
                          });
                        });
                      } else {
                        EventController()
                            .getByStatus(false)
                            .then((value) {
                          setState(() {
                            lsEnd = List.from(value);
                          });
                        });
                      }
                    }));
                  },
                  child: SingleRowContainer2(
                    paddingLeft: size.width * 0.01,
                    paddingRight: size.width * 0.01,
                    paddingTop: size.width * 0.02,
                    paddingBottom: size.width * 0.02,
                    height: size.height * 0.13,
                    background: Colors.white,
                    children: [
                      CircleIconContainer(
                        urlImage:
                        lsEnd.elementAt(index).eventIcon,
                        iconSize: size.width * 0.07,
                        backgroundColor: const Color(0xffFB8500),
                        padding: size.width * 0.045,
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            TextContainer(
                              text: lsEnd
                                  .elementAt(index)
                                  .eventName,
                              textColor: Colors.black,
                              textSize: size.width * 0.045,
                              textFontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: size.width * 0.01),
                              child: Container(
                                width: size.width * 0.4,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.2)
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "Đã chi",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: size.width * 0.23,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(
                                                100),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 0.2)
                                            ]),
                                        child: MoneyTextContainer(
                                          value: (listValue[index].totalCost==null)?0:listValue[index].totalCost,
                                          textSize: size.width * 0.035,
                                          textFontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
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
            }),
      ),
    );
  }
}
