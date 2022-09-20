import 'package:flutter/material.dart';

class Planning extends StatefulWidget {
  const Planning({Key? key}) : super(key: key);

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Planning"),),
      body: Center(
        child: Text("Planning Page", style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
