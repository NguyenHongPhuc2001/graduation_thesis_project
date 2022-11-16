// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:graduation_thesis_project/remote/rap_dao.dart';
// import 'package:graduation_thesis_project/models/RAP.dart';
// import 'package:graduation_thesis_project/models/RAPCategory.dart';
//
// class ListRAPByRAPCate extends StatefulWidget {
//   final RAPCategory rapCategory;
//
//   const ListRAPByRAPCate({Key? key, required this.rapCategory}) : super(key: key);
//
//   @override
//   State<ListRAPByRAPCate> createState() => _ListRAPByRAPCateState();
// }
//
// class _ListRAPByRAPCateState extends State<ListRAPByRAPCate> {
//   final List<RAP> listRAP = RAPDAO().getAll();
//   final _random = Random();
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     List<RAP> listRAPByCate = [];
//     listRAP.forEach((rap) {
//       if(rap.rapCategory.id == widget.rapCategory.id)
//         listRAPByCate.add(rap);
//     });
//     RAP rap = RAPDAO().r1;
//
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           centerTitle: true,
//           title: Text(
//             widget.rapCategory.rapCateName,
//             style: TextStyle(
//               fontSize: size.width * 0.065,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         body: Container(
//           width: size.width,
//           height: size.width * 0.23 * listRAP.length,
//           child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: listRAPByCate.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.pop(context, listRAPByCate.elementAt(index));
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(size.width * 0.02),
//                     width: size.width,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                           width: size.width * 0.001,
//                           color: Colors.black,
//                         )),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(size.width * 0.05),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.primaries[_random
//                                 .nextInt(Colors.primaries.length)]
//                             [_random.nextInt(9) * 100],
//                           ),
//                           child: SvgPicture.asset(
//                             listRAPByCate.elementAt(index).rapUrlImage,
//                             width: size.width * 0.07,
//                           ),
//                         ),
//                         Container(
//                           width: size.width * 0.7,
//                           child: _textInTargetDetail(
//                             text:
//                             "${listRAPByCate.elementAt(index).rapName}",
//                             textColor: Colors.black,
//                             textSize: size.width * 0.05,
//                             textFontWeight: FontWeight.bold,
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
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