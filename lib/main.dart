import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/Transaction.dart';
import 'package:graduation_thesis_project/ui/about_us.dart';
import 'package:graduation_thesis_project/ui/account_management.dart';
import 'package:graduation_thesis_project/ui/change_password.dart';
import 'package:graduation_thesis_project/ui/expense_list.dart';
import 'package:graduation_thesis_project/ui/expense_setting.dart';
import 'package:graduation_thesis_project/ui/login.dart';
import 'package:graduation_thesis_project/ui/signup.dart';
import 'package:graduation_thesis_project/ui/wallet_create.dart';
import 'package:graduation_thesis_project/ui/wallet_list.dart';
import 'package:graduation_thesis_project/ui/wallet_setting.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';
import 'package:graduation_thesis_project/views/page/overview.dart';
import 'package:graduation_thesis_project/ui/budget_add.dart';
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
    return GetMaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ExpenseList(),
    );
  }
}
