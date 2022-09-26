import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WalletCreate extends StatefulWidget {
  const WalletCreate({Key? key}) : super(key: key);

  @override
  State<WalletCreate> createState() => _WalletCreateState();
}

class _WalletCreateState extends State<WalletCreate> {
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintText: "Ví A",
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
                                      hintText: "2.050.000",
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
              ElevatedButton(
                onPressed: (){

                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 30),
                    primary: const Color(0xFFEE1D1D)
                ),
                child: const Text(
                    "Tạo mới"
                ),
              ),
              ElevatedButton(
                onPressed: (){

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
