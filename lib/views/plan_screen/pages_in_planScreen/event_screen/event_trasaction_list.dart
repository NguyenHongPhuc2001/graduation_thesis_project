import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/event.dart';
import '../../../../models/history.dart';
import '../../../../models/response/list_days_have_transaction.dart';
import '../../../../remote/controllers/entites/history_controller.dart';
import '../../../commons/widgets/circle_icon_container.dart';
import '../../../commons/widgets/custom_round_rectangle_button.dart';
import '../../../commons/widgets/money_text_container.dart';
import '../../../commons/widgets/single_row_container.dart';
import '../../../commons/widgets/text_container.dart';
import '../../../transaction_screen/transaction_screen/transaction_detail.dart';

class EventTransactionList extends StatefulWidget {
  final historyController = Get.put(HistoryController());

  final Event event;


  EventTransactionList({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventTransactionList> createState() => _EventTransactionListState();
}

class _EventTransactionListState extends State<EventTransactionList> {

  List<History> listTranByEvent = [];
  List<ListDaysHaveTransaction> listDays = [];
  final df_month = DateFormat("yyyy-MM");
  final df_week = DateFormat("yyyy-MM-dd");
  var disburse, income;


  @override
  void initState() {
    super.initState();

    widget.historyController
        .getListDayHaveTransactionByEvent("2022",widget.event.eventId!)
        .then((value) {
      setState(() {
        listDays = List.from(value!);
      });
    });


    widget.historyController
        .getListTransactionByEvent(widget.event.eventId!)
        .then((value) {
      setState(() {
        listTranByEvent = List.from(value!);
      });
    });


    widget.historyController.getTotalCostByEvent(widget.event.eventId!, "WITHDRAW").then((value) {
      setState(() {
        disburse = value.totalCost;
      });
    });

    widget.historyController.getTotalCostByEvent(widget.event.eventId!, "RECHARGE").then((value) {
      setState(() {
        income = value.totalCost;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:AppBar(
        title: Text(
          "Danh sách giao dịch",
          style: TextStyle(color: Colors.black, fontSize: size.width * 0.05),
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
      body:(listDays.isEmpty == false)
          ? CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(size.width * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.grey,
                    blurRadius: size.width * 0.01,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleRowContainer(
                    paddingTop: 0,
                    paddingBottom: 0,
                    children: [
                      TextContainer(
                        text: "Tổng thu",
                        textColor: Colors.grey,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                      MoneyTextContainer(
                        value: (income==null)?0:income,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  SingleRowContainer(
                    paddingTop: size.width * 0.04,
                    paddingBottom: 0,
                    children: [
                      TextContainer(
                        text: "Tổng chi",
                        textColor: Colors.grey,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                      MoneyTextContainer(
                        value: (disburse==null)?0:disburse,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: size.width * 0.001,
                    color: Colors.grey.shade600,
                    indent: size.width * 0.6,
                  ),
                  MoneyTextContainer(
                    value: (disburse==null||income==null)?0:(income-disburse),
                    textSize: size.width * 0.04,
                    textFontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate:
            SliverChildBuilderDelegate(childCount: listDays.length,
                    (BuildContext context, int index) {
                  List<History> listTransactionByDay = [];

                  listTranByEvent.forEach((element) {
                    DateTime d1 = df_week.parse(element.historyNotedDate!);
                    DateTime d2 = df_week
                        .parse(listDays[index].date)
                        .subtract(Duration(days: 1));
                    if (d1.compareTo(d2) == 0) {
                      listTransactionByDay.add(element);
                    }
                  });

                  double sum = 0.0;

                  listTransactionByDay.forEach((element) {
                    if (element.historyAction == "WITHDRAW") {
                      sum -= element.historyCost!;
                    } else {
                      sum += element.historyCost!;
                    }
                  });

                  return Padding(
                    padding: EdgeInsets.only(top: size.width * 0.1),
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: Colors.grey,
                            blurRadius: size.width * 0.01,
                            spreadRadius: size.width * 0.001,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: size.width * 0.1,
                                child: TextContainer(
                                  text: df_week
                                      .parse(listDays[index].date)
                                      .day
                                      .toString(),
                                  textColor: Colors.black,
                                  textSize: size.width * 0.07,
                                  textFontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Container(
                                width: size.width * 0.52,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextContainer(
                                      text: getNameOfDays(df_week
                                          .parse(listDays[index].date)
                                          .weekday),
                                      textColor: Colors.black,
                                      textSize: size.width * 0.04,
                                      textFontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                    TextContainer(
                                      text:
                                      "tháng ${df_week.parse(listDays[index].date).month} năm ${df_week.parse(listDays[index].date).year}",
                                      textColor: Colors.black,
                                      textSize: size.width * 0.04,
                                      textFontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width * 0.3,
                                alignment: Alignment.centerRight,
                                child: MoneyTextContainer(
                                  value: sum,
                                  textSize: size.width * 0.035,
                                  textFontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                              thickness: size.width * 0.003,
                              color: Colors.black),
                          Container(
                            width: size.width,
                            height:
                            size.width * 0.15 * listTransactionByDay.length,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: listTransactionByDay.length,
                                itemBuilder:
                                    (BuildContext context, int index1) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        TransactionDetail(
                                            transaction:
                                            listTransactionByDay[index]),
                                      );
                                    },
                                    child: Container(
                                      // padding: EdgeInsets.only(
                                      //     top: size.width * 0.02,
                                      //     bottom: size.width * 0.01),
                                      width: size.width,
                                      height: size.width*0.15,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.01),
                                            child: Container(
                                              width: size.width * 0.1,
                                              child: CircleIconContainer(
                                                urlImage:
                                                listTransactionByDay[index1]
                                                    .expense!
                                                    .expenseIcon,
                                                iconSize: size.width * 0.07,
                                                backgroundColor: Colors.yellow,
                                                padding: size.width * 0.02,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.6,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                TextContainer(
                                                  text: listTransactionByDay[
                                                  index1]
                                                      .expense!
                                                      .expenseName,
                                                  textColor: Colors.black,
                                                  textSize: size.width * 0.04,
                                                  textFontWeight:
                                                  FontWeight.w400,
                                                  decoration:
                                                  TextDecoration.none,
                                                ),
                                                SizedBox(height:size.width*0.01),
                                                TextContainer(
                                                  text: listTransactionByDay[
                                                  index1]
                                                      .historyNote!,
                                                  textColor: Colors.black,
                                                  textSize: size.width * 0.03,
                                                  textFontWeight:
                                                  FontWeight.w400,
                                                  decoration:
                                                  TextDecoration.none,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.21,
                                            alignment: Alignment.centerRight,
                                            child: MoneyTextContainer(
                                              value:
                                              listTransactionByDay[index1]
                                                  .historyCost!,
                                              textSize: size.width * 0.035,
                                              textFontWeight: FontWeight.w500,
                                              color:
                                              (listTransactionByDay[index1]
                                                  .historyAction ==
                                                  "WITHDRAW")
                                                  ? Colors.red
                                                  : Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      )
          :  Center(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "images/FolderIcon.svg",
                    width: size.width * 0.5,
                  ),
                  SizedBox(height: size.width * 0.1),
                  Text(
                    "Không có giao dịch",
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Chọn nút "),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
                            child: TextContainer(
                              text: "+",
                              textColor: Colors.white,
                              textSize: size.width * 0.05,
                              textFontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        const Text("để thêm giao dịch"),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );

  }


  String getNameOfDays(int weekDay) {
    String date = "";
    switch (weekDay) {
      case 1:
        date = "Thứ hai";
        break;
      case 2:
        date = "Thứ ba";
        break;
      case 3:
        date = "Thứ tư";
        break;
      case 4:
        date = "Thứ năm";
        break;
      case 5:
        date = "Thứ sáu";
        break;
      case 6:
        date = "Thứ bảy";
        break;
      case 7:
        date = "Chủ nhật";
        break;
      default:
        date = "Error";
        break;
    }
    return date;
  }
}
