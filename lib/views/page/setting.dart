import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/views/setting_screen/account_management.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AccountManagement(),
    );
  }
}
