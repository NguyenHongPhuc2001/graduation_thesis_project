import 'package:flutter/material.dart';

class TextHeaderContainer extends StatelessWidget {
  final String text;
  final Color textColor;

  const TextHeaderContainer({
    Key? key,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.065,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}