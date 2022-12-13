import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/remote/api/Wallet_API.dart';

class WalletController extends GetxController {

  Future<List<Wallet>?> getList()  async {
    return await WalletAPI().getList();
  }

  Future<bool?> updateWallet(int? walletId, String? walletName, double? walletBalance) async {
    return await WalletAPI().update(walletId, walletName, walletBalance);
  }

  Future<bool?> delete(int? walletId) async {
    return await WalletAPI().deleteWallet(walletId);
  }

  Future<bool?> create(String? walletName, double? walletBalance) async {
    return await WalletAPI().create(walletName, walletBalance);
  }

  Future<Wallet> getOne(int walletId) async {
    return await WalletAPI().getOne(walletId);
  }

}
