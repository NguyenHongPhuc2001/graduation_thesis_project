import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/account.dart';
import 'package:graduation_thesis_project/models/budget.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/ui/expense_list.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../controllers/entites/budget_controller.dart';

class BudgetUpdate extends StatefulWidget {

  final Budget budget;

  const BudgetUpdate({
    Key? key,
    required this.budget,
  }) : super(key: key);

  @override
  State<BudgetUpdate> createState() => _BudgetUpdateState();
}

class _BudgetUpdateState extends State<BudgetUpdate> {

  MoneyMaskedTextController _budgetMoneyController = MoneyMaskedTextController();
  final DateFormat df = DateFormat("yyyy-MM");
  // ignore: prefer_typing_uninitialized_variables
  var dateTime, linkIcon;
  String budgetValue = "";

  final pageController = PageController();

  bool _onTextClick = false;

  final _budgetNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _loadBudgetData();

    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.xmark,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          "Chỉnh sửa ngân sách",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: size.width * 0.07,
            icon: Icon(
              Icons.save,
              color: Colors.black,
              size: size.width * 0.08,
            ),
            onPressed: () {
              setState(() async {
                Account account = Account(accountUsername: "ChuTT");
                await BudgetController().updateExpense(widget.budget.budgetId, widget.budget.budgetName, widget.budget.budgetValue,
                    widget.budget.budgetIcon, dateTime == null ? widget.budget.budgetMothYear : df.format(dateTime),
                    widget.budget.expense.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>" ? Expense.fromJson(widget.budget.expense) : widget.budget.expense, account);
                Get.back();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.05),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              height: size.width * 0.2,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: size.width * 0.001,
                  color: Colors.black,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(size.width * 0.025),
                      child: SvgPicture.asset("images/logo_money.svg",
                          width: size.width * 0.1),
                    ),
                    VerticalDivider(
                      thickness: size.width * 0.001,
                      color: Colors.black,
                      width: size.width * 0.1,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _budgetNameController,
                        onChanged: (value) => widget.budget.budgetName = value,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên ngân sách',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.05),
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
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                height: size.width * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: Image.asset("icons/icons_1/calendar_icon_1.png",
                            width: size.width * 0.1),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: dateTime == null
                            ? Text(
                          widget.budget.budgetMothYear,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        )
                            : Text(
                          df.format(dateTime),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.07,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.05),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              height: size.width * 0.2,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: size.width * 0.001,
                  color: Colors.black,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      child: Image.asset(
                        "icons/icons_1/money_icon_1.png",
                        width: size.width * 0.13,
                      ),
                    ),
                    VerticalDivider(
                      thickness: size.width * 0.001,
                      color: Colors.black,
                      width: size.width * 0.1,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.02),
                            child: _textInTargetDetail(
                              text: "Số tiền ngân sách",
                              textColor: Colors.black,
                              textSize: size.width * 0.03,
                              textFontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible: _onTextClick,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(right: size.width * 0.03),
                                  child: _textInTargetDetail(
                                    text: "đ",
                                    textColor: const Color(0xff8AC926),
                                    textSize: size.width * 0.07,
                                    textFontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      _onTextClick = true;
                                    });
                                  },
                                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                  controller: _budgetMoneyController,
                                  onChanged: (value) => widget.budget.budgetValue = double.parse(value.replaceAll(",", "")),
                                  decoration: InputDecoration(
                                    hintText: "Nhập số tiền ngân sách",
                                    hintStyle: TextStyle(
                                      fontSize: size.width * 0.05,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff8AC926),
                                    fontSize: size.width * 0.07,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.05),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              height: size.width * 0.2,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: size.width * 0.001,
                  color: Colors.black,
                ),
              ),
              child: IntrinsicHeight(
                child: InkWell(
                  onTap: () async {
                    widget.budget.budgetIcon = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SelectIcons())
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.03),
                        child: SvgPicture.asset(
                          "images/face_smile.svg",
                          width: size.width * 0.09,
                        ),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.07,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.05),
            child: InkWell(
              onTap: () async {
                widget.budget.expense = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ExpenseList(isLoadByBudget: true,))
                );
              },
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                height: size.width * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 0.001,
                    color: Colors.black,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: SvgPicture.asset("images/logo_money.svg",
                            width: size.width * 0.1),
                      ),
                      VerticalDivider(
                        thickness: size.width * 0.001,
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      const Expanded(
                          child: Text(
                              "Chọn loại chi tiêu"
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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

  _loadBudgetData() {
    _budgetNameController.text = widget.budget.budgetName;
    _budgetMoneyController = MoneyMaskedTextController(
        thousandSeparator: ',',
        initialValue: widget.budget.budgetValue,
        precision: 0,
        decimalSeparator: ''
    );
  }

}

// ignore: camel_case_types
class _textInTargetDetail extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textFontWeight;
  final TextDecoration decoration;

  const _textInTargetDetail({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.textFontWeight,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: textFontWeight,
        decoration: decoration,
      ),
    );
  }
}
