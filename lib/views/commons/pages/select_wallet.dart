import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_thesis_project/models/wallet.dart';

import 'package:graduation_thesis_project/views/commons/widgets/custom_round_rectangle_button.dart';
import 'package:graduation_thesis_project/views/commons/widgets/money_text_container.dart';
import 'package:intl/intl.dart';

import '../../../un_used/WalletNew.dart';
import '../widgets/circle_icon_container.dart';
import '../widgets/single_row_container_2.dart';
import '../widgets/text_container.dart';

class SelectWallet extends StatefulWidget {
  final List<Wallet> listWallet;
  final int? walletId;

  const SelectWallet({
    Key? key,
    required this.listWallet,
    this.walletId,
  }) : super(key: key);

  @override
  State<SelectWallet> createState() => _SelectWalletState();
}

class _SelectWalletState extends State<SelectWallet> {
  final NumberFormat nf = NumberFormat("###,###");
  final List<Wallet> listWallet = [];
  var walletSelected, indexSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.walletId != null) {
      for (int i = 0; i < widget.listWallet.length; i++) {
        if (widget.listWallet[i].walletId == widget.walletId) {
          setState(() {
            indexSelected = i;
            walletSelected = widget.listWallet[i];
          });
        }
      }
    }
  }

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
            if (walletSelected != null) {
              Navigator.pop(context, walletSelected);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        centerTitle: true,
        title: Text(
          "Chọn ví",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("Index value ${widget.walletId}");
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: (widget.listWallet.isNotEmpty)
          ? ListView.builder(
              itemCount: widget.listWallet.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        indexSelected = index;
                        walletSelected = widget.listWallet.elementAt(index);
                      });
                    },
                    child: SingleRowContainer2(
                      paddingLeft: size.width * 0.01,
                      paddingRight: size.width * 0.01,
                      paddingTop: size.width * 0.02,
                      paddingBottom: size.width * 0.02,
                      background: Colors.white,
                      children: [
                        Container(
                          width: size.width * 0.2,
                          child: CircleIconContainer(
                            urlImage: "images/WalletIcon_1.svg",
                            iconSize: size.width * 0.045,
                            backgroundColor: Color(0xffFB8500),
                            padding: size.width * 0.045,
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.width * 0.03),
                                    child: TextContainer(
                                      text: widget.listWallet.elementAt(index).walletName!,
                                      textColor: Colors.black,
                                      textSize: size.width * 0.045,
                                      textFontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  MoneyTextContainer(
                                    value: widget.listWallet
                                        .elementAt(index)
                                        .walletBalance!,
                                    textSize: size.width * 0.04,
                                    textFontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: size.width * 0.05,
                          width: size.width * 0.15,
                          child: (indexSelected != null &&
                                  indexSelected == index)
                              ? Container(
                                  margin: EdgeInsets.all(size.width * 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: size.width * 0.005,
                                      color: Color(0xffFB8500),
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(size.width * 0.013),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFB8500),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.all(size.width * 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: size.width * 0.005,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : Container(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          top: size.width * 0.038,
          bottom: size.width * 0.038,
          left: size.width * 0.022,
          right: size.width * 0.022,
        ),
        width: size.width,
        height: size.width * 0.2,
        child: CustomRoundRectangleButton(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.grey,
              blurRadius: size.width * 0.04,
            ),
          ],
          onTap: () {
            setState(() {
              Navigator.pop(context, walletSelected);
            });
          },
          buttonWith: size.width * 0.95,
          padding: size.width * 0.02,
          borderRadius: size.width * 0.02,
          text: Text(
            "Chọn ví",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.07,
            ),
          ),
          backgroundColor: Color(0xffFB8500),
        ),
      ),
    );
  }
}
