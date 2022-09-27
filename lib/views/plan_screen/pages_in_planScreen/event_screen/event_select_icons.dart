import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectIcons extends StatefulWidget {
  const SelectIcons({Key? key}) : super(key: key);

  @override
  State<SelectIcons> createState() => _SelectIconsState();
}

class _SelectIconsState extends State<SelectIcons> {
  final _random = Random();
  final iconList = <String>[
    "images/BookIcon.svg",
    "images/BoxIcon.svg",
    "images/BookIcon.svg",
    "images/BudgetIcon.svg",
    "images/CalendarIcon_1.svg",
    "images/CalendarIcon_2.svg",
    "images/CalendarIcon_3.svg",
    "images/CalendarIcon_4.svg",
    "images/CarIcon_1.svg",
    "images/CarIcon_2.svg",
    "images/ClothIcon_1.svg",
    "images/DiamondIcon_1.svg",
    "images/DiamondIcon_2.svg",
    "images/ElectronicIcon.svg",
    "images/FolderIcon.svg",
    "images/FoodIcon_1.svg",
    "images/FoodIcon_2.svg",
    "images/FoodIcon_3.svg",
    "images/FoodIcon_4.svg",
    "images/FruitIcon.svg",
    "images/GiftIcon_1.svg",
    "images/GiftIcon_2.svg",
    "images/GlassIcon.svg",
    "images/HammerIcon.svg",
    "images/HappyIcon.svg",
    "images/HealthIcon_1.svg",
    "images/HealthIcon_2.svg",
    "images/HouseIcon_1.svg",
    "images/HouseIcon_2.svg",
    "images/HouseIcon_3.svg",
    "images/InformationIcon.svg",
    "images/LightbubIcon.svg",
    "images/MoneyIcon_1.svg",
    "images/MoneyIcon_2.svg",
    "images/MoneyIcon_3.svg",
    "images/NoteIcon.svg",
    "images/PersonIcon.svg",
    "images/PetsIcon.svg",
    "images/ReceiptGasIcon.svg",
    "images/ReceiptInternetIcon.svg",
    "images/ReceiptTVIcon.svg",
    "images/SettingIcon.svg",
    "images/ShoppingIcon_1.svg",
    "images/TargetIcon.svg",
    "images/TeamDevIcon.svg",
    "images/TVIcon.svg",
    "images/WalletIcon_1.svg",
    "images/WalletIcon_2.svg",
    "images/WarningIcon.svg",
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
                setState(() {
                  data = iconList.elementAt(index);
                });
                Navigator.pop(context, data);
              },
              customBorder: CircleBorder(),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Colors.primaries[_random.nextInt(Colors.primaries.length)]
                          [_random.nextInt(9) * 100],
                ),
                child: SvgPicture.asset(
                  iconList[index],
                  width: size.width * 0.07,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
