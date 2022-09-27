import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_thesis_project/dao/rapCate_dao.dart';
import 'package:graduation_thesis_project/dao/rap_dao.dart';
import 'package:graduation_thesis_project/model/RAP.dart';
import 'package:graduation_thesis_project/model/RAPCategory.dart';
import 'package:graduation_thesis_project/views/plan_screen/pages_in_planScreen/budget_screen/list_rap_by_rapCate.dart';

class SelectRap extends StatefulWidget {
  const SelectRap({Key? key}) : super(key: key);

  @override
  State<SelectRap> createState() => _SelectRapState();
}

class _SelectRapState extends State<SelectRap> {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<RAP> listRAP = RAPDAO().getAll();
    List<RAPCategory> listRAPCate = RAPCategoryDAO().getAll();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Chọn danh mục",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height * 0.9,

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: size.width * 0.04,
                  bottom: size.width * 0.04,
                  left: size.width * 0.03),
              width: size.width,
              child: _textInTargetDetail(
                text: "Tất cả danh mục",
                textColor: Colors.grey,
                textSize: size.width * 0.06,
                textFontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            Container(
              width: size.width,
              height: size.width * 0.23 * listRAP.length,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listRAPCate.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListRAPByRAPCate(
                              rapCategory: listRAPCate.elementAt(index),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.02),
                        width: size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: size.width * 0.001,
                          color: Colors.black,
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(size.width * 0.05),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.primaries[_random
                                        .nextInt(Colors.primaries.length)]
                                    [_random.nextInt(9) * 100],
                              ),
                              child: SvgPicture.asset(
                                listRAPCate.elementAt(index).rapCateUrlImage,
                                width: size.width * 0.07,
                              ),
                            ),
                            Container(
                              width: size.width * 0.7,
                              child: _textInTargetDetail(
                                text:
                                    "${listRAPCate.elementAt(index).rapCateName}",
                                textColor: Colors.black,
                                textSize: size.width * 0.05,
                                textFontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}

class _textInTargetDetail extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textFontWeight;
  final TextDecoration decoration;

  const _textInTargetDetail({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.textFontWeight,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: textFontWeight,
        decoration: decoration,
      ),
    );
  }
}
