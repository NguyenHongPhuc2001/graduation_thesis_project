import 'package:flutter/material.dart';
class TargetHappening extends StatefulWidget {
  const TargetHappening({Key? key}) : super(key: key);

  @override
  State<TargetHappening> createState() => _TargetHappeningState();
}

class _TargetHappeningState extends State<TargetHappening> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Happening !!!"),);
  }
}
