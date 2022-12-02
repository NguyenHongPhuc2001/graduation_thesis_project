import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/budget.dart';

import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../../../models/expense.dart';
import '../../../../remote/controllers/entites/budget_controller.dart';
import '../../../commons/widgets/custom_round_rectangle_button.dart';
import '../../../commons/widgets/text_container.dart';
import '../../../transaction_screen/expense_screen/expense_list.dart';

class BudgetUpdate extends StatefulWidget {

  final Budget budget;

  const BudgetUpdate({Key? key, required this.budget,}) : super(key: key);

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

  final _budgetNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadBudgetData();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            "Điều chỉnh ngân sách",
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
                      margin: const EdgeInsets.only(top: 20),
                      width: size.width * 0.8,
                      height: size.width * 0.1,
                      child: TextField(
                        controller: _budgetNameController,
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
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () async {
                        widget.budget.budgetIcon = await Navigator.of(context).push(
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
                        child: SvgPicture.asset(widget.budget.budgetIcon),
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
                                      widget.budget.budgetMothYear,
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
                              child: InkWell(
                                onTap: () async {
                                  widget.budget.expense = await Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ExpenseList(isLoadByBudget: true)));
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    child:  Text(
                                      Expense.fromJson(widget.budget.expense).expenseName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.04,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
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
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextField(
                                    textAlign: TextAlign.center,
                                    controller: _budgetMoneyController,
                                    onChanged: (value) => widget.budget.budgetValue = double.parse(value.replaceAll(",", "")),
                                    autofocus: false,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                        color: Colors.blue
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(bottom: 13.0),
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){

                  if(widget.budget.budgetName.isEmpty || _budgetMoneyController.text.toString().isEmpty
                      || widget.budget.expense == null || widget.budget.budgetIcon.isEmpty || dateTime == null) {

                    Fluttertoast.showToast(
                        msg: "Vui lòng điền đầy đủ thông tin",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 13.0
                    );

                  }else{
                    BudgetController().updateBudget(widget.budget.budgetId, widget.budget.budgetName, widget.budget.budgetValue,
                        widget.budget.budgetIcon, dateTime == null ? widget.budget.budgetMothYear : df.format(dateTime),
                        widget.budget.expense.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>" ? Expense.fromJson(widget.budget.expense) : widget.budget.expense);
                    Get.back();
                  }

                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)
                ),
                child: const Text(
                    "Cập nhật ngân sách"
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                    _showDeleteDialog(widget.budget);
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30),
                    primary: Colors.red
                ),
                child: const Text(
                    "Xóa ngân sách"
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

  _loadBudgetData() {
    _budgetNameController.text = widget.budget.budgetName;
    _budgetMoneyController = MoneyMaskedTextController(
        thousandSeparator: ',',
        initialValue: widget.budget.budgetValue,
        precision: 0,
        decimalSeparator: ''
    );
  }

  _showDeleteDialog(Budget budget) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.02)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.06),
                  child: Text(
                    "Xin đợi chút !",
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  const TextSpan(text: "Bạn có chắc muốn xóa ngân sách "),
                  TextSpan(
                      text: budget.budgetName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  const TextSpan(text: " chứ ?"),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              CustomRoundRectangleButton(
                onTap: () {
                  Navigator.pop(context);
                },
                buttonWith: size.width * 0.3,
                padding: size.width * 0.02,
                borderRadius: size.width * 0.01,
                text: TextContainer(
                  text: "HỦY",
                  textColor: Colors.black,
                  textSize: size.width * 0.03,
                  textFontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
                backgroundColor: Colors.white,
                border: Border.all(
                  width: size.width * 0.005,
                  color: Colors.grey,
                ),
              ),
              CustomRoundRectangleButton(
                onTap: () {
                  setState(() async{
                    await BudgetController().deleteBudget(widget.budget.budgetId, )
                    .then((value) {
                      Get.back();
                    });
                  });
                },
                buttonWith: size.width * 0.3,
                padding: size.width * 0.02,
                borderRadius: size.width * 0.01,
                text: TextContainer(
                  text: "XÁC NHẬN",
                  textColor: Colors.white,
                  textSize: size.width * 0.03,
                  textFontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
                backgroundColor: Color(0xff2B4BF2),
              ),
            ],
          );
        });
  }

}

