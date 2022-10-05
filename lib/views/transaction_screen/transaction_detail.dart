import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_thesis_project/dao/budget_dao.dart';
import 'package:graduation_thesis_project/dao/transaction_dao.dart';
import 'package:graduation_thesis_project/model/Budget.dart';
import 'package:graduation_thesis_project/model/RAP.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/commons/widgets/appbar_container_2.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/single_row_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_add.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_screen.dart';
import 'package:graduation_thesis_project/views/transaction_screen/transaction_update.dart';
import 'package:intl/intl.dart';

import '../plan_screen/pages_in_planScreen/budget_screen/budget_detail.dart';

class TransactionDetail extends StatefulWidget {
  final Transactions transaction;
  final List<Transactions> listTransaction;
  const TransactionDetail({
    Key? key,
    required this.transaction, required this.listTransaction,
  }) : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  final _random = Random();
  final df = DateFormat("dd-MM-yyyy");
  final nf = NumberFormat("###,###");
  final List<Budget> listBudget = BudgetDAO().getAll();
  final List<Transactions> listTransaction = TransactionDAO().getAll();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var rap = widget.transaction.rap;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.width * 0.15),
          child: AppBarContainer2(
              text: widget.transaction.rap.rapName,
              backIcon: CupertinoIcons.xmark,
              prefixIcon1: Icons.edit,
              prefixIcon2: Icons.delete,
              onBackTap: () {
                Navigator.pop(context);
              },
              onPrefixIcon1Tap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateTransaction(transactions: widget.transaction),
                  ),
                ).then((value) => setState(() {
                      if (value == "Update")
                        Fluttertoast.showToast(
                            msg: "Cập nhật giao dịch thành công !");
                    }));
              },
              onPrefixIcon2Tap: () {
                _showDeleteDialog(widget.transaction);
              }),
        ),
        body: Container(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.grey,
                      blurRadius: size.width * 0.01,
                      spreadRadius: size.width * 0.001,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SingleRowContainer(
                      paddingTop: size.width * 0.04,
                      paddingBottom: size.width * 0,
                      children: [
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.3,
                                child: CircleIconContainer(
                                  urlImage: widget.transaction.rap.rapUrlImage,
                                  iconSize: size.width * 0.07,
                                  backgroundColor: Colors.green,
                                  padding: size.width * 0.025,
                                ),
                              ),
                              Container(
                                width: size.width * 0.67,
                                child: Text(
                                  widget.transaction.rap.rapName,
                                  style: TextStyle(
                                    fontSize: size.width * 0.07,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SingleRowContainer(
                      paddingTop: size.width * 0.06,
                      paddingBottom: size.width * 0,
                      children: [
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.3,
                                child: CircleIconContainer(
                                  urlImage: 'images/MoneyIcon_1.svg',
                                  iconSize: size.width * 0.09,
                                  backgroundColor: Colors.transparent,
                                  padding: 0,
                                ),
                              ),
                              Container(
                                width: size.width * 0.67,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: size.width * 0.01),
                                      child: TextContainer(
                                        text: "Chi phí",
                                        textColor: Colors.black,
                                        textSize: size.width * 0.04,
                                        textFontWeight: FontWeight.w300,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    MoneyTextContainer(
                                      value:
                                          widget.transaction.transactionValue,
                                      textSize: size.width * 0.05,
                                      textFontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SingleRowContainer(
                      paddingTop: size.width * 0.06,
                      paddingBottom: size.width * 0,
                      children: [
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.3,
                                child: CircleIconContainer(
                                  urlImage: 'images/CalendarIcon_2.svg',
                                  iconSize: size.width * 0.09,
                                  backgroundColor: Colors.transparent,
                                  padding: 0,
                                ),
                              ),
                              Container(
                                width: size.width * 0.67,
                                child: Text(
                                  df.format(widget.transaction.createDate),
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SingleRowContainer(
                      paddingTop: size.width * 0.06,
                      paddingBottom: size.width * 0,
                      children: [
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.3,
                                child: CircleIconContainer(
                                  urlImage: 'images/WalletIcon_1.svg',
                                  iconSize: size.width * 0.08,
                                  backgroundColor: Colors.transparent,
                                  padding: 0,
                                ),
                              ),
                              Container(
                                width: size.width * 0.67,
                                child: Text(
                                  widget.transaction.wallet.walletName,
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: (widget.transaction.transactionNote != ""),
                      child: SingleRowContainer(
                        paddingTop: size.width * 0.06,
                        paddingBottom: (widget.transaction.event != null)
                            ? 0
                            : size.width * 0.03,
                        children: [
                          Container(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: size.width * 0.3,
                                  child: CircleIconContainer(
                                    urlImage: 'images/NoteIcon.svg',
                                    iconSize: size.width * 0.09,
                                    backgroundColor: Colors.transparent,
                                    padding: 0,
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.67,
                                  child: Text(
                                    widget.transaction.transactionNote,
                                    style: TextStyle(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (widget.transaction.event != null),
                      child: SingleRowContainer(
                        paddingTop: size.width * 0.06,
                        paddingBottom: size.width * 0.03,
                        children: [
                          Container(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: size.width * 0.3,
                                  child: CircleIconContainer(
                                    urlImage: 'images/CalendarIcon_4.svg',
                                    iconSize: size.width * 0.09,
                                    backgroundColor: Colors.transparent,
                                    padding: 0,
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.67,
                                  child: Text(
                                    (widget.transaction.event != null)
                                        ? widget.transaction.event!.eventName
                                        : "",
                                    style: TextStyle(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.width * 0.55,
                padding: EdgeInsets.all(size.width * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextContainer(
                            text: "Ngân sách",
                            textColor: Colors.black,
                            textSize: size.width * 0.08,
                            textFontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: size.width * 0.04),
                            width: size.width,
                            child: TextContainer(
                              text: "Giao dịch này chưa nằm trong ngân sách, "
                                  "hãy tạo một ngân sách để quản lý chi tiêu tốt hơn.",
                              textColor: Colors.black,
                              textSize: size.width * 0.045,
                              textFontWeight: FontWeight.w300,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomRoundRectangleButton(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBudget(
                              listBudget: listBudget,
                              rapFromTransaction: rap,
                            ),
                          ),
                        );
                      },
                      buttonWith: size.width * 0.75,
                      padding: size.width * 0.03,
                      borderRadius: size.width * 0.02,
                      text: TextContainer(
                        text: "THÊM NGÂN SÁCH CHO THÁNG NÀY",
                        textColor: Colors.blue,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                      backgroundColor: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.grey,
                          blurRadius: size.width * 0.01,
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
    );
  }

  _showDeleteDialog(Transactions transactions) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
                  TextSpan(text: "Bạn có chắc muốn xóa giao dịch "),
                  TextSpan(
                      text: "${transactions.rap.rapName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(text: " chứ ?"),
                ],
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
                      top: size.width * 0.009, bottom: size.width * 0.009),
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    border: Border.all(
                      width: size.width * 0.002,
                      color: Colors.black,
                    ),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Hủy",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.listTransaction.removeWhere(
                        (element) => element.id == widget.transaction.id);
                    Navigator.pop(
                      context,
                    );
                    Navigator.pop(
                        context,
                        "Delete");
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: size.width * 0.011, bottom: size.width * 0.011),
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(size.width * 0.016),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    "Xác nhận",
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
