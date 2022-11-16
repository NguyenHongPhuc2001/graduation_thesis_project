import 'package:charts_flutter_new/flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/utils/charts/pie.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';
import 'package:graduation_thesis_project/views/page/overview.dart';

import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_detail.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_screen.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_select_rap.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    Budget budget = Budget(budgetId: 4, budgetName: "test", budgetIcon: "images/FoodIcon_4.svg", budgetValue: 555555.00, budgetMothYear: "2022-10");

    return GetMaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: DonutAutoLabelChart.withSampleData()
    );
  }
}
