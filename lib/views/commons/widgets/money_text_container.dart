import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:intl/intl.dart';

class MoneyTextContainer extends StatelessWidget {
  final double value, textSize;
  final FontWeight textFontWeight;
  final Color color;

  const MoneyTextContainer({
    Key? key,
    required this.value,
    required this.textSize,
    required this.textFontWeight,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nf = NumberFormat("###,###");
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextContainer(
          text: nf.format(value),
          textColor: color,
          textSize: textSize,
          textFontWeight: textFontWeight,
          decoration: TextDecoration.none,
        ),
        SizedBox(
          width: size.width * 0.01,
        ),
        TextContainer(
          text: "đ",
          textColor: color,
          textSize: textSize,
          textFontWeight: textFontWeight,
          decoration: TextDecoration.underline,
        ),
      ],
    );
  }
}
