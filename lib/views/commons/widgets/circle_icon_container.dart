import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleIconContainer extends StatelessWidget {
  final String urlImage;
  final double iconSize, padding;
  final Color backgroundColor;

  const CircleIconContainer({
    Key? key,
    required this.urlImage,
    required this.iconSize,
    required this.backgroundColor,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: const [BoxShadow(
          color: Colors.grey,
          blurRadius: 2
        )]
      ),
      child: SvgPicture.asset(
        urlImage,
        width: iconSize,
      ),
    );
  }
}
