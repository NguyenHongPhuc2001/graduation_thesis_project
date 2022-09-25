import 'dart:math';

import 'package:flutter/material.dart';

class SelectIcons extends StatefulWidget {
  const SelectIcons({Key? key}) : super(key: key);

  @override
  State<SelectIcons> createState() => _SelectIconsState();
}

class _SelectIconsState extends State<SelectIcons> {
  final _random = Random();
  final iconList = <String>[
    "icons/icons_1/budgert_icon_1.png",
    "icons/icons_1/calendar_icon_1.png",
    "icons/icons_1/calendar_icon_2.png",
    "icons/icons_1/calendar_icon_3.png",
    "icons/icons_1/calendar_icon_4.png",
    "icons/icons_1/folder_icon_1.png",
    "icons/icons_1/money_icon_1.png",
    "icons/icons_1/money_icon_2.png",
    "icons/icons_1/money_icon_3.png",
    "icons/icons_1/note_icon_1.png",
    "icons/icons_1/target_icon_1.png",
    "icons/icons_1/wallet_icon_1.png",
    "icons/icons_1/wallet_icon_2.png",
    "icons/icons_1/warning_icon_1.png",
  ];

  String data = "";

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
          "Chọn biểu tượng",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: iconList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: size.width * 0.06),
            child: InkWell(
              onTap: () {
                setState((){
                  data = iconList.elementAt(index);
                });
                Navigator.pop(context,data);
              },
              customBorder: CircleBorder(),
              child: Container(
                alignment: Alignment.center,
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors
                            .primaries[_random.nextInt(Colors.primaries.length)]
                        [_random.nextInt(9) * 100],
                  ),
                  child: Image.asset(
                    iconList[index],
                    width: size.width * 0.07,
                  )),
            ),
          );
        },
      ),
    );
  }
}
