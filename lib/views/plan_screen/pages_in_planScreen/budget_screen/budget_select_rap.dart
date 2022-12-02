// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../../../controllers/entites/expense_controller.dart';
// import '../../../../remote/controllers/entites/expense_controller.dart';
//
//
// class SelectRap extends StatefulWidget {
//
//   final expenseController = Get.put(ExpenseController());
//
//   SelectRap({Key? key}) : super(key: key);
//
//   @override
//   State<SelectRap> createState() => _SelectRapState();
// }
//
// class _SelectRapState extends State<SelectRap> {
//
//   final _random = Random();
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     Size size = MediaQuery.of(context).size;
//     _loadExpenseList();
//
//     return SafeArea(
//       child: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(
//             CupertinoIcons.xmark,
//             color: Colors.black,
//             size: 18,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         centerTitle: true,
//         title: Text(
//           "Chọn chi tiêu",
//           style: TextStyle(
//             fontSize: size.width * 0.055,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SizedBox(
//         width: size.width,
//         height: size.height * 0.9,
//
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                   top: size.width * 0.04,
//                   bottom: size.width * 0.04,
//                   left: size.width * 0.03),
//               width: size.width,
//               child: _textInTargetDetail(
//                 text: "Tất cả nhóm chi tiêu",
//                 textColor: Colors.grey,
//                 textSize: size.width * 0.05,
//                 textFontWeight: FontWeight.bold,
//                 decoration: TextDecoration.none,
//               ),
//             ),
//             SizedBox(
//               width: size.width,
//               height: size.height * 0.7,
//               child: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: widget.expenseController.expenseList.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         print(widget.expenseController.expenseList[index].toJson());
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(size.width * 0.02),
//                         width: size.width,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                           width: size.width * 0.001,
//                           color: Colors.black,
//                         )),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(size.width * 0.05),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.primaries[_random
//                                         .nextInt(Colors.primaries.length)]
//                                     [_random.nextInt(9) * 100],
//                               ),
//                               child: SvgPicture.asset(
//                                 "images/logo_money.svg",
//                                 width: size.width * 0.07,
//                               ),
//                             ),
//                             SizedBox(
//                               width: size.width * 0.7,
//                               child: _textInTargetDetail(
//                                 text:
//                                     widget.expenseController.expenseList[index].expenseName,
//                                 textColor: Colors.black,
//                                 textSize: size.width * 0.05,
//                                 textFontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   _loadExpenseList() {
//     widget.expenseController.getExpenses();
//   }
// }
//
// class _textInTargetDetail extends StatelessWidget {
//   final String text;
//   final Color textColor;
//   final double textSize;
//   final FontWeight textFontWeight;
//   final TextDecoration decoration;
//
//   const _textInTargetDetail({
//     Key? key,
//     required this.text,
//     required this.textColor,
//     required this.textSize,
//     required this.textFontWeight,
//     required this.decoration,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: textSize,
//         color: textColor,
//         fontWeight: textFontWeight,
//         decoration: decoration,
//       ),
//     );
//   }
// }
//
//
