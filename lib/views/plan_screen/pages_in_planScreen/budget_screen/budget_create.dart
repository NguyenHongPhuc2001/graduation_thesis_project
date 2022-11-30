import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_expense.dart';

import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../../../../../models/budget.dart';
import '../../../../../../models/expense.dart';
import '../../../../../../remote/controllers/entites/budget_controller.dart';
import '../../../transaction_screen/expense_screen/expense_list.dart';

class BudgetCreate extends StatefulWidget {
  final List<Budget>? listBudget;

  const BudgetCreate({
    Key? key,
    this.listBudget,
  }) : super(key: key);

  @override
  State<BudgetCreate> createState() => _BudgetCreateState();
}

class _BudgetCreateState extends State<BudgetCreate> {
  final _budgetMoneyController = MoneyMaskedTextController(
      thousandSeparator: ',',
      initialValue: 0,
      precision: 0,
      decimalSeparator: '');
  final DateFormat df = DateFormat("yyyy-MM");

  // ignore: prefer_typing_uninitialized_variables
  final pageController = PageController();

  var expense,budgetIcon,budgetValue,budgetEndDate;

  final budgetNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    budgetEndDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            "Thêm mới ngân sách",
            style: TextStyle(color: Colors.black, fontSize: size.width * 0.05),
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
                        blurRadius: 1, spreadRadius: 2, color: Colors.grey)
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: size.width * 0.8,
                      height: size.width * 0.1,
                      child: TextField(
                        controller: budgetNameController,
                        textAlign: TextAlign.center,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: size.width * 0.005)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade600,
                                  width: size.width * 0.005)),
                          // filled: true,
                          fillColor: Colors.white,
                          hintText: "Nhập tên ngân sách",
                          hintStyle: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SelectIcons())).then((value) {
                                  setState(() {
                                    budgetIcon = value;
                                  });
                        });
                      },
                      child: CircleIconContainer(
                          urlImage: (budgetIcon != null)
                              ? budgetIcon!
                              : "images/QuestionIcon.svg",
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.yellow,
                          padding: size.width * 0.05),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: const Text(
                                'Thời gian diễn ra',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ]),
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
                                    budgetEndDate = dateValue as DateTime;
                                    final int year1,
                                        year2,
                                        month1,
                                        month2,
                                        day1,
                                        day2;
                                    DateTime t = budgetEndDate;
                                    DateTime t2 = DateTime.now();
                                    year1 = t.year;
                                    month1 = t.month;
                                    day1 = t.day;
                                    year2 = t2.year;
                                    month2 = t2.month;
                                    day2 = t2.day;

                                    if (year1 < year2) {
                                      setState(() {
                                        budgetEndDate = null;
                                      });
                                      _showCalendarDialog();
                                    } else if (year1 == year2 &&
                                        month1 < month2) {
                                      setState(() {
                                        budgetEndDate = null;
                                      });
                                      _showCalendarDialog();
                                    } else if (year1 == year2 &&
                                        month1 == month2 &&
                                        day1 < day2) {
                                      setState(() {
                                        budgetEndDate = null;
                                      });
                                      _showCalendarDialog();
                                    }
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    child: budgetEndDate == null
                                        ? Text(
                                            "Chọn ngày",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: size.width * 0.04,
                                              decoration: TextDecoration.none,
                                            ),
                                          )
                                        : Text(
                                            df.format(budgetEndDate),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ]),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => SelectExpense(
                                              isLoadByBudget: true))).then((value) {
                                                setState(() {
                                                  expense = value;
                                                });
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      expense == null
                                          ? "Chọn chi tiêu"
                                          : expense!.expenseName.toString(),
                                      style: TextStyle(
                                        color: expense == null?Colors.grey:Colors.black,
                                        fontSize: size.width * 0.04,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w400
                                      ),
                                    )),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ]),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextField(
                                    textAlign: TextAlign.center,
                                    controller: _budgetMoneyController,
                                    autofocus: false,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.blue),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(bottom: 13.0),
                                      enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle: const TextStyle(
                                          fontSize: 8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Text(
                                      "VNĐ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8),
                                    ),
                                  )
                                ],
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
                onPressed: ()async {
                  if (budgetNameController.text.isEmpty ||
                      _budgetMoneyController.numberValue.toString().isEmpty ||
                      expense == null ||
                      budgetIcon!.isEmpty ||
                      budgetEndDate == null) {
                    Fluttertoast.showToast(
                        msg: "Vui lòng điền đầy đủ thông tin",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 13.0);
                  } else {
                    await BudgetController().createBudget(
                        budgetNameController.text,
                        _budgetMoneyController.numberValue,
                        budgetIcon,
                        df.format(budgetEndDate),
                        expense.expenseId).then((value) {
                          if(value==false){
                            Fluttertoast.showToast(msg: "Ngân sách cho loại giao dịch đã tồn tại !");
                          }else{
                            Get.back(result: "Create");
                          }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)),
                child: const Text("Tạo mới ngân sách"),
              ),
            ],
          ),
        ));
  }

  _showCalendarDialog() {
    Size size = MediaQuery.of(context).size;
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
