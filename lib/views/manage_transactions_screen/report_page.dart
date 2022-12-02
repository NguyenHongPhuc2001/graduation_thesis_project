import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/chart/pie_item.dart';
import 'package:graduation_thesis_project/un_used/ExpenseNew.dart';
import 'package:graduation_thesis_project/models/Report.dart';
import 'package:graduation_thesis_project/utils/api.dart';
import 'package:graduation_thesis_project/utils/charts/pie.dart';
import 'package:intl/intl.dart';
import '../../remote/controllers/chart/pie_controller.dart';
import '../../remote/expense_dao_test.dart';
import '../commons/widgets/money_text_container.dart';
import '../commons/widgets/text_container.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter_new/flutter.dart' as charts_new;

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  List<charts_new.Series<dynamic, String>>  dataRecharge = [];
  List<charts_new.Series<dynamic, String>>  dataWithdraw = [];

  final List<Tab> listTabsWeek = [];
  final List<Tab> listTabsMonth = [];
  final PieItemController controller = Get.put(PieItemController());
  final DateFormat df = DateFormat("yyyy-MM-dd");
  var check = "Tháng",
      _selectedIndexWeek,
      _selectedIndexMonth,
      weekChosen = false,
      monthChosen = true;

  @override
  void initState() {

    super.initState();

    for (int i = 1; i <= 12; i++) {
      if (i == DateTime.now().month) {
        String now = "THÁNG NÀY";
        listTabsMonth.add(
          Tab(
            text: "${now}",
          ),
        );
      } else if (i == (DateTime.now().month - 1)) {
        String previous = "THÁNG TRƯỚC";
        listTabsMonth.add(
          Tab(
            text: "${previous}",
          ),
        );
      } else {
        listTabsMonth.add(
          Tab(
            text: "${i}/${DateTime.now().year}",
          ),
        );
      }
    }

    for (int i = 1; i <= 11; i++) {
      DateTime fdow = findFirstDateOfTheWeek(
          DateTime.now().subtract(Duration(days: 6 * i)));

      if (df.format(fdow) ==
          df.format(findFirstDateOfTheWeek(DateTime.now()))) {
        listTabsWeek.add(Tab(
          text: "TUẦN NÀY",
        ));
      } else if ((DateTime.now().difference(fdow).inDays) == 13) {
        listTabsWeek.add(Tab(
          text: "TUẦN TRƯỚC",
        ));
      } else {
        listTabsWeek.add(Tab(
          text:
              "${fdow.day}/${fdow.month} - ${fdow.add(Duration(days: 6)).day}/${fdow.add(Duration(days: 6)).month}",
        ));
      }
    }

    _selectedIndexMonth = DateTime.now().month - 1;
    _selectedIndexWeek = listTabsWeek.length - 1;

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _createData("MONTH", ApiPaths.HISTORY_GET_LIST_BY_RECHARGE_PIE_CHART.toString()).then((value){
      dataRecharge = value;
    });

    _createData("MONTH", ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_PIE_CHART.toString()).then((value){
      dataWithdraw = value;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: size.height * 0.12,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.2),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.white,
            highlightColor: Colors.white,
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      TextContainer(
                        text: "Số dư ví",
                        textColor: Colors.grey.shade600,
                        textSize: size.width * 0.05,
                        textFontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      MoneyTextContainer(
                        value: 2222222,
                        textSize: size.width * 0.05,
                        textFontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.075, right: size.width * 0.02),
            child: DropdownButton2(
              customButton: Icon(
                Icons.more_vert,
                color: Colors.black,
                size: size.width * 0.08,
              ),
              items: [
                ...MenuItems.firstItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item, context),
                  ),
                ),
                DropdownMenuItem<Divider>(
                  enabled: false,
                  child: Divider(
                    thickness: size.width * 0.002,
                    height: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                ...MenuItems.secondItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item, context),
                  ),
                ),
              ],
              onChanged: (value) {
                MenuItems.onChanged(context, value as MenuItem);
                setState(() {
                  check = value.text;
                  if (value.text == "Tuần") {
                    weekChosen = true;
                    monthChosen = false;
                  } else {
                    weekChosen = false;
                    monthChosen = true;
                  }
                });
              },
              itemPadding: EdgeInsets.all(size.width * 0.01),
              itemHeight: size.width * 0.08,
              dropdownWidth: size.width * 0.2,
              isDense: true,
              underline: Text(""),
              buttonHeight: size.width * 0.1,
              dropdownOverButton: true,
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
                      setState(() {});
                    },
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: size.width * 0.05,
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
                      setState(() {});
                      // print(value);
                    },
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: size.width * 0.05,
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
              height: size.width * 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.width * 0.07,
                  ),
                  TextContainer(
                    text: "Khoản thu &  khoản chi",
                    textColor: Colors.black,
                    textSize: size.width * 0.05,
                    textFontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.4,
                    child: charts.BarChart(
                      _createDataSample(check),
                      animate: false,
                      primaryMeasureAxis: new charts.NumericAxisSpec(
                        tickProviderSpec:
                            new charts.BasicNumericTickProviderSpec(
                                desiredTickCount: 7),
                        tickFormatterSpec: charts.BasicNumericTickFormatterSpec
                            .fromNumberFormat(
                          NumberFormat.compact(),
                        ),
                      ),
                      defaultRenderer: charts.BarRendererConfig(
                        groupingType: charts.BarGroupingType.grouped,
                      ),
                      domainAxis: new charts.OrdinalAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(
                          labelRotation: (check == "Tuần") ? 45 : 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.05),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(size.width * 0.02),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.red,
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
                              ),
                            ),
                            SizedBox(width: size.width*0.03),
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
                  ),

                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Thu nhập"),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: DonutAutoLabelChart(seriesList: dataRecharge, animate: false,),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Chi tiêu"),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: DonutAutoLabelChart(seriesList: dataWithdraw, animate: false,),
                          )
                        ],
                      )
                    ],
                  )

                ],
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

  List<charts.Series<Report, String>> _createDataSample(String check) {
    final List<ExpenseNew> listData = ExpenseDAO().getListData();
    final List<Report> listChi = [];
    final List<Report> listThu = [];

    if (check == "Tháng") {
      listChi.clear();
      listThu.clear();
      for (var element in listData) {
        if (DateTime.parse(element.expenseDate).month == 10) {
          if (DateTime.parse(element.expenseDate).day >= 1 &&
              DateTime.parse(element.expenseDate).day <= 7) {
            if (element.expenseType == "Chi") {
              listChi.add(new Report(
                  expenseId: element.expenseId,
                  reportType: "Chi",
                  reportTime: "Tuần 1",
                  reportValue: element.expenseValue));
            }
            if (element.expenseType == "Thu") {
              listThu.add(new Report(
                  expenseId: element.expenseId,
                  reportType: "Thu",
                  reportTime: "Tuần 1",
                  reportValue: element.expenseValue));
            }
          } else if (DateTime.parse(element.expenseDate).day >= 8 &&
              DateTime.parse(element.expenseDate).day <= 14) {
            if (element.expenseType == "Chi") {
              listChi.add(Report(
                  expenseId: element.expenseId,
                  reportType: "Chi",
                  reportTime: "Tuần 2",
                  reportValue: element.expenseValue));
            }
            if (element.expenseType == "Thu") {
              listThu.add(Report(
                  expenseId: element.expenseId,
                  reportType: "Thu",
                  reportTime: "Tuần 2",
                  reportValue: element.expenseValue));
            }
          } else if (DateTime.parse(element.expenseDate).day >= 15 &&
              DateTime.parse(element.expenseDate).day <= 21) {
            if (element.expenseType == "Chi") {
              listChi.add(Report(
                  expenseId: element.expenseId,
                  reportType: "Chi",
                  reportTime: "Tuần 3",
                  reportValue: element.expenseValue));
            }
            if (element.expenseType == "Thu") {
              listThu.add(Report(
                  expenseId: element.expenseId,
                  reportType: "Thu",
                  reportTime: "Tuần 3",
                  reportValue: element.expenseValue));
            }
          } else {
            if (element.expenseType == "Chi") {
              listChi.add(Report(
                  expenseId: element.expenseId,
                  reportType: "Chi",
                  reportTime: "Tuần 4",
                  reportValue: element.expenseValue));
            }
            if (element.expenseType == "Thu") {
              listThu.add(Report(
                  expenseId: element.expenseId,
                  reportType: "Thu",
                  reportTime: "Tuần 4",
                  reportValue: element.expenseValue));
            }
          }
        }
      }
    } else {
      listChi.clear();
      listThu.clear();
      DateFormat df = DateFormat("yyyy-MM-dd");
      var firstDate = findFirstDateOfTheWeek(DateTime.now());

      for (int i = 0; i < 7; i++) {
        int check = 0;
        List<ExpenseNew> listDataPut = [];
        listData.forEach((data) {
          if (df.format(DateTime.parse(data.expenseDate)) ==
              df.format(firstDate.add(Duration(days: i)))) {
            check++;
            listDataPut.add(data);
          }
        });

        if (check != 0) {
          listDataPut.forEach((item) {
            if (item.expenseType == "Chi") {
              listChi.add(Report(
                  expenseId: item.expenseId,
                  reportType: "Chi",
                  reportTime: df.format(firstDate.add(Duration(days: i))),
                  reportValue: item.expenseValue));
              listThu.add(Report(
                  reportType: "Thu",
                  reportTime: df.format(firstDate.add(Duration(days: i))),
                  reportValue: 0));
            } else {
              listThu.add(Report(
                  expenseId: item.expenseId,
                  reportType: "Thu",
                  reportTime: df.format(firstDate.add(Duration(days: i))),
                  reportValue: item.expenseValue));
              listChi.add(Report(
                  reportType: "Chi",
                  reportTime: df.format(firstDate.add(Duration(days: i))),
                  reportValue: 0));
            }
          });
        } else {
          listChi.add(Report(
              reportType: "Chi",
              reportTime: df.format(firstDate.add(Duration(days: i))),
              reportValue: 0));
          listThu.add(Report(
              reportType: "Thu",
              reportTime: df.format(firstDate.add(Duration(days: i))),
              reportValue: 0));
        }
      }
    }

    return [
      charts.Series<Report, String>(
        id: "Chi",
        data: listChi,
        domainFn: (Report expense, _) => expense.reportTime,
        measureFn: (Report expense, _) => expense.reportValue,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.darker,
      ),
      charts.Series<Report, String>(
        id: "Thu",
        data: listThu,
        domainFn: (Report expense, _) => expense.reportTime,
        measureFn: (Report expense, _) => expense.reportValue,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.darker,
      ),
    ];
  }
}

Future<List<charts_new.Series<dynamic, String>>> _createData(String datesType, String apiPaths) async {

  DateTime now = DateTime.now();
  String dateFormat = "${now.year}-${now.month}-${now.day}";
  List<PieItem> data = [];

  await PieItemController().getPieItems(dateFormat, datesType, apiPaths).then((value) {
    data = value!;
  });

  return [
    charts.Series<PieItem, String>(
      id: 'Sales',
      domainFn: (PieItem item, _) => item.expenseName,
      measureFn: (PieItem item, _) => item.totalCost,
      data: data,
      labelAccessorFn: (PieItem row, _) => '${row.expenseName}',
    )
  ];

}


class MenuItem {
  final String text;

  const MenuItem({
    required this.text,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [week];
  static const List<MenuItem> secondItems = [month];

  static const week = MenuItem(text: 'Tuần');
  static const month = MenuItem(text: 'Tháng');

  static Widget buildItem(MenuItem item, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        TextContainer(
          text: item.text,
          textColor: Colors.black,
          textSize: size.width * 0.045,
          textFontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.week:
        break;
      case MenuItems.month:
        break;
    }
  }
}
