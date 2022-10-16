import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/services/remote_services.dart';
import 'package:graduation_thesis_project/ui/wallet_setting.dart';

class WalletList extends StatefulWidget {
  const WalletList({Key? key}) : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {

  late List<Wallet> wallets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getData();

  }

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
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          elevation: 2,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                _loadWalletItem(wallets)
              ],

            )
        )
    );
  }

  _getData() async {
    wallets = (await RemoteService().getWallets("ChuTT"))!;
  }

  Widget _loadWalletItem(List<Wallet> wallets) {

    List<Widget> walletItems = <Widget>[];
    for (var item in wallets) {
      walletItems.add(GestureDetector(
        onTap: () async{
          await Get.to(WalletSetting(walletId: item.walletId, walletName: item.walletName, walletBalance: item.walletBalance.toString()));
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

    return Column(children: walletItems);

  }

}
