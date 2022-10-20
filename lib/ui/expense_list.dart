import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/ui/expense_setting.dart';
import 'package:graduation_thesis_project/utils/enums/expense_type.dart';
import 'package:graduation_thesis_project/utils/enums/history_type.dart';
import '../controllers/expense_controller.dart';
import 'expense_create.dart';

class ExpenseList extends StatefulWidget {

  final expenseController = Get.put(ExpenseController());

  ExpenseList({Key? key}) : super(key: key);

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {

  @override
  Widget build(BuildContext context) {

    _loadExpenseList();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Danh sách thu chi",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          elevation: 2,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                _loadWalletItem(widget.expenseController.expenseList),
                const SizedBox(),
                _addExpenseButton()
              ],

            )
        )
    );
  }

  Widget _addExpenseButton() {

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                color: Colors.grey
            )
          ]
      ),
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: InkWell(
          onTap: (){
            Get.to(ExpenseCreate());
          },
          child: const Text(
                "Thêm mới chi tiêu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
        ),
      )
    );
  }

  Widget _loadWalletItem(List<Expense> expenses) {

    List<Widget> walletItems = <Widget>[];
    for (var item in expenses) {
      walletItems.add(GestureDetector(
        onTap: () {
          Get.to(ExpenseSetting(expenseId: item.expenseId, expenseName: item.expenseName, expenseType: item.expenseType, expenseIcon: item.expenseIcon));
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Colors.grey
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(item.expenseIcon),
                        )
                      ],
                    ),
              ),
              Text(
                    item.expenseName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: item.expenseType == HistoryType.INCOME.name ? Colors.blue : Colors.red,
                    borderRadius: BorderRadius.circular(100)
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    item.expenseType == ExpenseType.INCOME.name ? "Thu nhập" : "Chi tiêu",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }

    return Column(children: walletItems);

  }

  _loadExpenseList() {
    widget.expenseController.getExpenses();
  }

}
