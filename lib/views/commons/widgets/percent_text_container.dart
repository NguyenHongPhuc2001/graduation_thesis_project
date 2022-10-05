import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_container.dart';
import 'package:intl/intl.dart';

class PercentTextContainer extends StatelessWidget {
  final double textSize;
  final String value;
  final FontWeight textFontWeight;
  final Color color;

  const PercentTextContainer({
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
      children: [
        TextContainer(
          text: value,
          textColor: color,
          textSize: textSize,
          textFontWeight: textFontWeight,
          decoration: TextDecoration.none,
        ),
        SizedBox(
          width: size.width * 0.01,
        ),
        TextContainer(
          text: "%",
          textColor: color,
          textSize: textSize,
          textFontWeight: textFontWeight,
          decoration: TextDecoration.underline,
        ),
      ],
    );
  }
}
