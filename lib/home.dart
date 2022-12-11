import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:graduation_thesis_project/views/page/overview.dart';

import 'package:graduation_thesis_project/views/page/setting.dart';
import 'package:graduation_thesis_project/views/plan_screen/plan_main_screen.dart';
import 'package:graduation_thesis_project/views/transaction_screen/expense_screen/expense_create.dart';
import 'package:graduation_thesis_project/views/transaction_screen/transaction_screen/transaction_create.dart';
import 'package:graduation_thesis_project/views/transaction_screen/wallet_screen/wallet_create.dart';

import 'views/manage_transactions_screen/main_page.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;

  bool check=false;

  String? checkStr = "test";


  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Overview();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 40,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              await Get.to(TransactionCreate())!.then((value){
                if(value=="Create"){
                  Fluttertoast.showToast(msg: "Tạo giao dịch thành công !");

                  setState(() {
                    check=true;
                    if(currentTab==1){
                      currentScreen =
                          ManageTransaction(check: check);
                    }
                  });

                }
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 100,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
            Expanded(
              flex: 1,
              child: MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Overview();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: currentTab == 0 ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      "Tổng quan",
                      style: TextStyle(
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                          fontSize: 9.5),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        ManageTransaction(check: true);
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wallet,
                      color: currentTab == 1 ? Colors.blue : Colors.grey,
                      size:30,
                    ),
                    Text(
                      "Giao dịch",
                      style: TextStyle(
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                          fontSize: 9.5),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const PlanMainScreen();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      color: currentTab == 2 ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      "Kế hoạch",
                      style: TextStyle(
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                          fontSize: 9.5),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentTab = 3;
                    currentScreen = const Setting();
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      color: currentTab == 3 ? Colors.blue : Colors.grey,
                      size:30,
                    ),
                    Text(
                      "Cài đặt",
                      style: TextStyle(
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                          fontSize: 9.5),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
