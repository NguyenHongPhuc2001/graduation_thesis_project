import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';
import 'package:graduation_thesis_project/utils/api.dart';

import '../../models/chart/pie_item.dart';
import '../date/date_utils.dart';

// ignore: must_be_immutable
class DonutAutoLabelChart extends StatelessWidget {

  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;
  static List<PieItem> data = [];


  List<String> datesWeek = DateUtilsCustom().getDateOfWeek(DateTime.now());

  DonutAutoLabelChart({Key? key, required this.seriesList, this.animate}) : super(key: key);

  factory DonutAutoLabelChart.withSampleData() {
    return DonutAutoLabelChart(
      seriesList: _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return charts.PieChart<String>(
      seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 60,
          arcRendererDecorators: [charts.ArcLabelDecorator()])
    );
  }

  static List<charts.Series<dynamic, String>> _createSampleData() {

    DateTime now = DateTime.now();
    String dateFormat = "${now.year}-${now.month}-${now.day}";

    RemoteService().getPieItems("ChuTT", dateFormat, "MONTH", ApiPaths.HISTORY_GET_LIST_BY_RECHARGE_PIE_CHART.toString()).then((value) async {
       data = await value!;
    });

    return [
      charts.Series<PieItem, String>(
        id: 'Sales',
        domainFn: (PieItem item, _) => item.expenseName,
        measureFn: (PieItem item, _) => item.totalCost,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (PieItem row, _) => '${row.expenseName}',
      )
    ];
  }

}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

