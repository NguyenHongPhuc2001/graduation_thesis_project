import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/response/list_days_have_transaction.dart';
import 'package:graduation_thesis_project/views/manage_transactions_screen/report_page.dart';
import 'package:graduation_thesis_project/views/transaction_screen/transaction_screen/transaction_detail.dart';

import 'package:intl/intl.dart';

import '../../models/history.dart';
import '../../remote/controllers/entites/history_controller.dart';
import '../commons/widgets/circle_icon_container.dart';
import '../commons/widgets/custom_round_rectangle_button.dart';
import '../commons/widgets/money_text_container.dart';
import '../commons/widgets/single_row_container.dart';
import '../commons/widgets/text_container.dart';

// ignore: must_be_immutable
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
  List<ListDaysHaveTransaction> listDays = [];
  final df_month = DateFormat("yyyy-MM");
  final df_week = DateFormat("yyyy-MM-dd");
  var month, totalWithdraw, totalRecharge;

  @override
  void initState() {
    super.initState();

    month = "${DateTime.now().year}-${widget.month + 1}";

    widget.historyController
        .getListDaysHaveTransactionByMonth(month)
        .then((value) {
      setState(() {
        listDays = List.from(value!);
      });
    });

    widget.historyController.getListTransactionByDate(month, "MONTH").then((value) {
      setState(() {
        listTransactionByMonth = List.from(value!);
      });
    });

    widget.historyController.getTotalCostOfWithdraw(df_week.format(DateTime.now()), "MONTH").then((value) {
      setState(() {
        totalWithdraw = value.totalCost;
      });
    });

    widget.historyController.getTotalCostOfRecharge(df_week.format(DateTime.now()), "MONTH").then((value) {
      setState(() {
        totalRecharge = value.totalCost;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    if (widget.check == true) {
      month = "${DateTime.now().year}-${widget.month + 1}";

      widget.historyController
          .getListDaysHaveTransactionByMonth(month)
          .then((value) {
        setState(() {
          listDays = List.from(value!);
        });
      });

      widget.historyController.getListTransactionByDate(month, "MONTH").then((value) {
        setState(() {
          listTransactionByMonth = List.from(value!);
        });
      });

      widget.historyController.getTotalCostOfWithdraw(df_week.format(DateTime.now()), "MONTH").then((value) {
        setState(() {
          totalWithdraw = value.totalCost;
        });
      });

      widget.historyController.getTotalCostOfRecharge(df_week.format(DateTime.now()), "MONTH").then((value) {
        setState(() {
          totalRecharge = value.totalCost;
        });
      });

      setState(() {
        widget.check = false;
      });
    }



    return (listDays.isEmpty == false)
        ? CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
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
                            value: (totalRecharge!=null)?totalRecharge:0,
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
                            value: (totalWithdraw!=null)?totalWithdraw:0,
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
                        value: (totalWithdraw!=null && totalRecharge!=null)?totalRecharge-totalWithdraw:0,
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
                                      builder: (context) =>
                                          const ReportPage()));
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
                delegate:
                    SliverChildBuilderDelegate(childCount: listDays.length,
                        (BuildContext context, int index) {
                  List<History> listTransactionByDay = [];

                  listTransactionByMonth.reversed.toList().forEach((element) {
                    DateTime d1 = df_week.parse(element.historyNotedDate!);
                    DateTime d2 = df_week
                        .parse(listDays.reversed.toList()[index].date)
                        .subtract(const Duration(days: 1));
                    if (d1.compareTo(d2) == 0) {
                      listTransactionByDay.add(element);
                    }
                  });

                  double sum = 0.0;

                  listTransactionByDay.reversed.toList().forEach((element) {
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
                            offset: const Offset(0, 0),
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
                                      .parse(listDays.reversed.toList()[index].date)
                                      .day
                                      .toString(),
                                  textColor: Colors.black,
                                  textSize: size.width * 0.07,
                                  textFontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.52,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextContainer(
                                      text: getNameOfDays(df_week
                                          .parse(listDays.reversed.toList()[index].date)
                                          .weekday),
                                      textColor: Colors.black,
                                      textSize: size.width * 0.04,
                                      textFontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                    TextContainer(
                                      text:
                                          "tháng ${df_week.parse(listDays.reversed.toList()[index].date).month} năm ${df_week.parse(listDays.reversed.toList()[index].date).year}",
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
                          SizedBox(
                            width: size.width,
                            height:
                                size.width * 0.15 * listTransactionByDay.length,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listTransactionByDay.length,
                                itemBuilder:
                                    (BuildContext context, int index1) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        TransactionDetail(
                                            transaction:
                                                listTransactionByDay[index1]),
                                      )!.then((value) {
                                        if(value=="Update"){
                                          widget.historyController.getListTransactionByDate(month, "MONTH").then((value) {
                                            setState(() {
                                              listTransactionByMonth = List.from(value!);
                                            });
                                          });
                                          Fluttertoast.showToast(msg: "Cập nhật thành công !");
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                      width: size.width,
                                      height: size.width*0.15,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.01),
                                            child: SizedBox(
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
                                          SizedBox(
                                            width: size.width * 0.5,
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
                                                SizedBox(
                                                  width: size.width*0.4,
                                                  child: TextContainer(
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.3,
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
        : Scaffold(
            body: Center(
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
                              decoration: const BoxDecoration(
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
                )),
          );
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
