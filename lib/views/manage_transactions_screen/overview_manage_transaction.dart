import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/controllers/entites/history_controller.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/models/response/list_days_have_transaction_in_month.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/expense_controller.dart';
import 'package:graduation_thesis_project/views/manage_transactions_screen/report_page.dart';

import 'package:intl/intl.dart';

import '../../models/history.dart';
import '../../remote/controllers/entites/history_controller.dart';
import '../commons/widgets/circle_icon_container.dart';
import '../commons/widgets/custom_round_rectangle_button.dart';
import '../commons/widgets/money_text_container.dart';
import '../commons/widgets/single_row_container.dart';
import '../commons/widgets/text_container.dart';

class OverviewManageTransaction extends StatefulWidget {
  final historyController = Get.put(HistoryController());

  int month;
  int day;

  bool check;

  OverviewManageTransaction({
    Key? key,
    required this.month,
    required this.day,
    required this.check,
  }) : super(key: key);

  @override
  State<OverviewManageTransaction> createState() =>
      _OverviewManageTransactionState();
}

class _OverviewManageTransactionState extends State<OverviewManageTransaction> {
  final List<Tab> listTabs = [];
  List<History> listTransactionByMonth = [];
  List<History> listTranByDate = [];
  List<ListDaysHaveTransactionInMonth> listDays = [];
  final df_month = DateFormat("yyyy-MM");
  final df_week = DateFormat("yyyy-MM-dd");
  var month;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    month = "${DateTime.now().year}-${widget.month + 1}" as String;

    widget.historyController
        .getListDaysHaveTransactionByMonth(month)
        .then((value) {
      setState(() {
        listDays = List.from(value!);
      });
    });

    widget.historyController.getListTransactionByMonth(month).then((value) {
      setState(() {
        listTransactionByMonth = List.from(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    if(widget.check==true){
      month = "${DateTime.now().year}-${widget.month + 1}" as String;

      widget.historyController
          .getListDaysHaveTransactionByMonth(month)
          .then((value) {
        setState(() {
          listDays = List.from(value!);
        });
      });

      widget.historyController.getListTransactionByMonth(month).then((value) {
        setState(() {
          listTransactionByMonth = List.from(value!);
        });
      });

      setState(() {
        widget.check=false;
      });
    }


    print("Check value ${widget.check}");



    return CustomScrollView(
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
                      value: 222222222,
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
                      value: 2111122,
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
                  value: 222222,
                  textSize: size.width * 0.04,
                  textFontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundRectangleButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReportPage()));
                      },
                      margin: EdgeInsets.only(top: size.width * 0.04),
                      buttonWith: size.width * 0.7,
                      padding: size.width * 0.03,
                      borderRadius: size.width * 0.1,
                      text: TextContainer(
                        text: "XEM BÁO CÁO THÁNG NÀY",
                        textColor: Colors.white,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: listDays.length,
              (BuildContext context, int index) {
            List<History> listTransactionByDay = [];

            listTransactionByMonth.forEach((element) {
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
              if(element.historyAction=="WITHDRAW"){
                  sum-=element.historyCost!;
              }else{
                  sum+=element.historyCost!;
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
                    Divider(thickness: size.width * 0.001, color: Colors.black),
                    Container(
                      width: size.width,
                      height: size.width * 0.19 * listTransactionByDay.length,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listTransactionByDay.length,
                          itemBuilder: (BuildContext context, int index1) {
                            return Container(
                              padding: EdgeInsets.only(
                                  top: size.width * 0.02,
                                  bottom: size.width * 0.01),
                              width: size.width,
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
                                        urlImage: listTransactionByDay[index1]
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
                                      children: [
                                        TextContainer(
                                          text: listTransactionByDay[index1]
                                              .expense!
                                              .expenseName,
                                          textColor: Colors.black,
                                          textSize: size.width * 0.04,
                                          textFontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none,
                                        ),
                                        SizedBox(height: size.width * 0.01),
                                        TextContainer(
                                          text: listTransactionByDay[index1]
                                              .historyNote!,
                                          textColor: Colors.black,
                                          textSize: size.width * 0.03,
                                          textFontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.21,
                                    alignment: Alignment.centerRight,
                                    child: MoneyTextContainer(
                                      value: listTransactionByDay[index1]
                                          .historyCost!,
                                      textSize: size.width * 0.035,
                                      textFontWeight: FontWeight.w500,
                                      color: (listTransactionByDay[index1]
                                                  .historyAction ==
                                              "WITHDRAW")
                                          ? Colors.red
                                          : Colors.blue,
                                    ),
                                  ),
                                ],
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
    );
    return Container();
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
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
