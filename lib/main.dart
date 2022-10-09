import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/ui/about_us.dart';
import 'package:graduation_thesis_project/ui/account_management.dart';
import 'package:graduation_thesis_project/ui/change_password.dart';
import 'package:graduation_thesis_project/ui/login.dart';
import 'package:graduation_thesis_project/ui/signup.dart';
import 'package:graduation_thesis_project/ui/wallet_create.dart';
import 'package:graduation_thesis_project/ui/wallet_list.dart';
import 'package:graduation_thesis_project/ui/wallet_setting.dart';
import 'package:graduation_thesis_project/views/page/overview.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Overview(),
    );
  }
}
