import 'package:expense_tracker_app/components/HomeComponent.dart';
import 'package:expense_tracker_app/constants/colors.dart';
import 'package:expense_tracker_app/screens/Profile.dart';
import 'package:expense_tracker_app/screens/Transaction.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index_color = 0;
  List screens = [
    const HomeScreenComponents(),
    const TransactionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
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
                        color: index_color == 1
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
                    // index_color = 2;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.person_2_rounded,
                      size: 28,
                      color: index_color == 2
                          ? AppColors.violet100
                          : AppColors.navIcons,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: index_color == 2
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
      extendBodyBehindAppBar: true,
      body: screens[index_color],
    );
  }
}
