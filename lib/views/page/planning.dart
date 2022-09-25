import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/views/plan_screen/plan_main_screen.dart';

class Planning extends StatefulWidget {
  const Planning({Key? key}) : super(key: key);

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  @override
  Widget build(BuildContext context) {
    return PlanMainScreen();
  }
}
