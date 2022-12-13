import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/remote/controllers/entites/wallet_controller.dart';
import 'package:graduation_thesis_project/views/commons/widgets/circle_icon_container.dart';
import 'package:graduation_thesis_project/views/transaction_screen/wallet_screen/wallet_create.dart';
import 'package:graduation_thesis_project/views/transaction_screen/wallet_screen/wallet_setting.dart';
import 'package:intl/intl.dart';
import '../../../models/wallet.dart';

// ignore: must_be_immutable
class WalletList extends StatefulWidget {
  WalletController walletController = Get.put(WalletController());
  final bool isTransaction;
  WalletList({Key? key, required this.isTransaction}) : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  List<Wallet> listWallets = [];
  final NumberFormat nf = NumberFormat("###,###");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WalletController().getList().then((value) {
      setState(() {
        listWallets = List.from(value!);
      });
    });
  }

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
                fontSize: 15.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                onTap: () async {
                  Get.to(WalletCreate())?.then((value) => {
                        if (value == "Create")
                          {
                            widget.walletController.getList().then((value) {
                              setState((){
                                listWallets = List.from(value!);
                              });
                            }),
                            Fluttertoast.showToast(
                                msg: "Thêm ví thành công !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 12.0)
                          }
                      });
                },
                child: Container(
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2, blurRadius: 2, color: Colors.black12)
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: size.width * 0.06,
                  ),
                ),
              ),
            ),
          ],
          elevation: 2,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [_loadWalletItem(listWallets)],
        )));
  }

  Widget _loadWalletItem(List<Wallet>? wallets) {
    Size size = MediaQuery.of(context).size;
    List<Widget> walletItems = <Widget>[];
    if (wallets != null) {
      for (Wallet item in wallets) {
        walletItems.add(GestureDetector(
          onTap: () async {
            (widget.isTransaction==false) ? await Get.to(WalletSetting(
              wallet: item,
            ))!
                .then((value) => {
                      setState(() {
                        if (value != null) {
                          if (value == "Delete") {
                            widget.walletController.getList().then((value) {
                              setState((){
                                listWallets = List.from(value!);
                              });
                            });
                            Fluttertoast.showToast(
                                msg: "Xóa ví thành công !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          } else if (value == "Update") {
                            setState((){
                              item = value;
                            });
                            Fluttertoast.showToast(
                                msg: "Cập nhật ví thành công !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        }
                      })
                    }): Get.back(result: item);
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(blurRadius: 2, spreadRadius: 1, color: Colors.grey)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleIconContainer(
                          urlImage: "images/simple_wallet.svg",
                          iconSize: size.width * 0.06,
                          backgroundColor: Colors.pinkAccent,
                          padding: size.width * 0.03),
                      SizedBox(width: size.width*0.04,),
                      Text(
                        item.walletName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: size.width * 0.01),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                )),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02,
                                  vertical: size.width * 0.01),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "${nf.format(item.walletBalance!)} VNĐ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: size.width * 0.035),
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
      }
    }

    return Column(children: walletItems);
  }


}
