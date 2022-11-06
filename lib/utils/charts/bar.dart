import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CustomRoundedBars extends StatelessWidget {

  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  const CustomRoundedBars({Key? key, required this.seriesList, this.animate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(25),
      ),
    );
  }

}
