import 'package:flutter/material.dart';
import 'package:graduation_thesis_project/dao/envent_dao.dart';
import 'package:graduation_thesis_project/dao/rap_dao.dart';
import 'package:graduation_thesis_project/dao/wallet_dao.dart';
import 'package:graduation_thesis_project/model/Transaction.dart';
import 'package:graduation_thesis_project/views/page/transaction.dart';

class TransactionDAO {
  Transactions tran1 = Transactions(
    id: 1,
    transactionNote: "ăn một mình",
    transactionValue: 23000,
    createDate: DateTime.now(),
    rap: RAPDAO().r1,
    wallet: WalletDAO().wl1,
    event: null,
  );

  Transactions tran2 = Transactions(
    id: 2,
    transactionNote: "",
    transactionValue: 50000,
    createDate: DateTime.now().subtract(Duration(days: 18)),
    rap: RAPDAO().r2,
    wallet: WalletDAO().wl2,
    event: EventDAO().ev_1,
  );

  Transactions tran3 = Transactions(
    id: 3,
    transactionNote: "phát tờ rơi",
    transactionValue: 150000,
    createDate: DateTime.now().subtract(Duration(days: 16)),
    rap: RAPDAO().r4,
    wallet: WalletDAO().wl3,
    event: null,
  );

  Transactions tran4 = Transactions(
    id: 4,
    transactionNote: "phát tờ rơi",
    transactionValue: 1250000,
    createDate: DateTime.now(),
    rap: RAPDAO().r4,
    wallet: WalletDAO().wl3,
    event: null,
  );

  Transactions tran5 = Transactions(
    id: 5,
    transactionNote: "phát tờ rơi",
    transactionValue: 1000000,
    createDate: DateTime.now().subtract(Duration(days: 10)),
    rap: RAPDAO().r3,
    wallet: WalletDAO().wl1,
    event: EventDAO().ev_2,
  );

  Transactions tran6 = Transactions(
    id: 6,
    transactionNote: "ăn một mình",
    transactionValue: 23000,
    createDate: DateTime.now().subtract(Duration(days: 2)),
    rap: RAPDAO().r1,
    wallet: WalletDAO().wl1,
    event: null,
  );
  Transactions tran7 = Transactions(
    id: 7,
    transactionNote: "test ne",
    transactionValue: 230300,
    createDate: DateTime.now(),
    rap: RAPDAO().r2,
    wallet: WalletDAO().wl1,
    event: null,
  );

  List<Transactions> listTran = [];

  List<Transactions> getAll(){
    listTran.add(tran1);
    listTran.add(tran2);
    listTran.add(tran3);
    listTran.add(tran4);
    listTran.add(tran5);
    listTran.add(tran6);
    listTran.add(tran7);
    return listTran;
  }

  String update(Transactions oldTran, Transactions newTran){
    oldTran.rap = newTran.rap;
    oldTran.wallet = newTran.wallet;
    oldTran.transactionNote = newTran.transactionNote;
    oldTran.event = newTran.event;
    oldTran.transactionValue = newTran.transactionValue;
    oldTran.createDate = newTran.createDate;
    return "Update";
  }

}
