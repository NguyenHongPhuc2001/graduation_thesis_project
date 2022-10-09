import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class WalletList extends StatefulWidget {
  const WalletList({Key? key}) : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xE9ECEFED),
        appBar: AppBar(
          title: const Text(
            "Danh sách ví",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          elevation: 2,
        ),
        body: Scrollbar(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: Colors.grey
                      )
                    ]
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset("images/simple_wallet.svg"),
                                )
                              ],
                            ),
                          )
                      ),
                      const Expanded(
                          child: Text(
                            "Ví A",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                        child: Expanded(
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          bottomRight: Radius.circular(100),
                                        )
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    child: const Text(
                                      "2,050,000 VNĐ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Colors.grey
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset("images/simple_wallet.svg"),
                                )
                              ],
                            ),
                          )
                      ),
                      const Expanded(
                          child: Text(
                            "Ví A",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                        child: Expanded(
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                      )
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    child: const Text(
                                      "2,050,000 VNĐ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Colors.grey
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset("images/simple_wallet.svg"),
                                )
                              ],
                            ),
                          )
                      ),
                      const Expanded(
                          child: Text(
                            "Ví A",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                        child: Expanded(
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                      )
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    child: const Text(
                                      "2,050,000 VNĐ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                )
              ],

            )
        )
    );
  }
}