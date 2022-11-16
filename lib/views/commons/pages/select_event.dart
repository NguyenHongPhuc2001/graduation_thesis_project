import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SelectEvent extends StatefulWidget {
  const SelectEvent({Key? key}) : super(key: key);

  @override
  State<SelectEvent> createState() => _SelectEventState();
}

class _SelectEventState extends State<SelectEvent> {
  final _random = Random();
  // final NumberFormat nf = NumberFormat("###,###");


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Chọn sự kiện",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: size.width * 0.04),
              child: InkWell(
                onTap: () {
                  setState(() {
                    Navigator.pop(context,0);
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.05),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: size.width * 0.001,
                      color: Colors.black,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(size.width * 0.035),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.primaries[
                          _random.nextInt(Colors.primaries.length)]
                          [_random.nextInt(9) * 100],
                        ),
                        child: SvgPicture.asset(
                          "images/CalendarIcon_4.svg",
                          width: size.width * 0.07,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.07),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                fontSize: size.width * 0.07,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
