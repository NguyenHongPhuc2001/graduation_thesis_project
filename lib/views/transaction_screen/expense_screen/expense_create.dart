import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/utils/enums/expense_type.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';

import '../../../remote/controllers/entites/expense_controller.dart';

// ignore: must_be_immutable
class ExpenseCreate extends StatefulWidget {
  final expenseController = Get.put(ExpenseController());
  bool isLoadByBudget;

  ExpenseCreate({Key? key, required this.isLoadByBudget}) : super(key: key);

  @override
  State<ExpenseCreate> createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final controllerExpenseName = TextEditingController();
  String? valueChoose;
  String? _expenseIcon = "images/palm_tree.svg";
  var event;


  @override
  Widget build(BuildContext context) {

    final List expenseTypes =
        (widget.isLoadByBudget==true) ? ['Chi tiêu'] : ['Thu nhập', 'Chi tiêu'];

    Size size = MediaQuery.of(context).size;



    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            (widget.isLoadByBudget==true) ? "Thêm mới chi tiêu" : "Thêm mới giao dịch",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
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
                height: size.height * 0.35,
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
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(top: 20),
                      width: size.width * 0.8,
                      height: size.width * 0.1,
                      child: TextField(
                        controller: controllerExpenseName,
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
                          fillColor: Colors.white,
                          hintText: "Nhập tên chi tiêu",
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
                        await Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => const SelectIcons()))
                            .then((value) {
                          setState(() {
                            _expenseIcon = value;
                          });
                        });
                      },
                      child: CircleIconContainer(
                          urlImage: (_expenseIcon != null)
                              ? _expenseIcon!
                              : "images/QuestionIcon.svg",
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.yellow,
                          padding: size.width * 0.06),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Loại thu chi : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                                  BoxShadow(color: Colors.grey, blurRadius: 2)
                                ]),
                            child: DropdownButton(
                              hint: const Text("Chọn loại thu chi"),
                              underline: const SizedBox(),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              iconSize: 25,
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
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
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: ()  {
                  widget.expenseController.createExpense(
                      controllerExpenseName.text,
                      valueChoose == 'Chi tiêu'
                          ? ExpenseType.DISBURSE.name
                          : ExpenseType.INCOME.name,
                      _expenseIcon!).then((value) {
                    Get.back(result: "Create");
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)),
                child: Text(widget.isLoadByBudget
                    ? "Tạo mới chi tiêu"
                    : "Tạo mới thu chi"),
              ),
            ],
          ),
        ));
  }
}
