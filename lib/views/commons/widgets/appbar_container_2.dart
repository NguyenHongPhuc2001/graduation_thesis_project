import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/views/commons/widgets/text_header_container.dart';

class AppBarContainer2 extends StatefulWidget {
  final IconData? prefixIcon1, prefixIcon2;
  final IconData backIcon;
  final VoidCallback? onPrefixIcon1Tap, onPrefixIcon2Tap;
  final VoidCallback onBackTap;
  final String text;

  const AppBarContainer2(
      {Key? key,
      required this.backIcon,
      this.prefixIcon1,
      this.prefixIcon2,
      required this.onBackTap,
      this.onPrefixIcon1Tap,
      this.onPrefixIcon2Tap,
      required this.text})
      : super(key: key);

  @override
  State<AppBarContainer2> createState() => _AppBarContainer2State();
}

class _AppBarContainer2State extends State<AppBarContainer2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          widget.backIcon,
          color: Colors.black,
          size: 20,
        ),
        onPressed: widget.onBackTap,
      ),
      centerTitle: true,
      title: TextHeaderContainer(
        text: widget.text,
        textColor: Colors.black,
      ),
      actions: [
        IconButton(
          splashRadius: size.width * 0.07,
          icon: Icon(
            widget.prefixIcon1,
            color: Colors.black,
          ),
          onPressed: widget.onPrefixIcon1Tap,
        ),
        IconButton(
          splashRadius: size.width * 0.07,
          icon: Icon(
            widget.prefixIcon2,
            color: Colors.black,
            size: 20,
          ),
          onPressed: widget.onPrefixIcon2Tap,
        ),
      ],
    );
  }
}
