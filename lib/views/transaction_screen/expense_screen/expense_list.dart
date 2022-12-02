import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/utils/enums/expense_type.dart';
import 'package:graduation_thesis_project/utils/enums/history_type.dart';


import '../../../remote/controllers/entites/expense_controller.dart';
import 'expense_create.dart';

class ExpenseList extends StatefulWidget {

  final expenseController = Get.put(ExpenseController());
  final bool isLoadByBudget;
  ExpenseList({Key? key, required this.isLoadByBudget}) : super(key: key);

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {

  List<Expense> listExpense =[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadExpenseList();
  }


  @override
  Widget build(BuildContext context) {


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
                _loadExpenseItem(widget.expenseController.expenseList, widget.isLoadByBudget),
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
            Get.to(ExpenseCreate(isLoadByBudget: true,))!.then((value) {
              if(value=="Create"){
                Fluttertoast.showToast(msg: "Thêm chi tiêu thành công !");
              }
            });
          },
          child: Text(
                widget.isLoadByBudget ? "Thêm mới chi tiêu" : "Thêm mới chi tiêu",
                style: const TextStyle(
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
            Navigator.of(context).pop(item);
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

 _loadExpenseList() async {
    await widget.expenseController.getExpenses();
  }

}
