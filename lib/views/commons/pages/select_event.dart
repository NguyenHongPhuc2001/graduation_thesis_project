import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/event_controller.dart';

import '../../../models/event.dart';
import '../widgets/circle_icon_container.dart';
import '../widgets/money_text_container.dart';
import '../widgets/single_row_container_2.dart';
import '../widgets/text_container.dart';


class SelectEvent extends StatefulWidget {
  const SelectEvent({Key? key}) : super(key: key);

  @override
  State<SelectEvent> createState() => _SelectEventState();
}

class _SelectEventState extends State<SelectEvent> {
  final _random = Random();
  // final NumberFormat nf = NumberFormat("###,###");

  List<Event> listEvent = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EventController().getListEvent().then((value) {
      setState(() {
        listEvent = List.from(value);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Chọn sự kiện",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: listEvent.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: size.width * 0.07),
              child: InkWell(
                onTap: () {
                    Get.back(result: listEvent[index]);
                },
                child: SingleRowContainer2(
                  paddingLeft: size.width * 0.01,
                  paddingRight: size.width * 0.01,
                  paddingTop: size.width * 0.02,
                  paddingBottom: size.width * 0.02,
                  height: size.height * 0.13,
                  background: Colors.white,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.015),
                      child: CircleIconContainer(
                        urlImage: listEvent.elementAt(index).eventIcon,
                        iconSize: size.width * 0.07,
                        backgroundColor: const Color(0xffFB8500),
                        padding: size.width * 0.045,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: size.width*0.02),
                            child: TextContainer(
                              text: listEvent.elementAt(index).eventName,
                              textColor: Colors.black,
                              textSize: size.width * 0.04,
                              textFontWeight:FontWeight.w500,
                              decoration:
                              TextDecoration.none,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.01),
                            child: Container(
                              width: size.width * 0.4,
                              height: size.height * 0.04,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 0.2
                                  )]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Đã chi",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.23,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(100),
                                          boxShadow: const [BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 0.2
                                          )]
                                      ),
                                      child: MoneyTextContainer(
                                        value: 10,
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
    );
  }
}
