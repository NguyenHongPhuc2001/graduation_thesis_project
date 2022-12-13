import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../models/chart/pie_item.dart';
import '../../remote/controllers/chart/pie_controller.dart';
import '../api_paths/api_paths.dart';
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
      seriesList: _createData(),
      animate: false
    );
  }

  @override
  Widget build(BuildContext context) {

    try{

      if(seriesList[0].data.isNotEmpty){

        return charts.PieChart<String>(
            seriesList,
            animate: animate,
            defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 60,
                arcRendererDecorators: [charts.ArcLabelDecorator()])
        );

      }

      return charts.PieChart<String>(
          seriesList,
          animate: animate
      );

    }catch(e){

      return charts.PieChart<String>(
          seriesList,
          animate: animate
      );

    }

  }

  static List<charts.Series<dynamic, String>> _createData() {

    DateTime now = DateTime.now();
    String dateFormat = "${now.year}-${now.month}-${now.day}";

    PieItemController().getPieItems(dateFormat, "MONTH", ApiPaths.HISTORY_GET_LIST_BY_WITHDRAW_PIE_CHART.toString()).then((value) async {
       data = value!;
    });

    return [
      charts.Series<PieItem, String>(
        id: 'Sales',
        domainFn: (PieItem item, _) => item.expenseName,
        measureFn: (PieItem item, _) => item.totalCost,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (PieItem row, _) => row.expenseName,
      )
    ];
  }

}
