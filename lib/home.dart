import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/dao/transaction_dao.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/page/overview.dart';
import 'package:graduation_thesis_project/views/page/planning.dart';
import 'package:graduation_thesis_project/views/page/setting.dart';
import 'package:graduation_thesis_project/views/page/transaction.dart';
import 'package:graduation_thesis_project/views/transaction_screen/transaction_add.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Transactions> listTran = TransactionDAO().getAll();

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Overview();

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
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransaction(
                    listTransaction: listTran,
                  ),
                ),
              ).then((value) => setState(() {
                    if (value == "Save Transaction")
                      Fluttertoast.showToast(
                          msg: "Thêm giao dịch thành công !");
                  }));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                  Widget>[
            Expanded(
              flex: 1,
              child: MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const Overview();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: currentTab == 0 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Tổng quan",
                      style: TextStyle(
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                          fontSize: 6),
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
                    currentScreen = Transaction(
                      listTransaction: listTran,
                    );
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wallet,
                      color: currentTab == 1 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Giao dịch",
                      style: TextStyle(
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                          fontSize: 6),
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
                    currentTab = 2;
                    currentScreen = Planning(
                      listTransaction: listTran,
                    );
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      color: currentTab == 2 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Kế hoạch",
                      style: TextStyle(
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                          fontSize: 6),
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
                    ),
                    Text(
                      "Cài đặt",
                      style: TextStyle(
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                          fontSize: 6),
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
