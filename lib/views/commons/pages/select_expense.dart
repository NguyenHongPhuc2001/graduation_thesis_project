import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';

import 'package:graduation_thesis_project/utils/enums/expense_type.dart';
import 'package:graduation_thesis_project/utils/enums/history_type.dart';
import 'package:graduation_thesis_project/views/transaction_screen/expense_screen/expense_create.dart';


import '../../../remote/controllers/entites/expense_controller.dart';
import '../../transaction_screen/expense_screen/expense_setting.dart';


class SelectExpense extends StatefulWidget {

  final expenseController = Get.put(ExpenseController());
  final bool isLoadByBudget;
  SelectExpense({Key? key, required this.isLoadByBudget}) : super(key: key);

  @override
  State<SelectExpense> createState() => _SelectExpenseState();
}

class _SelectExpenseState extends State<SelectExpense> {

  var expense;
  List<Expense> listExpense =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ExpenseController().getExpenses().then((value) {
      setState(() {
        listExpense = List.from(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    _loadExpenseList();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Danh sách giao dịch",
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
                _loadExpenseItem(listExpense, widget.isLoadByBudget),
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
            Get.to(ExpenseCreate(isLoadByBudget: true));
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

  Widget _loadExpenseItem(List<Expense> expenses, bool isLoadByBudget) {

    List<Widget> walletItems = <Widget>[];
    if(isLoadByBudget){
      expenses = expenses.where((e) => e.expenseType == ExpenseType.DISBURSE.name).toList();
    }
    for (var item in expenses) {
      walletItems.add(GestureDetector(
        onTap: () {
          if(isLoadByBudget){
            setState(() {
              expense = item;
            });
            Navigator.pop(context,expense);
          }else{
            Get.to(ExpenseSetting(expenseId: item.expenseId, expenseName: item.expenseName, expenseType: item.expenseType, expenseIcon: item.expenseIcon));
          }
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
