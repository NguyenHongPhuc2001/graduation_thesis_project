import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/dao/transaction_dao.dart';
import 'package:intl/intl.dart';

import '../../model/Transaction.dart';
import '../commons/widgets/circle_icon_container.dart';
import '../commons/widgets/custom_round_rectangle_button.dart';
import '../commons/widgets/money_text_container.dart';
import '../commons/widgets/single_row_container.dart';
import '../commons/widgets/text_container.dart';
import '../transaction_screen/transaction_detail.dart';

class OverviewManageTransaction extends StatefulWidget {
  final List<Transactions> listTransaction;
  final int month;

  const OverviewManageTransaction({
    Key? key,
    required this.listTransaction,
    required this.month,
  }) : super(key: key);

  @override
  State<OverviewManageTransaction> createState() =>
      _OverviewManageTransactionState();
}

class _OverviewManageTransactionState extends State<OverviewManageTransaction> {
  final List<Tab> listTabs = [];
  final List<Transactions> listMonthOfTran = [];
  final List<Transactions> listTranByDate = [];
  final df = DateFormat("EEEE");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    listMonthOfTran.clear();
    listTranByDate.clear();


    widget.listTransaction.forEach((element) {
      if (element.createDate.month == widget.month)
        listMonthOfTran.add(element);
    });

    listMonthOfTran.forEach((element) {
      listTranByDate.add(element);
    });


    for(int i=0;i<listTranByDate.length;i++){
      int check=0;
      Transactions temp = listTranByDate[i];
      for(int j = 0;j<listMonthOfTran.length;j++){
        if(listMonthOfTran[j].createDate.day == temp.createDate.day)
         check++;
      }
      if(check!=1) {
        listTranByDate.removeAt(i);
      }
    }


    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(size.width * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.grey,
                  blurRadius: size.width * 0.01,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SingleRowContainer(
                  paddingTop: 0,
                  paddingBottom: 0,
                  children: [
                    TextContainer(
                      text: "Tổng thu",
                      textColor: Colors.grey,
                      textSize: size.width * 0.05,
                      textFontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                    MoneyTextContainer(
                      value: 222222222,
                      textSize: size.width * 0.05,
                      textFontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
                SingleRowContainer(
                  paddingTop: size.width * 0.04,
                  paddingBottom: 0,
                  children: [
                    TextContainer(
                      text: "Tổng chi",
                      textColor: Colors.grey,
                      textSize: size.width * 0.05,
                      textFontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                    MoneyTextContainer(
                      value: 2111122,
                      textSize: size.width * 0.05,
                      textFontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ],
                ),
                Divider(
                  thickness: size.width * 0.001,
                  color: Colors.grey.shade600,
                  indent: size.width * 0.6,
                ),
                MoneyTextContainer(
                  value: 222222,
                  textSize: size.width * 0.05,
                  textFontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundRectangleButton(
                      onTap: () {},
                      margin: EdgeInsets.only(top: size.width * 0.04),
                      buttonWith: size.width * 0.7,
                      padding: size.width * 0.03,
                      borderRadius: size.width * 0.05,
                      text: TextContainer(
                        text: "XEM BÁO CÁO THÁNG NÀY",
                        textColor: Colors.white,
                        textSize: size.width * 0.04,
                        textFontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      backgroundColor: Colors.lightBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: listTranByDate.length, (context, index) {
            List<Transactions> listTranOfMonth = [];

            widget.listTransaction.forEach((item) {
              if(item.createDate.day == listTranByDate.elementAt(index).createDate.day)
                listTranOfMonth.add(item);

            });

            double singleTotalSpending = 0;

            listTranOfMonth.forEach((item) {
              singleTotalSpending += item.transactionValue;
            });

            return Padding(
              padding: EdgeInsets.only(top: size.width * 0.1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: size.width * 0.01,
                      color: Colors.grey,
                    ),
                  ],
                ),
                width: size.width,
                child: Column(
                  children: [
                    SingleRowContainer(
                      boxDecoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: size.width * 0.001,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      paddingTop: size.width * 0.02,
                      paddingBottom: size.width * 0.02,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          width: size.width * 0.6,
                          child: Row(
                            children: [
                              TextContainer(
                                text: listTranByDate
                                    .elementAt(index)
                                    .createDate
                                    .day
                                    .toString(),
                                textColor: Colors.black,
                                textSize: size.width * 0.07,
                                textFontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextContainer(
                                    text:
                                        "${getNameOfDays(listTranByDate.elementAt(index).createDate.weekday)}",
                                    textColor: Colors.black,
                                    textSize: size.width * 0.03,
                                    textFontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none,
                                  ),
                                  TextContainer(
                                    text:
                                        "tháng ${listTranByDate.elementAt(index).createDate.month} năm ${listTranByDate.elementAt(index).createDate.year}",
                                    textColor: Colors.black,
                                    textSize: size.width * 0.03,
                                    textFontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: size.width * 0.02),
                          alignment: Alignment.centerRight,
                          width: size.width * 0.3,
                          child: MoneyTextContainer(
                            value: singleTotalSpending,
                            textSize: size.width * 0.05,
                            textFontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width,
                      height: size.width * 0.183 * listTranOfMonth.length,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listTranOfMonth.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: size.width * 0.04),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransactionDetail(
                                          transaction:
                                          listTranOfMonth.elementAt(index),
                                          listTransaction:
                                              widget.listTransaction),
                                    ),
                                  );
                                },
                                child: SingleRowContainer(
                                  boxDecoration: BoxDecoration(),
                                  paddingTop: size.width * 0.01,
                                  paddingBottom: size.width * 0.01,
                                  children: [
                                    Container(
                                      width: size.width * 0.2,
                                      child: CircleIconContainer(
                                        urlImage: listTranOfMonth
                                            .elementAt(index)
                                            .rap
                                            .rapUrlImage,
                                        iconSize: size.width * 0.08,
                                        backgroundColor:
                                            Colors.deepOrangeAccent,
                                        padding: size.width * 0.02,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextContainer(
                                            text: listTranOfMonth
                                                .elementAt(index)
                                                .rap
                                                .rapName,
                                            textColor: Colors.black,
                                            textSize: size.width * 0.045,
                                            textFontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                          ),
                                          SizedBox(
                                            height: size.width * 0.02,
                                          ),
                                          TextContainer(
                                            text: listTranOfMonth
                                                .elementAt(index)
                                                .transactionNote,
                                            textColor: Colors.grey,
                                            textSize: size.width * 0.03,
                                            textFontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.02),
                                      alignment: Alignment.centerRight,
                                      width: size.width * 0.3,
                                      child: MoneyTextContainer(
                                        value: listTranOfMonth
                                            .elementAt(index)
                                            .transactionValue,
                                        textSize: size.width * 0.05,
                                        textFontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  String getNameOfDays(int month) {
    String date = "";
    switch (month) {
      case 1:
        date = "Thứ hai";
        break;
      case 2:
        date = "Thứ ba";
        break;
      case 3:
        date = "Thứ tư";
        break;
      case 4:
        date = "Thứ năm";
        break;
      case 5:
        date = "Thứ sáu";
        break;
      case 6:
        date = "Thứ bảy";
        break;
      case 7:
        date = "Chủ nhật";
        break;
      default:
        date = "Error";
        break;
    }
    return date;
  }

}
