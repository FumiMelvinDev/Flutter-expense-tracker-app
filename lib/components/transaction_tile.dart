import 'package:expense_tracker_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionTile extends StatelessWidget {
  final String amount;
  final String description;
  final String date;
  final bool isIncome;
  Function(BuildContext)? deleteIncomeFunction;

  TransactionTile({
    super.key,
    required this.amount,
    required this.description,
    required this.deleteIncomeFunction,
    required this.isIncome,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteIncomeFunction,
          icon: Icons.delete,
          backgroundColor: Colors.red,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: [
          ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isIncome ? AppColors.blue20 : AppColors.red20,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: isIncome
                    ? const Icon(
                        Icons.add_card,
                      )
                    : const Icon(
                        Icons.payments_outlined,
                      ),
              ),
              title: Text(
                (description),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.dark25,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isIncome ? 'R $amount' : '-R $amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isIncome ? AppColors.blue100 : AppColors.red100,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.light20,
                    ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
