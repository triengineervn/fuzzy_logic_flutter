import 'package:flutter/material.dart';
import 'package:flutter_fuzzy/modules/chart/charts_screen.dart';
import 'package:flutter_fuzzy/modules/maincontrol/home_screen.dart';
import 'package:flutter_fuzzy/modules/profile/profile_screen.dart';
import 'package:flutter_fuzzy/modules/storage/storage_screen.dart';
import 'package:flutter_fuzzy/themes/app_colors.dart';

class BottomNavigationCustom extends StatefulWidget {
  const BottomNavigationCustom({super.key});

  @override
  State<BottomNavigationCustom> createState() => _BottomNavigationCustomState();
}

class _BottomNavigationCustomState extends State<BottomNavigationCustom> {
  int pageIndex = 0;
  final pages = [
    const HomeScreen(),
    const ChartsScreen(),
    const StorageScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Container(
        color: AppColors.APP_PRIMARY_BUTTON,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(
                    () {
                      pageIndex = 0;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_rounded,
                      color: pageIndex == 0 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: pageIndex == 0 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(
                    () {
                      pageIndex = 1;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stacked_line_chart_rounded,
                      color: pageIndex == 1 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                    ),
                    Text(
                      'Chart',
                      style: TextStyle(
                        color: pageIndex == 1 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(
                    () {
                      pageIndex = 2;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.storage_rounded,
                      color: pageIndex == 2 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                    ),
                    Text(
                      'Storage',
                      style: TextStyle(
                        color: pageIndex == 2 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(
                    () {
                      pageIndex = 3;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_2_rounded,
                      color: pageIndex == 3 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: pageIndex == 3 ? AppColors.APP_SELECT : AppColors.APP_NON_SELECT,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
