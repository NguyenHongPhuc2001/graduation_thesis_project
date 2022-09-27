import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/model/Wallet.dart';
import 'package:intl/intl.dart';

class SelectWallet extends StatefulWidget {
  final List<Wallet> listWallet;

  const SelectWallet({
    Key? key,
    required this.listWallet,
  }) : super(key: key);

  @override
  State<SelectWallet> createState() => _SelectWalletState();
}

class _SelectWalletState extends State<SelectWallet> {
  final _random = Random();
  final NumberFormat nf = NumberFormat("###,###");

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
          "Chọn ví",
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.listWallet.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: size.width * 0.04),
              child: InkWell(
                onTap: () {
                  setState(() {
                    Navigator.pop(context, widget.listWallet.elementAt(index));
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
                        child: Image.asset(
                          "icons/icons_1/wallet_icon_1.png",
                          width: size.width * 0.07,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.07),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.listWallet.elementAt(index).walletName,
                              style: TextStyle(
                                fontSize: size.width * 0.07,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.width * 0.015),
                              child: Row(
                                children: [
                                  Text(
                                    nf.format(widget.listWallet
                                        .elementAt(index)
                                        .walletBlanace),
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02),
                                    child: Text(
                                      "đ",
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
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
