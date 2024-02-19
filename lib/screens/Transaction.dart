import 'package:expense_tracker_app/components/transaction_tile.dart';
import 'package:expense_tracker_app/constants/colors.dart';
import 'package:expense_tracker_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionDatabase db = TransactionDatabase();

  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    if (_myBox.get("TRANSACTIONLIST") == null) {
      // create default data
      db.createInitialData();
    } else {
      // user data exist
      db.getTransaction();
    }

    super.initState();
  }

  // delete income
  void deleteIncome(int index) {
    setState(() {
      db.transactionList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.light60,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.expand_more,
                              size: 20,
                              color: AppColors.violet100,
                            ),
                            Text(
                              'October',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.dark50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.filter_list_rounded,
                      size: 32,
                      color: AppColors.violet100,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: db.transactionList.length,
                itemBuilder: (context, index) {
                  int reversedIndex = db.transactionList.length - 1 - index;
                  List<dynamic> transaction = db.transactionList[reversedIndex];
                  return TransactionTile(
                    amount: transaction[0],
                    description: transaction[1],
                    isIncome: transaction[2],
                    date: transaction[3],
                    deleteIncomeFunction: (context) {
                      deleteIncome(reversedIndex);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
