import 'package:graduation_thesis_project/model/Wallet.dart';

class WalletDAO {
  Wallet wl1 = Wallet(
    id: 1,
    walletName: "Ví A",
    walletBlanace: 122333,
    createDate: DateTime.parse("2022-09-12"),
    updateDate: DateTime.parse("2022-09-11"),
  );
  Wallet wl2 = Wallet(
    id: 2,
    walletName: "Ví B",
    walletBlanace: 3333333,
    createDate: DateTime.parse("2022-09-20"),
    updateDate: DateTime.parse("2022-09-21"),
  );
  Wallet wl3 = Wallet(
    id: 3,
    walletName: "Ví C",
    walletBlanace: 4449993,
    createDate: DateTime.parse("2022-09-03"),
    updateDate: DateTime.parse("2022-09-09"),
  );

  List<Wallet> getAllWallet() {
    List<Wallet> listWallet = [];
    listWallet.add(wl1);
    listWallet.add(wl2);
    listWallet.add(wl3);
    return listWallet;
  }
}
