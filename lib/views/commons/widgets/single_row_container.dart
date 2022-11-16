import 'package:flutter/material.dart';

class SingleRowContainer extends StatelessWidget {
  final double paddingTop, paddingBottom;
  final double? height, width;
  final List<Widget> children;
  final BoxDecoration? boxDecoration;
  final MainAxisAlignment? mainAxisAlignment;

  const SingleRowContainer({
    Key? key,
    required this.paddingTop,
    required this.paddingBottom,
    required this.children,
    this.boxDecoration,
    this.height,
    this.mainAxisAlignment, this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: boxDecoration,
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: (mainAxisAlignment != null)
            ? mainAxisAlignment!
            : MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
