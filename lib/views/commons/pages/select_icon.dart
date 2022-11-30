import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SelectIcons extends StatefulWidget {
  const SelectIcons({Key? key}) : super(key: key);

  @override
  State<SelectIcons> createState() => _SelectIconsState();
}

class _SelectIconsState extends State<SelectIcons> {

  final iconList = <String>[
    "images/BoxIcon.svg",
    "images/CalendarIcon_4.svg",
    "images/CarIcon_2.svg",
    "images/ClothIcon_1.svg",
    "images/ElectronicIcon.svg",
    "images/FolderIcon.svg",
    "images/FoodIcon_1.svg",
    "images/FoodIcon_3.svg",
    "images/FoodIcon_4.svg",
    "images/FruitIcon.svg",
    "images/GiftIcon_2.svg",
    "images/GlassIcon.svg",
    "images/HappyIcon.svg",
    "images/HealthIcon_1.svg",
    "images/HouseIcon_1.svg",
    "images/MoneyIcon_1.svg",
    "images/NoteIcon.svg",
    "images/PetsIcon.svg",
    "images/ShoppingIcon_1.svg",
    "images/TVIcon.svg",
  ];

  String data = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context,"Cancle");
          },
        ),
        centerTitle: true,
        title: Text(
          "Chọn biểu tượng",
          style: TextStyle(
            fontSize: size.width * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: iconList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: size.width * 0.06),
            child: InkWell(
              onTap: ()  {
                  setState(() {
                    data = iconList.elementAt(index);
                  });
                  Get.back(result: data);
              },
              customBorder: const CircleBorder(),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue,
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
