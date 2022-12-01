import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/history_controller.dart';
import 'package:graduation_thesis_project/utils/enums/expense_type.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_event.dart';
import 'package:graduation_thesis_project/views/commons/pages/select_icon.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/event_screen/event_list.dart';
import 'package:graduation_thesis_project/views/transaction_screen/expense_screen/expense_list.dart';
import 'package:graduation_thesis_project/views/transaction_screen/wallet_screen/wallet_list.dart';
import 'package:intl/intl.dart';

import '../../../models/expense.dart';
import '../../../models/wallet.dart';
import '../../../remote/controllers/entites/expense_controller.dart';
import '../../../remote/controllers/entites/wallet_controller.dart';

// ignore: must_be_immutable
class TransactionCreate extends StatefulWidget {
  final transactionController = Get.put(HistoryController());
  final walletController = Get.put(WalletController());
  TransactionCreate({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionCreate> createState() => _TransactionCreateState();
}

class _TransactionCreateState extends State<TransactionCreate> {
  final controllerTransactionName = TextEditingController();
  final controllerTransactionNote = TextEditingController();
  final controllerTransactionValue = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      initialValue: 0,
      precision: 0);
  String? valueChoose;
  DateFormat df = DateFormat("yyyy-MM-dd");
  var event, expense, wallet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: Text(
            "Thêm giao dịch",
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
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.7,
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
                      // Container(
                      //   padding: const EdgeInsets.all(3),
                      //   margin: const EdgeInsets.only(top: 20),
                      //   width: size.width * 0.8,
                      //   height: size.width * 0.13,
                      //   child: TextField(
                      //     controller: controllerTransactionName,
                      //     textAlign: TextAlign.center,
                      //     autofocus: false,
                      //     decoration: InputDecoration(
                      //       contentPadding: const EdgeInsets.only(
                      //           left: 15, top: 5, bottom: 15),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(30),
                      //           borderSide: BorderSide(
                      //               color: Colors.grey.shade300,
                      //               width: size.width * 0.005)),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(30),
                      //           borderSide: BorderSide(
                      //               color: Colors.grey.shade600,
                      //               width: size.width * 0.005)),
                      //       // filled: true,
                      //       fillColor: Colors.white,
                      //       hintText: "Nhập tên giao dịch",
                      //       hintStyle: TextStyle(
                      //           fontSize: size.width * 0.04,
                      //           color: Colors.grey.shade600,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      CircleIconContainer(
                          urlImage: (expense == null)
                              ? "images/QuestionIcon.svg"
                              : expense.expenseIcon,
                          iconSize: size.width * 0.1,
                          backgroundColor: Colors.yellow,
                          padding: size.width * 0.06),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                'Số tiền giao dịch: ',
                                style: TextStyle(
                                    fontSize: size.width * 0.035,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              alignment: Alignment.center,
                              width: size.width * 0.53,
                              height: size.width * 0.1,
                              // decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(100),
                              //     boxShadow: const [
                              //       BoxShadow(color: Colors.grey, blurRadius: 2)
                              //     ]),
                              child: TextField(
                                controller: controllerTransactionValue,
                                keyboardType: TextInputType.number,
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
                                  hintText: "Nhập tên giao dịch",
                                  hintStyle: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w400),
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
                                    ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            InkWell(
                              onTap: () {
                                Get.to(ExpenseList(isLoadByBudget: false))!
                                    .then((value) {
                                  setState(() {
                                    expense = value;
                                  });
                                });
                              },
                              child: Container(
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
                                child: (expense==null)?Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.3,
                                      child: TextContainer(
                                        text:  "Chọn loại thu chi",
                                        textColor:Colors.grey,
                                        textSize: size.width * 0.035,
                                        textFontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.15,
                                      child: Icon(
                                              Icons.keyboard_arrow_down,
                                            ),
                                    ),
                                  ],
                                ):Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.3,
                                  child: TextContainer(
                                    text: expense.expenseName,
                                    textColor: (expense == null)
                                        ? Colors.grey
                                        : Colors.black,
                                    textSize: size.width * 0.035,
                                    textFontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                              'Ví :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(WalletList(isTransaction:true))!
                                    .then((value) {
                                  setState(() {
                                    wallet = value;
                                  });
                                });
                              },
                              child: Container(
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
                                child: (wallet==null)?Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.3,
                                      child: TextContainer(
                                        text:  "Chọn ví",
                                        textColor:Colors.grey,
                                        textSize: size.width * 0.035,
                                        textFontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.15,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                    ),
                                  ],
                                ):Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.3,
                                  child: TextContainer(
                                    text: wallet.walletName,
                                    textColor: Colors.black,
                                    textSize: size.width * 0.035,
                                    textFontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sự kiện : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(EventList())!.then((value) {
                                  setState(() {
                                    event = value;
                                  });
                                });
                              },
                              child: Container(
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
                                child: (event==null)?Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: TextContainer(
                                          text: "Chọn sự kiện",
                                          textColor: Colors.grey,
                                          textSize: size.width * 0.04,
                                          textFontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none),
                                    ),
                                    Container(
                                      width: size.width * 0.15,
                                      child: Icon(
                                              Icons.keyboard_arrow_down,
                                            ),
                                    ),
                                  ],
                                ):Container(
                                  width: size.width * 0.3,
                                  alignment: Alignment.center,
                                  child: TextContainer(
                                      text: event.eventName,
                                      textColor: Colors.black,
                                      textSize: size.width * 0.04,
                                      textFontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height:size.width*0.11,
                              child: Text(
                                'Ghi chú : ',
                                style: TextStyle(
                                    fontSize: size.width * 0.035,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: size.width * 0.51,
                              height: size.width * 0.2,
                              child: TextField(
                                controller: controllerTransactionNote,
                                textAlign: TextAlign.center,
                                maxLines:null,
                                minLines: 1,
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, top: 5, bottom: 15),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: size.width * 0.005)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: size.width * 0.005)),
                                  // filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Nhập ghi chú",
                                  hintStyle: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {

                    if(expense==null||wallet==null||controllerTransactionValue.numberValue==0){
                      Fluttertoast.showToast(msg: "Vui lòng nhập đầy đủ thông tin !");
                    }else{

                      await widget.transactionController.createTransaction("DISBURSE", df.format(DateTime.now()), "WITHDRAW", controllerTransactionValue.numberValue,
                          controllerTransactionNote.text, expense.expenseId, wallet.walletId, (event==null)?null:event.eventId).then((value) {
                            Get.back(result: "Create");
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: const Size(250, 30)),
                  child: Text("Tạo mới giao dịch"),
                ),
              ],
            ),
          ),
        ));
  }
}
