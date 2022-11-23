import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graduation_thesis_project/models/expense.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';


import '../../remote/controllers/entites/event_controller.dart';
import 'overview_manage_transaction.dart';



class ManageTransaction extends StatefulWidget {
  final List<Expense> listTransaction;

  const ManageTransaction({
    Key? key,
    required this.listTransaction,
  }) : super(key: key);

  @override
  State<ManageTransaction> createState() => _ManageTransactionState();
}

class _ManageTransactionState extends State<ManageTransaction> {
  final List<Tab> listTabs = [];

  int _selectedIndex = DateTime
      .now()
      .month - 1;

  @override
  void initState() {
    _selectedIndex = DateTime
        .now()
        .month - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    listTabs.clear();
    for (int i = 1; i <= 12; i++) {
      if (i == DateTime
          .now()
          .month) {
        String now = "THÁNG NÀY";
        listTabs.add(
          Tab(
            text: "${now}",
          ),
        );
      } else if (i == (DateTime
          .now()
          .month - 1)) {
        String previous = "THÁNG TRƯỚC";
        listTabs.add(
          Tab(
            text: "${previous}",
          ),
        );
      } else {
        listTabs.add(
          Tab(
            text: "${i}/${DateTime
                .now()
                .year}",
          ),
        );
      }
    }

