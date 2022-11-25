import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/wallet_controller.dart';

// ignore: must_be_immutable
class WalletCreate extends StatefulWidget {
  WalletController walletController = Get.put(WalletController());

  WalletCreate({Key? key}) : super(key: key);

  @override
  State<WalletCreate> createState() => _WalletCreateState();
}

class _WalletCreateState extends State<WalletCreate> {
  String? _walletName = "";
  double? _walletBalance = 0.0;

  final controllerWalletName = TextEditingController();
  final controllerWalletBalance = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      initialValue: 0.0,
      precision: 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Thêm mới ví",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Get.back();
            },
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 1, spreadRadius: 2, color: Colors.grey)
                  ],
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(100)),
                            padding: const EdgeInsets.all(25),
                            child: SvgPicture.asset("images/simple_wallet.svg"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 10),
                            child: TextField(
                              controller: controllerWalletName,
                              onChanged: (value) => _walletName = value,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: size.width * 0.003),
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade600,
                                        width: size.width * 0.006),
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.1)),
                                hintText: "Nhập tên ví của bạn",
                                hintStyle: TextStyle(
                                    fontSize: size.width * 0.035,
                                    color: Colors.grey),
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
                                  fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(size.width * 0.001),
                            width: size.width * 0.5,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(color: Colors.grey, blurRadius: 2)
                                ]),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: TextField(
                                    controller: controllerWalletBalance,
                                    onChanged: (value) =>
                                        _walletBalance = double.parse(value),
                                    autofocus: false,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 15, top: 5, bottom: 15),
                                      enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Nhập số dư",
                                      hintStyle: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(size.width * 0.015),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    "VNĐ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * 0.035),
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
              ElevatedButton(
                onPressed: () async{
                  await WalletController().create(controllerWalletName.text, controllerWalletBalance.numberValue).then((value) {
                    Navigator.pop(context,"Create");
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30),
                    primary: const Color(0xFFEE1D1D)),
                child: const Text("Tạo mới"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30)),
                child: const Text("Trở về"),
              ),
            ],
          ),
        ));
  }
}
