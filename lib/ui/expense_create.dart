import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/utils/enums/expense_type.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';

import '../controllers/entites/expense_controller.dart';
import '../models/account.dart';

// ignore: must_be_immutable
class ExpenseCreate extends StatefulWidget {

  final expenseController = Get.put(ExpenseController());
  bool isLoadByBudget;

  ExpenseCreate({Key? key, required this.isLoadByBudget}) : super(key: key);

  @override
  State<ExpenseCreate> createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {

  String? valueChoose;
  String? _expenseName = "";
  Account? _account;
  String? _expenseIcon = "images/palm_tree.svg";

  @override
  Widget build(BuildContext context) {

    final List expenseTypes = widget.isLoadByBudget ? ['Chi tiêu'] : ['Thu nhập', 'Chi tiêu'];

    Size size = MediaQuery.of(context).size;

    final controllerExpenseName = TextEditingController();

    controllerExpenseName.text = _expenseName!;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            widget.isLoadByBudget ? "Thêm mới chi tiêu" : "Thêm mới thu chi",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
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
                height: size.height * 0.4,
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
                        textAlign: TextAlign.center,
                        controller: controllerExpenseName,
                        onChanged: (value) => _expenseName = value,
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
                          hintText: widget.isLoadByBudget ? "Nhập tên chi tiêu" : "Nhập tên thu chi",
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
                        _expenseIcon = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SelectIcons())
                        ).then((value) => null);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        padding: const EdgeInsets.all(18),
                        child: SvgPicture.asset(_expenseIcon!),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                            'Loại thu chi : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          width: size.width * 0.5,
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
                          child: DropdownButton(
                            hint: const Text(
                              "Chọn loại thu chi"
                            ),
                            underline: const SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            iconSize: 25,
                            style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w300
                            ),
                            value: valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoose = newValue.toString();
                              });
                            },
                            items: expenseTypes.map((newValue) {
                              return DropdownMenuItem(
                                value: newValue,
                                child: Text(newValue),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  _account = Account(accountUsername: 'ChuTT');
                  widget.expenseController.createExpense(_expenseName,
                      valueChoose == 'Chi tiêu' ? ExpenseType.DISBURSE.name : ExpenseType.INCOME.name,
                      _expenseIcon,
                      _account);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)
                ),
                child: Text(
                    widget.isLoadByBudget ? "Tạo mới chi tiêu" : "Tạo mới thu chi"
                ),
              ),
            ],
          ),
        )
    );
  }
}