    return SafeArea(
      child: DefaultTabController(
        length: listTabs.length,
        initialIndex: _selectedIndex,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: size.height * 0.12,
            title: Padding(
              padding: EdgeInsets.only(left: size.width * 0.25),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.white,
                highlightColor: Colors.white,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.width * 0.018),
                        border: Border.all(
                          width: size.width * 0.001,
                          color: Colors.black,
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.grey,
                              blurRadius: size.width * 0.01),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextContainer(
                            text: "Ví A",
                            textColor: Colors.black,
                            textSize: size.width * 0.04,
                            textFontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                          SizedBox(
                            height: size.width * 0.01,
                          ),
                          MoneyTextContainer(
                            value: 2222222,
                            textSize: size.width * 0.05,
                            textFontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: size.width * 0.06, right: size.width * 0.035),
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () async {
                    EventController().updateEvent(
                        2,
                        "Event 5 update",
                        "images/QuestionIcon.svg",
                        "2022-11-17",
                        1,
                        false).then((value) => print("value : ${value}"));
                    },
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: size.width * 0.08,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: size.width * 0.06, right: size.width * 0.02),
                child: InkWell(
                  customBorder: CircleBorder(),
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: size.width * 0.08,
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
                print(_selectedIndex);
              },
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
              isScrollable: true,
              tabs: listTabs,
            ),
          ),
          // body: CustomScrollView(
          //   slivers: [
          //     SliverToBoxAdapter(
          //       child: Container(
          //         padding: EdgeInsets.all(size.width * 0.03),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //               offset: Offset(0, 0),
          //               color: Colors.grey,
          //               blurRadius: size.width * 0.01,
          //             ),
          //           ],
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             SingleRowContainer(
          //               paddingTop: 0,
          //               paddingBottom: 0,
          //               children: [
          //                 TextContainer(
          //                   text: "Tổng thu",
          //                   textColor: Colors.grey,
          //                   textSize: size.width * 0.05,
          //                   textFontWeight: FontWeight.w500,
          //                   decoration: TextDecoration.none,
          //                 ),
          //                 MoneyTextContainer(
          //                   value: 222222222,
          //                   textSize: size.width * 0.05,
          //                   textFontWeight: FontWeight.w500,
          //                   color: Colors.blueAccent,
          //                 ),
          //               ],
          //             ),
          //             SingleRowContainer(
          //               paddingTop: size.width * 0.04,
          //               paddingBottom: 0,
          //               children: [
          //                 TextContainer(
          //                   text: "Tổng chi",
          //                   textColor: Colors.grey,
          //                   textSize: size.width * 0.05,
          //                   textFontWeight: FontWeight.w500,
          //                   decoration: TextDecoration.none,
          //                 ),
          //                 MoneyTextContainer(
          //                   value: 2111122,
          //                   textSize: size.width * 0.05,
          //                   textFontWeight: FontWeight.w500,
          //                   color: Colors.red,
          //                 ),
          //               ],
          //             ),
          //             Divider(
          //               thickness: size.width * 0.001,
          //               color: Colors.grey.shade600,
          //               indent: size.width * 0.6,
          //             ),
          //             MoneyTextContainer(
          //               value: 222222,
          //               textSize: size.width * 0.05,
          //               textFontWeight: FontWeight.w500,
          //               color: Colors.black,
          //             ),
          //             Row(
          //               mainAxisSize: MainAxisSize.max,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 CustomRoundRectangleButton(
          //                   onTap: () {},
          //                   margin: EdgeInsets.only(top: size.width * 0.04),
          //                   buttonWith: size.width * 0.7,
          //                   padding: size.width * 0.03,
          //                   borderRadius: size.width * 0.05,
          //                   text: TextContainer(
          //                     text: "XEM BÁO CÁO THÁNG NÀY",
          //                     textColor: Colors.white,
          //                     textSize: size.width * 0.04,
          //                     textFontWeight: FontWeight.bold,
          //                     decoration: TextDecoration.none,
          //                   ),
          //                   backgroundColor: Colors.lightBlue,
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     SliverList(
          //       delegate: SliverChildBuilderDelegate(
          //           childCount: listMonthOfTran.length, (context, index) {
          //         List<Transactions> listTranOfMonth = [];
          //         widget.listTransaction.forEach((item) {
          //           if (item.createDate.month ==
          //                   listMonthOfTran.elementAt(index).createDate.month &&
          //               item.createDate.day ==
          //                   listMonthOfTran.elementAt(index).createDate.day)
          //             listTranOfMonth.add(item);
          //         });
          //         double singleTotalSpending = 0;
          //
          //         listTranOfMonth.forEach((item) {
          //           singleTotalSpending += item.transactionValue;
          //         });
          //         return Padding(
          //           padding: EdgeInsets.only(top: size.width * 0.1),
          //           child: Container(
          //             padding:
          //                 EdgeInsets.symmetric(vertical: size.width * 0.02),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               boxShadow: [
          //                 BoxShadow(
          //                   offset: Offset(0, 0),
          //                   blurRadius: size.width * 0.01,
          //                   color: Colors.grey,
          //                 ),
          //               ],
          //             ),
          //             width: size.width,
          //             child: Column(
          //               children: [
          //                 SingleRowContainer(
          //                   boxDecoration: BoxDecoration(
          //                     border: Border(
          //                       bottom: BorderSide(
          //                         width: size.width * 0.001,
          //                         color: Colors.black,
          //                       ),
          //                     ),
          //                   ),
          //                   paddingTop: size.width * 0.02,
          //                   paddingBottom: size.width * 0.02,
          //                   children: [
          //                     Container(
          //                       padding:
          //                           EdgeInsets.only(left: size.width * 0.02),
          //                       width: size.width * 0.6,
          //                       child: Row(
          //                         children: [
          //                           TextContainer(
          //                             text: listMonthOfTran
          //                                 .elementAt(index)
          //                                 .createDate
          //                                 .day
          //                                 .toString(),
          //                             textColor: Colors.black,
          //                             textSize: size.width * 0.07,
          //                             textFontWeight: FontWeight.bold,
          //                             decoration: TextDecoration.none,
          //                           ),
          //                           SizedBox(
          //                             width: size.width * 0.03,
          //                           ),
          //                           Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               TextContainer(
          //                                 text:
          //                                     "${getNameOfDays(listMonthOfTran.elementAt(index).createDate.weekday)}",
          //                                 textColor: Colors.black,
          //                                 textSize: size.width * 0.03,
          //                                 textFontWeight: FontWeight.w400,
          //                                 decoration: TextDecoration.none,
          //                               ),
          //                               TextContainer(
          //                                 text:
          //                                     "tháng ${listMonthOfTran.elementAt(index).createDate.month} năm ${listMonthOfTran.elementAt(index).createDate.year}",
          //                                 textColor: Colors.black,
          //                                 textSize: size.width * 0.03,
          //                                 textFontWeight: FontWeight.w400,
          //                                 decoration: TextDecoration.none,
          //                               ),
          //                             ],
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     Container(
          //                       padding:
          //                           EdgeInsets.only(right: size.width * 0.02),
          //                       alignment: Alignment.centerRight,
          //                       width: size.width * 0.3,
          //                       child: MoneyTextContainer(
          //                         value: singleTotalSpending,
          //                         textSize: size.width * 0.05,
          //                         textFontWeight: FontWeight.bold,
          //                         color: Colors.black,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 Container(
          //                   width: size.width,
          //                   height: size.width * 0.183 * listTranOfMonth.length,
          //                   child: ListView.builder(
          //                       physics: NeverScrollableScrollPhysics(),
          //                       itemCount: listTranOfMonth.length,
          //                       itemBuilder: (context, index) {
          //                         return Padding(
          //                           padding:
          //                               EdgeInsets.only(top: size.width * 0.04),
          //                           child: InkWell(
          //                             onTap: () {
          //                               Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                   builder: (context) =>
          //                                       TransactionDetail(
          //                                           transaction:
          //                                               listTranOfMonth
          //                                                   .elementAt(index),
          //                                           listTransaction:
          //                                               widget.listTransaction),
          //                                 ),
          //                               );
          //                             },
          //                             child: SingleRowContainer(
          //                               boxDecoration: BoxDecoration(),
          //                               paddingTop: size.width * 0.01,
          //                               paddingBottom: size.width * 0.01,
          //                               children: [
          //                                 Container(
          //                                   width: size.width * 0.2,
          //                                   child: CircleIconContainer(
          //                                     urlImage: listTranOfMonth
          //                                         .elementAt(index)
          //                                         .rap
          //                                         .rapUrlImage,
          //                                     iconSize: size.width * 0.08,
          //                                     backgroundColor:
          //                                         Colors.deepOrangeAccent,
          //                                     padding: size.width * 0.02,
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   width: size.width * 0.5,
          //                                   child: Column(
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.start,
          //                                     children: [
          //                                       TextContainer(
          //                                         text: listTranOfMonth
          //                                             .elementAt(index)
          //                                             .rap
          //                                             .rapName,
          //                                         textColor: Colors.black,
          //                                         textSize: size.width * 0.045,
          //                                         textFontWeight:
          //                                             FontWeight.bold,
          //                                         decoration:
          //                                             TextDecoration.none,
          //                                       ),
          //                                       SizedBox(
          //                                         height: size.width * 0.02,
          //                                       ),
          //                                       TextContainer(
          //                                         text: listTranOfMonth
          //                                             .elementAt(index)
          //                                             .transactionNote,
          //                                         textColor: Colors.grey,
          //                                         textSize: size.width * 0.03,
          //                                         textFontWeight:
          //                                             FontWeight.bold,
          //                                         decoration:
          //                                             TextDecoration.none,
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.only(
          //                                       right: size.width * 0.02),
          //                                   alignment: Alignment.centerRight,
          //                                   width: size.width * 0.3,
          //                                   child: MoneyTextContainer(
          //                                     value: listTranOfMonth
          //                                         .elementAt(index)
          //                                         .transactionValue,
          //                                     textSize: size.width * 0.05,
          //                                     textFontWeight: FontWeight.bold,
          //                                     color: Colors.red,
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         );
          //                       }),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       }),
          //     ),
          //   ],
          // ),
          body: OverviewManageTransaction(
            listTransaction: widget.listTransaction,
            month: _selectedIndex + 1,
          ),
        ),
      ),
    );
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
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
