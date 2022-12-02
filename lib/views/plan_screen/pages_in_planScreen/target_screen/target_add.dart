import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:intl/intl.dart';

import '../../../../models/goal.dart';
import '../../../commons/pages/select_icon.dart';
import '../../../../remote/controllers/entites/goal_controller.dart';
import '../../../commons/widgets/text_container.dart';

class AddTarget extends StatefulWidget {
  const AddTarget({Key? key}) : super(key: key);

  @override
  State<AddTarget> createState() => _AddTargetState();
}

class _AddTargetState extends State<AddTarget> {
  final _targetNameController = TextEditingController();
  final _targetMoneyController = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      initialValue: 0,
      precision: 0);
  final DateFormat df = DateFormat("yyyy-MM-dd");
  var goalEndDate, goalIcon, colorSelectedIndex = 0, goalColor;

  List<Goal> listGoal = [];

  List<Color> items = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.green,
    Colors.purple,
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.brown.shade700,
    Colors.greenAccent,
    Colors.purpleAccent,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goalEndDate = DateTime.now();
    goalColor = items[0].value;
    goalIcon = "images/QuestionIcon.svg";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            "Thêm mới mục tiêu",
            style: TextStyle(color: Colors.black, fontSize: size.width * 0.05),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () async {
              Get.back(result:  "Cancle");
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
                height: size.height * 0.5,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => const SelectIcons()))
                              .then((value) {
                            setState(() {
                              goalIcon = value;
                              print(value);
                            });
                          });
                        },
                        child: CircleIconContainer(
                            urlImage: goalIcon,
                            iconSize: size.width * 0.08,
                            backgroundColor: Color(goalColor),
                            padding: size.width * 0.07),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: size.width * 0.8,
                      height: size.width * 0.1,
                      child: TextField(
                        controller: _targetNameController,
                        textAlign: TextAlign.center,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 15, top: 5, bottom: 15),
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
                          hintText: "Nhập tên mục tiêu",
                          hintStyle: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                'Ngày kết thúc',
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
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
                                      goalEndDate = dateValue as DateTime;
                                      final int year1,
                                          year2,
                                          month1,
                                          month2,
                                          day1,
                                          day2;
                                      DateTime t = goalEndDate;
                                      DateTime t2 = DateTime.now();
                                      year1 = t.year;
                                      month1 = t.month;
                                      day1 = t.day;
                                      year2 = t2.year;
                                      month2 = t2.month;
                                      day2 = t2.day;

                                      if (year1 < year2) {
                                        setState(() {
                                          goalEndDate = null;
                                        });
                                        _showCalendarDialog();
                                      } else if (year1 == year2 &&
                                          month1 < month2) {
                                        setState(() {
                                          goalEndDate = null;
                                        });
                                        _showCalendarDialog();
                                      } else if (year1 == year2 &&
                                          month1 == month2 &&
                                          day1 < day2) {
                                        setState(() {
                                          goalEndDate = null;
                                        });
                                        _showCalendarDialog();
                                      }
                                    });
                                  },
                                  child: TextContainer(
                                    text: df.format(goalEndDate),
                                    textColor: Colors.black,
                                    textSize: size.width * 0.035,
                                    textFontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
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
                              child: Text(
                                'Số tiền mục tiêu',
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              width: size.width * 0.4,
                              height: size.width * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ]),
                              child: TextField(
                                controller: _targetMoneyController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Nhập số tiền',
                                    hintStyle: TextStyle(
                                      fontSize: size.width * 0.034,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.006,
                                          horizontal: size.width * 0.01),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: size.width * 0.02,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              size.width * 0.1),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          "VNĐ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
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
                              child: Text(
                                'Màu sắc',
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              height: size.width * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.04),
                                    child: Text("Chọn màu"),
                                  ),
                                  buttonPadding: EdgeInsets.only(right: size.width*0.014),
                                  value: goalColor,
                                  dropdownMaxHeight: size.width * 0.5,
                                  items: items
                                      .map(
                                        (item) => DropdownMenuItem<int>(
                                          value: item.value,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.01),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.15),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Color(item.value),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.width * 0.1)),
                                              child: Text(""),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      goalColor = value;
                                    });
                                  },
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
                onPressed: () async {
                  await GoalController().createGoal(_targetNameController.text,
                      _targetMoneyController.numberValue, df.format(goalEndDate), goalColor.toString(), goalIcon);

                  Navigator.pop(context, "Create");
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)),
                child: const Text("Tạo mới mục tiêu"),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.02)),
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
