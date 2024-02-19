import 'dart:math';

import 'package:expense_tracker_app/components/Balances.dart';
import 'package:expense_tracker_app/components/addExpense.dart';
import 'package:expense_tracker_app/components/addIncome.dart';
import 'package:expense_tracker_app/components/transaction_tile.dart';
import 'package:expense_tracker_app/constants/colors.dart';
import 'package:expense_tracker_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreenComponents extends StatefulWidget {
  const HomeScreenComponents({
    super.key,
  });

  @override
  State<HomeScreenComponents> createState() => _HomeScreenComponentsState();
}

class _HomeScreenComponentsState extends State<HomeScreenComponents> {
  final _amount = TextEditingController();
  final _description = TextEditingController();
  final _dateController = TextEditingController();

  double percent = 0.0;

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
    calculatePercentage();
  }

  // add income
  void addNewIncome() {
    setState(
      () {
        db.transactionList.add(
          [
            _amount.text,
            _description.text,
            true,
            _dateController.text,
          ],
        );
        _amount.clear();
        _description.clear();
        _dateController.clear();
      },
    );

    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // add expense
  void addNewExpense() {
    setState(
      () {
        db.transactionList.add(
          [
            _amount.text,
            _description.text,
            false,
            _dateController.text,
          ],
        );
        _amount.clear();
        _description.clear();
        _dateController.clear();
      },
    );

    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // delete income
  void deleteIncome(int index) {
    setState(() {
      db.transactionList.removeAt(index);
    });
    db.updateDatabase();
  }

// Add Income
  void addIncome() {
    showDialog(
      context: context,
      builder: (context) {
        return AddIncome(
          amountController: _amount,
          descriptionController: _description,
          dateController: _dateController,
          saveIncome: addNewIncome,
          isIncome: null,
          selectDate: _selectDate,
        );
      },
    );
  }

  // Add expense
  void addExpense() {
    showDialog(
      context: context,
      builder: (context) {
        return AddExpense(
          amountController: _amount,
          descriptionController: _description,
          saveExpense: addNewExpense,
          isIncome: null,
          dateController: _dateController,
          selectDate: _selectDate,
        );
      },
    );
  }

// select date
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _dateController.text = picked.toString().split(' ')[0];
    }
  }

  double calculateAccountBalance() {
    double totalAmount = 0.0;

    for (var transaction in db.transactionList) {
      double amount = double.tryParse(transaction[0]) ?? 0.0;

      if (transaction[2]) {
        // Income
        totalAmount += amount;
      } else {
        // Expense
        totalAmount -= amount;
      }
    }

    return totalAmount;
  }

  double calculateTotalExpense() {
    double totalExpense = 0.0;

    for (var transaction in db.transactionList) {
      double amount = double.tryParse(transaction[0]) ?? 0.0;

      if (!transaction[2]) {
        // expense
        totalExpense += amount;
      }
    }

    return totalExpense;
  }

  double calculateTotalIncome() {
    double totalIncome = 0.0;

    for (var transaction in db.transactionList) {
      double amount = double.tryParse(transaction[0]) ?? 0.0;

      if (transaction[2]) {
        // income
        totalIncome += amount;
      }
    }

    return totalIncome;
  }

  void calculatePercentage() {
    double totalIncome = calculateTotalIncome();
    double totalExpense = calculateTotalExpense();

    percent = totalIncome != 0 ? (totalExpense / totalIncome) : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: AppColors.violet100,
        overlayColor: AppColors.violet80,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            shape: const CircleBorder(eccentricity: 0),
            child: Image.asset(
              'assets/incomeAdd.png',
            ),
            onTap: () {
              addIncome();
            },
          ),
          SpeedDialChild(
            shape: const CircleBorder(eccentricity: 0),
            child: Image.asset(
              'assets/expenseAdd.png',
            ),
            onTap: () {
              addExpense();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Balances(
              totalAmount: calculateAccountBalance(),
              totalExpense: calculateTotalExpense(),
              totalIncome: calculateTotalIncome(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'My Budget',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.light20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 30,
                    percent: percent ?? 0, // Ensure that percent is not null
                    progressColor: AppColors.violet100,
                    backgroundColor: AppColors.violet40,
                    barRadius: const Radius.circular(15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transaction',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 78,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.violet20,
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: AppColors.violet100,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: min(10, db.transactionList.length),
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
