import 'package:hive_flutter/hive_flutter.dart';

class TransactionDatabase {
  final _mybox = Hive.box('mybox');

  List transactionList = [];

  void createInitialData() {
    transactionList = [
      ['0', 'Created by Fumi melvin', true, '2024-02-14']
    ];
  }

  // Load data
  void getTransaction() {
    transactionList = _mybox.get("TRANSACTIONLIST");
  }

  // update database
  void updateDatabase() {
    _mybox.put("TRANSACTIONLIST", transactionList);
  }
}
