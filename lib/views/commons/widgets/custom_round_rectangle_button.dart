import 'package:flutter/material.dart';

class CustomRoundRectangleButton extends StatelessWidget {
  final VoidCallback onTap;
  final double buttonWith, padding, borderRadius;
  final EdgeInsets? margin;
  final Widget text;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;

  const CustomRoundRectangleButton({
    Key? key,
    required this.onTap,
    required this.buttonWith,
    required this.padding,
    required this.borderRadius,
    required this.text,
    required this.backgroundColor,
    this.boxShadow, this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        width: buttonWith,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow,
        ),
        child: text,
      ),
    );
  }
}
