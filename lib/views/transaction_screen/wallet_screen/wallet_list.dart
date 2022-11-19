import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/wallet_controller.dart';
import 'package:graduation_thesis_project/views/transaction_screen/wallet_screen/wallet_create.dart';
import 'package:graduation_thesis_project/views/transaction_screen/wallet_screen/wallet_setting.dart';
import '../../../models/wallet.dart';

// ignore: must_be_immutable
class WalletList extends StatefulWidget {

  WalletController walletController = Get.put(WalletController());

  List<Wallet>? wallets;

  WalletList({Key? key, required this.wallets}) : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {

  @override
  Widget build(BuildContext context) {

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
            onPressed: (){
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          actions: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                onTap: () async {
                  Get.to(WalletCreate())?.then((value) => {
                    if(value.runtimeType == bool){
                      Fluttertoast.showToast(
                      msg: "Created complete !",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 12.0
                    )
                  }
                  });
                },
                child: Container(
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(100),
                       color: Colors.blue,
                       boxShadow: const [BoxShadow (
                           spreadRadius: 2,
                           blurRadius: 2,
                           color: Colors.black12
                       )]
                   ),
                   child: const Padding(
                     padding: EdgeInsets.all(5.0),
                     child: Text(
                       "Add wallet",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                           fontSize: 10,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                ),
              ),
            ),
          ],
          elevation: 2,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                _loadWalletItem(widget.wallets)
              ],

            )
        )
    );
  }

  Widget _loadWalletItem(List<Wallet>? wallets) {

    List<Widget> walletItems = <Widget>[];
    if(wallets != null){
      for (var item in wallets) {
        walletItems.add(GestureDetector(
          onTap: () async{
            await Get.to(WalletSetting(walletId: item.walletId, walletName: item.walletName, walletBalance: item.walletBalance.toString()))
            ?.then((value) => {
                setState(() {
                  if(value != null){
                    if(value.runtimeType == bool){
                      Fluttertoast.showToast(
                          msg: "Deleted complete !",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 12.0
                      );
                    }else{
                      item = value;
                      Fluttertoast.showToast(
                          msg: "Updated complete !",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 12.0
                      );
                    }
                  }
                })
            });
          },
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Expanded(
                    child: Text(
                      item.walletName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
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
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "${item.walletBalance} VNĐ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 10
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ));
      }
    }

    return Column(children: walletItems);

  }

}
