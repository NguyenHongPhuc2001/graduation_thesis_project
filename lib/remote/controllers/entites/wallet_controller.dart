import 'package:get/get.dart';
import 'package:graduation_thesis_project/models/wallet.dart';
import 'package:graduation_thesis_project/remote/api/Wallet_API.dart';

import '../../../models/account.dart';

class WalletController extends GetxController {

  Future<List<Wallet>?> getList(String accountUsername)  async {
    return await WalletAPI().getList(accountUsername);
  }

  Future<bool?> updateWallet(int? walletId, String? walletName,
      String? walletBalance, Account? account) async {
    return await WalletAPI()
        .update(walletId, walletName, walletBalance, account);
  }

  Future<bool?> delete(int? walletId) async {
    return await WalletAPI().deleteWallet(walletId);
  }

  Future<bool?> create(
      String? walletName, double? walletBalance, Account? account) async {
    return await WalletAPI().create(walletName, walletBalance, account);
  }
}
