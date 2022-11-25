import 'package:flutter/material.dart';

class SingleRowContainer2 extends StatelessWidget {
  final double paddingTop, paddingBottom, paddingLeft, paddingRight;
  final double? height, width;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final Color background;

  const SingleRowContainer2({
    Key? key,
    required this.paddingTop,
    required this.paddingBottom,
    required this.children,
    this.height,
    this.mainAxisAlignment,
    this.width,
    required this.paddingLeft,
    required this.paddingRight, required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.025),
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(size.width*0.025),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: Colors.grey.shade500,
              blurRadius: size.width*0.015,
            ),
          ],
        ),
        padding: EdgeInsets.only(
            top: paddingTop,
            bottom: paddingBottom,
            left: paddingLeft,
            right: paddingRight),
        width: size.width*0.8,
        height: height,
        child: Row(
          mainAxisAlignment: (mainAxisAlignment != null)
              ? mainAxisAlignment!
              : MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
