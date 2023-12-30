import 'package:expense_tracker_app/constants/colors.dart';
import 'package:expense_tracker_app/screens/budget.dart';
import 'package:expense_tracker_app/screens/home.dart';
import 'package:expense_tracker_app/screens/profile.dart';
import 'package:expense_tracker_app/screens/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottom(),
    );
  }
}

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color = 0;
  List screens = [
    const Homescreen(),
    const TransactionScreen(),
    const BudgetScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: screens[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(eccentricity: 1),
        backgroundColor: AppColors.violet100,
        child: const Icon(
          Icons.add,
          size: 45,
          color: AppColors.light100,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 66,
        color: AppColors.light60,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.home_rounded,
                      size: 28,
                      color: index_color == 0
                          ? AppColors.violet100
                          : AppColors.navIcons,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: index_color == 0
                            ? AppColors.violet100
                            : AppColors.navIcons,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.sync_alt,
                      size: 28,
                      color: index_color == 1
                          ? AppColors.violet100
                          : AppColors.navIcons,
                    ),
                    Text(
                      'Transaction',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: index_color == 0
                            ? AppColors.violet100
                            : AppColors.navIcons,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 45,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.pie_chart_rounded,
                      size: 28,
                      color: index_color == 2
                          ? AppColors.violet100
                          : AppColors.navIcons,
                    ),
                    Text(
                      'Budget',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: index_color == 0
                            ? AppColors.violet100
                            : AppColors.navIcons,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.person_2_rounded,
                      size: 28,
                      color: index_color == 3
                          ? AppColors.violet100
                          : AppColors.navIcons,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: index_color == 0
                            ? AppColors.violet100
                            : AppColors.navIcons,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
