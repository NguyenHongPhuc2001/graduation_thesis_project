import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/wallet_controller.dart';

// ignore: must_be_immutable
class WalletSetting extends StatefulWidget {

  int? walletId;
  String? walletName;
  String? walletBalance;

  WalletController walletController = Get.put(WalletController());

  WalletSetting({Key? key,required this.walletId, required this.walletName, required this.walletBalance}) :  super(key: key);

  @override
  State<WalletSetting> createState() => _WalletSettingState();
}

class _WalletSettingState extends State<WalletSetting> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final controllerWalletName = TextEditingController();
    final controllerWalletBalance = TextEditingController();

    controllerWalletName.text = widget.walletName!;
    controllerWalletBalance.text = widget.walletBalance.toString();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Điều chỉnh ví",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.4,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 2,
                      color: Colors.grey
                    )
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop(widget.walletController.delete(widget.walletId));
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2
                              )
                            ]
                        ),
                        child: const Icon(
                          Icons.delete,
                          size: 15,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              padding: const EdgeInsets.all(18),
                              child: SvgPicture.asset("images/simple_wallet.svg"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60),
                              child: TextField(
                                controller: controllerWalletName,
                                onChanged: (value) => widget.walletName = value,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Tên ví",
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Số dư",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 16
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              width: size.width * 0.5,
                              height: size.width * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  SizedBox(
                                    height : 40,
                                    child: TextField(
                                      controller: controllerWalletBalance,
                                      onChanged: (value) => widget.walletBalance = value,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide.none
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide.none
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Giá trị ví",
                                        hintStyle: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: const Text(
                                      "VNĐ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8
                                      ),
                                    ),
                                  )
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
              ElevatedButton(
                onPressed: (){
                  widget.walletController.updateWallet(widget.walletId, widget.walletName, widget.walletBalance);
                  Wallet wallet = Wallet(walletId: widget.walletId, walletBalance: double.tryParse(widget.walletBalance.toString()), walletName: widget.walletName);
                  Navigator.of(context).pop(wallet);
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30),
                    primary: const Color(0xFFEE1D1D)
                ),
                child: const Text(
                    "Lưu thông tin ví"
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)
                ),
                child: const Text(
                    "Trở về"
                ),
              ),
            ],
          ),
        )
    );
  }
}
