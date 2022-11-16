// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// import 'package:graduation_thesis_project/views/commons/widgets/appbar_container_2.dart';
// import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
// import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
// import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/budget_select_rap.dart';
// import 'package:intl/intl.dart';
//
// import '../../models/Event.dart';
// import '../../models/RAP.dart';
// import '../../models/Transaction.dart';
// import '../../models/wallet.dart';
// import '../commons/pages/select_event.dart';
// import '../commons/pages/select_wallet.dart';
// import '../commons/widgets/single_row_container.dart';
// import 'add_note.dart';
//
// class UpdateTransaction extends StatefulWidget {
//   final Transactions transactions;
//
//   const UpdateTransaction({
//     Key? key,
//     required this.transactions,
//   }) : super(key: key);
//
//   @override
//   State<UpdateTransaction> createState() => _UpdateTransactionState();
// }
//
// class _UpdateTransactionState extends State<UpdateTransaction> {
//   final _transactionMoneyController = MoneyMaskedTextController(
//       thousandSeparator: ',',
//       decimalSeparator: '',
//       initialValue: 0,
//       precision: 0);
//   final _transactionNoteController = TextEditingController();
//   final df = DateFormat("dd-MM-yyyy");
//
//   var linkIcon, dateTime, event, noteData, wallet, rap;
//   bool _onTextClick = false;
//
//   @override
//   void initState() {
//     dateTime = DateTime.now();
//     _transactionMoneyController.text =
//         widget.transactions.transactionValue.toString();
//     event = widget.transactions.event!;
//     noteData = widget.transactions.transactionNote;
//     wallet = widget.transactions.wallet;
//     rap = widget.transactions.rap;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size(size.width, size.width * 0.15),
//           child: AppBarContainer2(
//             backIcon: CupertinoIcons.xmark,
//             onBackTap: () {
//               Navigator.pop(context);
//             },
//             prefixIcon2: Icons.save,
//             onPrefixIcon2Tap: () {
//               setState((){
//
//               });
//             },
//             text: "Sửa giao dịch",
//           ),
//         ),
//         body: SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Container(
//             width: size.width,
//             height: size.height * 0.849,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 InkWell(
//                   onTap: () async {
//                     final data = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SelectRap(),
//                       ),
//                     ).then((value) => setState(() {
//                           rap = value as RAP;
//                         }));
//                   },
//                   child: SingleRowContainer(
//                     height: size.width * 0.17,
//                     paddingTop: 0,
//                     paddingBottom: 0,
//                     boxDecoration: BoxDecoration(
//                       border: Border(
//                         top: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                         bottom: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                       ),
//                     ),
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.width * 0.015),
//                         width: size.width * 0.25,
//                         decoration: BoxDecoration(
//                           border: Border(
//                             right: BorderSide(
//                               width: size.width * 0.002,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         child: CircleIconContainer(
//                           urlImage: rap.rapUrlImage,
//                           iconSize: size.width * 0.1,
//                           backgroundColor: Colors.green,
//                           padding: size.width * 0.02,
//                         ),
//                       ),
//                       Container(
//                         width: size.width * 0.7,
//                         child: TextContainer(
//                           text: rap.rapName,
//                           textColor: Colors.black,
//                           textSize: size.width * 0.06,
//                           textFontWeight: FontWeight.w400,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SingleRowContainer(
//                   height: size.width * 0.17,
//                   paddingTop: 0,
//                   paddingBottom: 0,
//                   boxDecoration: BoxDecoration(
//                     border: Border(
//                       top: BorderSide(
//                           width: size.width * 0.001, color: Colors.black),
//                       bottom: BorderSide(
//                           width: size.width * 0.001, color: Colors.black),
//                     ),
//                   ),
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(vertical: size.width * 0.015),
//                       width: size.width * 0.25,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           right: BorderSide(
//                             width: size.width * 0.002,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       child: CircleIconContainer(
//                         urlImage: "images/MoneyIcon_1.svg",
//                         iconSize: size.width,
//                         backgroundColor: Colors.transparent,
//                         padding: 0,
//                       ),
//                     ),
//                     Container(
//                       width: size.width * 0.7,
//                       child: Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: size.width * 0.02),
//                               child: TextContainer(
//                                 text: "Số tiền giao dịch",
//                                 textColor: Colors.black,
//                                 textSize: size.width * 0.03,
//                                 textFontWeight: FontWeight.w500,
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Visibility(
//                                   visible: _onTextClick,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         right: size.width * 0.03),
//                                     child: TextContainer(
//                                       text: "đ",
//                                       textColor: Color(0xff8AC926),
//                                       textSize: size.width * 0.07,
//                                       textFontWeight: FontWeight.bold,
//                                       decoration: TextDecoration.none,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: TextField(
//                                     autofocus: false,
//                                     onTap: () {
//                                       setState(() {
//                                         _onTextClick = true;
//                                       });
//                                     },
//                                     keyboardType: TextInputType.number,
//                                     controller: _transactionMoneyController,
//                                     decoration: InputDecoration(
//                                       hintText: "Nhập số tiền ngân sách",
//                                       hintStyle: TextStyle(
//                                         fontSize: size.width * 0.05,
//                                         color: Colors.grey,
//                                         fontWeight: FontWeight.bold,
//                                         decoration: TextDecoration.none,
//                                       ),
//                                       isDense: true,
//                                       border: InputBorder.none,
//                                     ),
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xff8AC926),
//                                       fontSize: size.width * 0.06,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 InkWell(
//                   splashColor: Colors.white,
//                   onTap: () async {
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AddNote(data: noteData),
//                       ),
//                     ).then((value) => setState(() {
//                           noteData = value;
//                         }));
//                   },
//                   child: SingleRowContainer(
//                     boxDecoration: BoxDecoration(
//                       border: Border(
//                         top: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                         bottom: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                       ),
//                     ),
//                     paddingTop: 0,
//                     paddingBottom: 0,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.width * 0.015),
//                         width: size.width * 0.25,
//                         decoration: BoxDecoration(
//                           border: Border(
//                             right: BorderSide(
//                               width: size.width * 0.002,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         child: CircleIconContainer(
//                           urlImage: "images/NoteIcon.svg",
//                           iconSize: size.width * 0.12,
//                           backgroundColor: Colors.transparent,
//                           padding: 0,
//                         ),
//                       ),
//                       Container(
//                         width: size.width * 0.7,
//                         child: TextContainer(
//                           text: ((noteData == "") == true)
//                               ? "Ghi chú (không bắt buộc)"
//                               : noteData,
//                           textColor: ((noteData == "") == true)
//                               ? Colors.grey
//                               : Colors.black,
//                           textSize: size.width * 0.03,
//                           textFontWeight: FontWeight.w400,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                     height: size.width * 0.17,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//
//                   },
//                   child: SingleRowContainer(
//                     boxDecoration: BoxDecoration(
//                       border: Border(
//                         top: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                         bottom: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                       ),
//                     ),
//                     paddingTop: 0,
//                     paddingBottom: 0,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.width * 0.015),
//                         width: size.width * 0.25,
//                         decoration: BoxDecoration(
//                           border: Border(
//                             right: BorderSide(
//                               width: size.width * 0.002,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         child: CircleIconContainer(
//                           urlImage: "images/WalletIcon_1.svg",
//                           iconSize: size.width * 0.09,
//                           backgroundColor: Colors.transparent,
//                           padding: 0,
//                         ),
//                       ),
//                       Container(
//                         width: size.width * 0.7,
//                         child: TextContainer(
//                           text: wallet.walletName,
//                           textColor: Colors.black,
//                           textSize: size.width * 0.05,
//                           textFontWeight: FontWeight.w400,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                     height: size.width * 0.17,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     DateTime? dateValue = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2200),
//                       fieldLabelText: "Ngày",
//                       cancelText: "THOÁT",
//                       confirmText: "XÁC NHẬN",
//                       helpText: "CHỌN NGÀY",
//                     );
//                     setState(() {
//                       dateTime = dateValue as DateTime;
//                     });
//                   },
//                   child: SingleRowContainer(
//                     boxDecoration: BoxDecoration(
//                       border: Border(
//                         top: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                         bottom: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                       ),
//                     ),
//                     paddingTop: 0,
//                     paddingBottom: 0,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.width * 0.015),
//                         width: size.width * 0.25,
//                         decoration: BoxDecoration(
//                           border: Border(
//                             right: BorderSide(
//                               width: size.width * 0.002,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         child: CircleIconContainer(
//                           urlImage: "images/CalendarIcon_3.svg",
//                           iconSize: size.width * 0.09,
//                           backgroundColor: Colors.transparent,
//                           padding: 0,
//                         ),
//                       ),
//                       Container(
//                         width: size.width * 0.7,
//                         child: TextContainer(
//                           text: df.format(dateTime),
//                           textColor: Colors.black,
//                           textSize: size.width * 0.05,
//                           textFontWeight: FontWeight.w400,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                     height: size.width * 0.17,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     final data = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SelectEvent(),
//                       ),
//                     ).then((value) => setState(() {
//                           event = value as Event;
//                         }));
//                   },
//                   child: SingleRowContainer(
//                     boxDecoration: BoxDecoration(
//                       border: Border(
//                         top: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                         bottom: BorderSide(
//                             width: size.width * 0.001, color: Colors.black),
//                       ),
//                     ),
//                     paddingTop: 0,
//                     paddingBottom: 0,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.width * 0.015),
//                         width: size.width * 0.25,
//                         decoration: BoxDecoration(
//                           border: Border(
//                             right: BorderSide(
//                               width: size.width * 0.002,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         child: CircleIconContainer(
//                           urlImage: "images/CalendarIcon_4.svg",
//                           iconSize: size.width * 0.09,
//                           backgroundColor: Colors.transparent,
//                           padding: 0,
//                         ),
//                       ),
//                       Container(
//                         width: size.width * 0.7,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextContainer(
//                               text: (event == null)
//                                   ? "Chọn sự kiện"
//                                   : event.eventName,
//                               textColor: Colors.black,
//                               textSize: size.width * 0.06,
//                               textFontWeight: FontWeight.w400,
//                               decoration: TextDecoration.none,
//                             ),
//                             Visibility(
//                               visible: (event != null),
//                               child: IconButton(
//                                 splashRadius: size.width * 0.08,
//                                 icon: Icon(
//                                   CupertinoIcons.xmark_circle_fill,
//                                   color: Colors.grey,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     event = null;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                     height: size.width * 0.17,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _showCalendarDialog() {
//     Size size = MediaQuery.of(context).size;
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(
//               "Chờ chút",
//               style: TextStyle(
//                 fontSize: size.width * 0.07,
//                 color: Colors.black,
//               ),
//             ),
//             content: Text(
//               "Ngày không hợp lệ ! Vui lòng chọn lại !",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: size.width * 0.04,
//               ),
//             ),
//             actions: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.only(
//                       top: size.width * 0.005, bottom: size.width * 0.005),
//                   width: size.width * 0.2,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(size.width * 0.016),
//                     color: Colors.blueAccent,
//                   ),
//                   child: Text(
//                     "OK",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: size.width * 0.05,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   _checkDate(DateTime date) {
//     DateTime now = DateTime.now();
//     int year1 = now.year,
//         year2 = date.year,
//         month1 = now.month,
//         month2 = date.month,
//         day1 = now.day,
//         day2 = date.day;
//     if (year1 == year2 && month1 == month2 && day1 == day2)
//       return true;
//     else
//       return false;
//   }
// }
