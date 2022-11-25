import 'package:flutter/material.dart';

class TextFieldUnUsed extends StatelessWidget {
  const TextFieldUnUsed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: TextField(
        textAlign: TextAlign.center,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Colors.grey.shade300, width: size.width * 0.005)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Colors.grey.shade600, width: size.width * 0.005)),
          // filled: true,
          fillColor: Colors.white,
          hintText: "Nhập tên mục tiêu",
          hintStyle: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
