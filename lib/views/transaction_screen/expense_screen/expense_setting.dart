import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/utils/enums/expense_type.dart';

import '../../../remote/controllers/entites/expense_controller.dart';
import '../../commons/pages/select_icon.dart';


// ignore: must_be_immutable
class ExpenseSetting extends StatefulWidget {

  final expenseController = Get.put(ExpenseController());

  int? expenseId;
  String? expenseName;
  String? expenseType;
  String? expenseIcon;

  ExpenseSetting({Key? key, required this.expenseId, required this.expenseName, required this.expenseType, required this.expenseIcon}) : super(key: key);

  @override
  State<ExpenseSetting> createState() => _ExpenseSettingState();
}

class _ExpenseSettingState extends State<ExpenseSetting> {

  final List expenseTypes = ['Thu nhập', 'Chi tiêu'];

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    final controllerExpenseName = TextEditingController();
    final controllerExpenseType = TextEditingController();

    controllerExpenseName.text = widget.expenseName!;
    controllerExpenseType.text = widget.expenseType! == ExpenseType.DISBURSE.name ? 'Chi tiêu' : 'Thu nhập';

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Điều chỉnh thu chi",
            style: TextStyle(
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
                height: size.height * 0.5,
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
                        onChanged: (value) => widget.expenseName = value,
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
                          hintText: "Nhập tên thu chi",
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
                        widget.expenseIcon = await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SelectIcons())
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        padding: const EdgeInsets.all(18),
                        child: SvgPicture.asset(widget.expenseIcon!),
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
                            value: widget.expenseType == ExpenseType.INCOME.name ? 'Thu nhập' : 'Chi tiêu',
                            onChanged: (newValue) {
                              setState(() {
                                widget.expenseType = newValue.toString();
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
                    const SizedBox(height: 15,),
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 0.1,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        widget.expenseController.deleteExpense(widget.expenseId);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size(55, 30),
                          primary: const Color(0xFFF56464)
                      ),
                      child: const Icon(
                          Icons.delete_sharp,
                          color: Colors.white,
                          size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  widget.expenseController.updateExpense(widget.expenseId, widget.expenseName,
                      widget.expenseType == 'Chi tiêu' ? ExpenseType.DISBURSE.name : ExpenseType.INCOME.name,
                      widget.expenseIcon);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)
                ),
                child: const Text(
                    "Cập nhật thu chi"
                ),
              ),
            ],
          ),
        )
    );
  }

}
