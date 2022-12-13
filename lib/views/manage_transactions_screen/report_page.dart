// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/chart/bar_item.dart';
import 'package:graduation_thesis_project/models/chart/pie_item.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/history_controller.dart';
import 'package:graduation_thesis_project/utils/charts/pie.dart';
import 'package:graduation_thesis_project/utils/enums/history_action.dart';
import 'package:intl/intl.dart';
import '../../remote/controllers/chart/pie_controller.dart';
import '../../utils/api_paths/api_paths.dart';
import '../commons/widgets/text_container.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter_new/flutter.dart' as charts_new;

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<charts_new.Series<dynamic, String>> dataRecharge = [];
  List<charts_new.Series<dynamic, String>> dataWithdraw = [];

  List<charts.Series<BarItem, String>> dataBarChart = [];
  List<charts.Series<BarItem, String>> dataRechargeBarChart = [];

  final List<Tab> listTabsWeek = [];
  final List<Tab> listTabsMonth = [];
  List<DateTime> listDateWeek = [];
  final PieItemController controller = Get.put(PieItemController());
  final DateFormat df = DateFormat("yyyy-MM-dd");
  final listItems = <String>["Tuần", "Tháng"];

  DateTime currentDate = DateTime.now();

  var check = "Tháng",
      _selectedIndexWeek,
      _selectedIndexMonth,
      weekChosen = false,
      monthChosen = true,
      checkLoad = false;

  @override
  void initState() {
    super.initState();

    checkLoad = true;

    for (int i = 1; i <= 12; i++) {
      if (i == DateTime.now().month) {
        String now = "THÁNG NÀY";
        listTabsMonth.add(
          Tab(
            text: now,
          ),
        );
      } else if (i == (DateTime.now().month - 1)) {
        String previous = "THÁNG TRƯỚC";
        listTabsMonth.add(
          Tab(
            text: previous,
          ),
        );
      } else {
        listTabsMonth.add(
          Tab(
            text: "$i/${DateTime.now().year}",
          ),
        );
      }
    }

    for (int i = 0; i <= 12; i++) {
      DateTime fdow = findFirstDateOfTheWeek(
          DateTime.now().subtract(Duration(days: 7 * i)));

      if (df.format(fdow) ==
          df.format(findFirstDateOfTheWeek(DateTime.now()))) {
        listTabsWeek.add(const Tab(
          text: "TUẦN NÀY",
        ));
        listDateWeek.add(
            fdow);
      } else if ((DateTime.now().difference(fdow).inDays) == 10) {

        listTabsWeek.add(const Tab(
          text: "TUẦN TRƯỚC",
        ));
        listDateWeek.add(
            fdow);
      } else {
        listTabsWeek.add(Tab(
          text:
              "${fdow.day}/${fdow.month} - ${fdow.add(const Duration(days: 6)).day}/${fdow.add(const Duration(days: 7)).month}",
        ));
        listDateWeek.add(
            fdow);
      }
    }

    _selectedIndexMonth = currentDate.month - 1;
    _selectedIndexWeek = listTabsWeek.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (checkLoad == true) {
      if(check=="Tháng"){
        _createData(currentDate,"MONTH",
            ApiPaths.HISTORY_GET_LIST_BY_RECHARGE_PIE_CHART.toString())
            .then((value) {
          setState(() {
            dataRecharge = value;
          });
        });
        _createData(currentDate,"MONTH",
            ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_PIE_CHART.toString())
            .then((value) {
          setState(() {
            dataWithdraw = value;
          });
        });

        _barChartData("Tháng", currentDate).then((value) {
          setState(() {
            dataBarChart = value;
          });
        });
      }else{
        _createData(currentDate,"WEEK",
            ApiPaths.HISTORY_GET_LIST_BY_RECHARGE_PIE_CHART.toString())
            .then((value) {
          setState(() {
            dataRecharge = value;
          });
        });
        _createData(currentDate,"WEEK",
            ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_PIE_CHART.toString())
            .then((value) {
          setState(() {
            dataWithdraw = value;
          });
        });

        _barChartData("Tuần", currentDate).then((value) {
          setState(() {
            dataBarChart = value;
          });
        });
      }

      setState(() {
        checkLoad = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: size.height * 0.12,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextContainer(
          text: "Trang thống kê",
          textColor: Colors.black,
          textSize: size.width * 0.05,
          textFontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.02),
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (value) async {
                setState(() {
                  check = value;
                  if (value == "Tháng") {
                    weekChosen = false;
                    monthChosen = true;
                    checkLoad = true;
                    currentDate = findFirstDateOfTheWeek(DateTime.now());
                  } else {
                    checkLoad = true;
                    weekChosen = true;
                    monthChosen = false;
                    currentDate = findFirstDateOfTheWeek(DateTime.now());
                  }
                });
              },
              itemBuilder: (BuildContext context) {
                return listItems.map((String choice) {
                  return PopupMenuItem<String>(
                    onTap: () {},
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.09),
          child: Column(
            children: [
              Visibility(
                visible: weekChosen,
                child: DefaultTabController(
                  initialIndex: _selectedIndexWeek,
                  length: listTabsWeek.length,
                  child: TabBar(
                    onTap: (value) {
                      setState((){
                        currentDate = listDateWeek.reversed.toList()[value];
                        checkLoad=true;
                      });
                    },
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    isScrollable: true,
                    tabs: (listTabsWeek.reversed).toList(),
                  ),
                ),
              ),
              Visibility(
                visible: monthChosen,
                child: DefaultTabController(
                  initialIndex: _selectedIndexMonth,
                  length: listTabsMonth.length,
                  child: TabBar(
                    onTap: (value) {
                      setState(() {
                        currentDate = df.parse(
                            "${currentDate.year}-${value + 1}-${currentDate.day}");
                        checkLoad = true;
                      });
                    },
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    isScrollable: true,
                    tabs: listTabsMonth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
              width: size.width,
              height: size.width * 1.2,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.03, bottom: size.height * 0.03),
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 0.2,
                          spreadRadius: 1
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.width * 0.07,
                    ),
                    Center(
                      child: TextContainer(
                        text: "Khoản thu &  khoản chi",
                        textColor: Colors.black,
                        textSize: size.width * 0.05,
                        textFontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.4,
                      child: charts.BarChart(
                        dataBarChart,
                        animate: false,
                        primaryMeasureAxis: charts.NumericAxisSpec(
                          tickProviderSpec:
                          const charts.BasicNumericTickProviderSpec(
                              desiredTickCount: 7),
                          tickFormatterSpec: charts.BasicNumericTickFormatterSpec
                              .fromNumberFormat(
                            NumberFormat.compact(),
                          ),
                        ),
                        defaultRenderer: charts.BarRendererConfig(
                          groupingType: charts.BarGroupingType.grouped,
                        ),
                        domainAxis: charts.OrdinalAxisSpec(
                          renderSpec: charts.SmallTickRendererSpec(
                            labelRotation: (check == "Tuần") ? 45 : 0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(size.width * 0.02),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            TextContainer(
                                text: "Chi",
                                textColor: Colors.black,
                                textSize: size.width * 0.04,
                                textFontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(size.width * 0.02),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            TextContainer(
                                text: "Thu",
                                textColor: Colors.black,
                                textSize: size.width * 0.04,
                                textFontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.2,
                      spreadRadius: 1
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        TextContainer(
                          text: "Thống kê tổng",
                          textColor: Colors.black,
                          textSize: size.width * 0.05,
                          textFontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: size.width * 0.2,
                                    height: size.height * 0.03,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Text(
                                        "Chi tiêu",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                                SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: DonutAutoLabelChart(
                                    seriesList: dataWithdraw,
                                    animate: false,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: size.width * 0.2,
                                    height: size.height * 0.03,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Text(
                                      "Thu nhập",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                                SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: DonutAutoLabelChart(
                                    seriesList: dataRecharge,
                                    animate: false,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getNameOfDay(int weekday) {
    String name = "Hôm nay";
    switch (weekday) {
      case 1:
        name = "Thứ hai";
        break;
      case 2:
        name = "Thứ ba";
        break;
      case 3:
        name = "Thứ tư";
        break;
      case 4:
        name = "Thứ năm";
        break;
      case 5:
        name = "Thứ sáu";
        break;
      case 6:
        name = "Thứ bảy";
        break;
      case 7:
        name = "Chủ nhật";
        break;
    }
    return name;
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }
}

Future<List<charts.Series<BarItem, String>>> _barChartData(
    String check, DateTime time) async {
  List<BarItem> listChi = [];
  List<BarItem> listThu = [];

  if (check == "Tháng") {
    listChi.clear();
    listThu.clear();

    DateTime lastDayOfMonth = DateTime(time.year, time.month + 1, 0);

    await HistoryController()
        .getTotalCostBetweenDate(time.year.toString(), time.month.toString(),
            HistoryAction.WITHDRAW.name, lastDayOfMonth.day.toString())
        .then((value) {
          for (var element in value) {
            String date= "Tuần 1";
            if(element.dateType=="Week 1"){
              date = "Tuần 1";
            }else if(element.dateType=="Week 2"){
              date = "Tuần 2";
            }else if(element.dateType=="Week 3"){
              date = "Tuần 3";
            }else{
              date = "Tuần 4";
            }
            listChi.add(BarItem(dateType: date, totalCost: element.totalCost));
          }
    });

    await HistoryController()
        .getTotalCostBetweenDate(time.year.toString(), time.month.toString(),
            HistoryAction.RECHARGE.name, lastDayOfMonth.day.toString())
        .then((value) {
      for (var element in value) {
        String date= "Tuần 1";
        if(element.dateType=="Week 1"){
          date = "Tuần 1";
        }else if(element.dateType=="Week 2"){
          date = "Tuần 2";
        }else if(element.dateType=="Week 3"){
          date = "Tuần 3";
        }else{
          date = "Tuần 4";
        }
        listThu.add(BarItem(dateType: date, totalCost: element.totalCost));
      }
    });


    if(listChi.isEmpty&&listThu.isEmpty){
      for(int i=1;i<=4;i++){
        listChi.add(BarItem(dateType: "Tuần $i", totalCost: 0.0));
        listThu.add(BarItem(dateType: "Tuần $i", totalCost: 0.0));
      }
    }

  } else {
    listChi.clear();
    listThu.clear();

    DateFormat df = DateFormat("yyyy-MM-dd");

    for(int i=0;i<7;i++){
      String dateTime = df.format(time.add(Duration(days: i)));

      await HistoryController().getTotalCostOfWithdraw(dateTime, "DAY").then((value){
        listChi.add(BarItem(dateType: dateTime, totalCost: value.totalCost));
      });

      await HistoryController().getTotalCostOfRecharge(dateTime, "DAY").then((value){
        listThu.add(BarItem(dateType: dateTime, totalCost: value.totalCost));
      });
    }

    if(listThu.isEmpty&&listChi.isEmpty){
      for(int i=0;i<7;i++){
        String dateTime = df.format(time.add(Duration(days: i)));
        listChi.add(BarItem(dateType: dateTime, totalCost: 0.0));
        listThu.add(BarItem(dateType: dateTime, totalCost: 0.0));
      }
    }

  }

  
  return [
    charts.Series<BarItem, String>(
      id: "Chi",
      data: listChi,
      domainFn: (BarItem item, _) => item.dateType,
      measureFn: (BarItem item, _) => item.totalCost,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.darker,
    ),
    charts.Series<BarItem, String>(
      id: "Thu",
      data: listThu,
      domainFn: (BarItem item, _) => item.dateType,
      measureFn: (BarItem item, _) => item.totalCost,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.darker,
    ),
  ];
}

Future<List<charts_new.Series<dynamic, String>>> _createData(DateTime dateTime,
    String datesType, String apiPaths) async {
  
  String dateFormat = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  List<PieItem> data = [];

  await PieItemController()
      .getPieItems(dateFormat, datesType, apiPaths)
      .then((value) {
    data = value!;
  });

  if(data.isEmpty){
    data.add(PieItem(expenseName: "", totalCost: 0.0));
  }

  return [
    charts.Series<PieItem, String>(
      id: 'Sales',
      domainFn: (PieItem item, _) => item.expenseName,
      measureFn: (PieItem item, _) => item.totalCost,
      data: data,
      labelAccessorFn: (PieItem row, _) => row.expenseName,
    )
  ];
}
