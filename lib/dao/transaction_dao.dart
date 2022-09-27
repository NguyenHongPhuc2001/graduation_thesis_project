import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/dao/rap_dao.dart';
import 'package:graduation_thesis_project/dao/wallet_dao.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/page/transaction.dart';

class TransactionDAO {
  Transactions tran1 = Transactions(
    id: 1,
    transactionName: "Ăn trưa",
    transactionNote: "ăn một mình",
    transactionValue: 23000,
    createDate: DateTime.now(),
    rap: RAPDAO().r1,
    wallet: WalletDAO().wl1,
  );

  Transactions tran2 = Transactions(
    id: 2,
    transactionName: "Đổ xăng",
    transactionNote: "",
    transactionValue: 50000,
    createDate: DateTime.now(),
    rap: RAPDAO().r2,
    wallet: WalletDAO().wl2,
  );

  Transactions tran3 = Transactions(
    id: 3,
    transactionName: "Lương làm thêm",
    transactionNote: "phát tờ rơi",
    transactionValue: 150000,
    createDate: DateTime.now(),
    rap: RAPDAO().r4,
    wallet: WalletDAO().wl3,
  );

  Transactions tran4 = Transactions(
    id: 4,
    transactionName: "Lương làm thêm",
    transactionNote: "phát tờ rơi",
    transactionValue: 1250000,
    createDate: DateTime.now(),
    rap: RAPDAO().r4,
    wallet: WalletDAO().wl3,
  );

  Transactions tran5 = Transactions(
    id: 5,
    transactionName: "sssssss",
    transactionNote: "phát tờ rơi",
    transactionValue: 1000000,
    createDate: DateTime.now(),
    rap: RAPDAO().r3,
    wallet: WalletDAO().wl1,
  );

  Transactions tran6 = Transactions(
    id: 6,
    transactionName: "Ăn tối",
    transactionNote: "ăn một mình",
    transactionValue: 23000,
    createDate: DateTime.now(),
    rap: RAPDAO().r1,
    wallet: WalletDAO().wl1,
  );

  List<Transactions> listTran = [];

  List<Transactions> getAll(){
    listTran.add(tran1);
    listTran.add(tran2);
    listTran.add(tran3);
    listTran.add(tran4);
    listTran.add(tran5);
    listTran.add(tran6);
    return listTran;
  }

}
