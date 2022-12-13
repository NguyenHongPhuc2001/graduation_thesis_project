
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
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: size.width * 0.01,
            spreadRadius: size.width*0.001,
          ),
        ],
      ),
      child: SvgPicture.asset(
        urlImage,
        width: iconSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
