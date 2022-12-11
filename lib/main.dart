import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/home.dart';
import 'package:graduation_thesis_project/un_used/WalletNew.dart';
import 'package:graduation_thesis_project/utils/charts/pie.dart';
import 'package:graduation_thesis_project/views/root.dart';

import 'generated/l10n.dart';

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
      home: const RootPage()
    );
  }
}
