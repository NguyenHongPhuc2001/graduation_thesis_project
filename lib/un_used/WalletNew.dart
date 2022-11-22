import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../models/budget.dart';
import '../models/expense.dart';
import '../remote/controllers/entites/budget_controller.dart';
import '../views/commons/pages/select_icon.dart';
import '../views/transaction_screen/expense_screen/expense_list.dart';

class UiTest extends StatefulWidget {

  final List<Budget>? listBudget;

  const UiTest({Key? key, this.listBudget,}) : super(key: key);

  @override
  State<UiTest> createState() => _UiTestState();
}

class _UiTestState extends State<UiTest> {

  final _budgetMoneyController = MoneyMaskedTextController(
      thousandSeparator: ',',
      initialValue: 0,
      precision: 0,
      decimalSeparator: '');
  final DateFormat df = DateFormat("yyyy-MM");
  // ignore: prefer_typing_uninitialized_variables
  var dateTime, linkIcon;
  String budgetValue = "";
  final pageController = PageController();

  String? budgetIcon;
  String? budgetName;
  Expense? expense;

  final budgetNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            "Thêm mới ngân sách",
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.05
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.52,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 2,
                        color: Colors.grey
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(top: 20),
                      width: size.width * 0.8,
                      height: size.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2
                            )
                          ]
                      ),
                      child: TextField(
                        controller: budgetNameController,
                        onChanged: (value) => budgetName = value,
                        textAlign: TextAlign.center,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Nhập tên ngân sách",
                          hintStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () async {
                        budgetIcon = await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SelectIcons())
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        padding: const EdgeInsets.all(18),
                        child: SvgPicture.asset(budgetIcon == null ? "" : budgetIcon!),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: const Text(
                                'Thời gian diễn ra',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              width: size.width * 0.4,
                              height: size.width * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () async {
                                    DateTime? dateValue = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2200),
                                      fieldLabelText: "Ngày",
                                      cancelText: "THOÁT",
                                      confirmText: "XÁC NHẬN",
                                      helpText: "CHỌN NGÀY",
                                    );

                                    setState(() {
                                      dateTime = dateValue as DateTime;
                                      final int year1, year2, month1, month2, day1, day2;
                                      DateTime t = dateTime;
                                      DateTime t2 = DateTime.now();
                                      year1 = t.year;
                                      month1 = t.month;
                                      day1 = t.day;
                                      year2 = t2.year;
                                      month2 = t2.month;
                                      day2 = t2.day;

                                      if (year1 < year2) {
                                        setState(() {
                                          dateTime = null;
                                        });
                                        _showCalendarDialog();
                                      } else if (year1 == year2 && month1 < month2) {
                                        setState(() {
                                          dateTime = null;
                                        });
                                        _showCalendarDialog();
                                      } else if (year1 == year2 &&
                                          month1 == month2 &&
                                          day1 < day2) {
                                        setState(() {
                                          dateTime = null;
                                        });
                                        _showCalendarDialog();
                                      }
                                    });
                                  },
                                  child: SizedBox(
                                    child: dateTime == null
                                        ? Text(
                                      "test",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.04,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                        : Text(
                                      df.format(dateTime),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.04,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: const Text(
                                'Loại chi tiêu',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              width: size.width * 0.4,
                              height: size.width * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () async {
                                    expense = await Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => ExpenseList(isLoadByBudget: true)));
                                  },
                                  child: SizedBox(
                                    child:  Text(
                                      "",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.04,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: const Text(
                                'Giá trị ngân sách',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              width: size.width * 0.4,
                              height: size.width * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextField(
                                      controller: _budgetMoneyController,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 15),
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide.none
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide.none
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(3),
                                      margin: const EdgeInsets.symmetric(horizontal: 1),
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: const Text(
                                        "VNĐ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  BudgetController().createBudget(budgetName, double.parse(_budgetMoneyController.text.toString().replaceAll(",", "")),
                      budgetIcon, df.format(dateTime), expense);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)
                ),
                child: const Text(
                    "Tạo mới ngân sách"
                ),
              ),
            ],
          ),
        )
    );
  }

  _showCalendarDialog() {
    Size size = MediaQuery
        .of(context)
        .size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Chờ chút",
              style: TextStyle(
                fontSize: size.width * 0.07,
                color: Colors.black,
              ),
            ),
            content: Text(
              "Ngày không hợp lệ ! Vui lòng chọn lại !",
              style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.04,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: size.width * 0.005, bottom: size.width * 0.005),
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

}
