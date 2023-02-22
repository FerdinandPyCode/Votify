import 'package:flutter/material.dart';
import 'package:votify/app/core/constants/color.dart';
import 'package:votify/app/screem/home_screem/home_screem.dart';
import 'package:votify/app/screem/voting_screems/historie_screem.dart';
import 'package:votify/app/screem/voting_screems/seach_screem.dart';

import '../../../constants/asset_data.dart';



class MyBottomNavigation extends StatefulWidget  {
  const MyBottomNavigation({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int index = 0;
  @override
  void initState() {
    setState(() {
      index = widget.currentIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          elevation: 1.0,
          selectedIconTheme:  IconThemeData(color: AppColors.blueBgColor),
          selectedItemColor: AppColors.blueBgColor,
          unselectedItemColor: AppColors.blackColor,
          selectedLabelStyle:  TextStyle(
              color: AppColors.blueBgColor,
              fontSize: 5.0,
              fontWeight: FontWeight.bold),
          iconSize: 30.0,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
            bottomNavigationBarItemSelected(index);
          },
          items: [
            // Home Screem
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AssetData.homeIcon,
                  color: AppColors.blueBgColor,
                  width: 30.0,
                  height: 30.0,
                ),
                label: '',
                icon: Image.asset(
                  AssetData.homeIcon,
                  color: AppColors.blackColor,
                  width: 30.0,
                  height: 30.0,
                ),),

            //Historique polls
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AssetData.historiqueIcon,
                  color: AppColors.blueBgColor,
                  width: 30.0,
                  height: 30.0,
                ),
                label: '',
                icon: Image.asset(
                  AssetData.historiqueIcon,
                  color: AppColors.blackColor,
                  width: 30.0,
                  height: 30.0,
                ),),

            // Search button
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  AssetData.searchIcon,
                  color: AppColors.blueBgColor,
                  width: 30.0,
                  height: 30.0,
                ),
                label: '',
                icon: Image.asset(
                  AssetData.searchIcon,
                  color: AppColors.blackColor,
                  width: 30.0,
                  height: 30.0,
                ),),

          ]);
  }
  void bottomNavigationBarItemSelected(value) {
    switch (value) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyHomeScreem()));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHistorieScreem()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScreem()));
        break;
      default:
    }
  }
}