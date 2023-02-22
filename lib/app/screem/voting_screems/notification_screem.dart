import 'package:flutter/material.dart';
import 'package:votify/app/core/constants/asset_data.dart';
import 'package:votify/app/core/constants/strings.dart';
import 'package:votify/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';

import '../../core/constants/color.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MyAppBar(
        leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(
                  context,
                  );
            },
            icon: Icon(Icons.arrow_back, color: AppColors.blueBgColor)),
      ),
      bottomNavigationBar: const MyBottomNavigation(
        currentIndex: 1,
      ),
      floatingActionButton: const FlotingActionButon(),
      body:SingleChildScrollView(
        child: Container(
          //padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              AppText(StringData.notification,color: AppColors.blueBgColor,size: 25.0,weight: FontWeight.bold,), 
              const SizedBox(height: 16.0,),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context,index){
                  return  Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                  color: AppColors.greySkyColor, 
                  border: Border(bottom: BorderSide(width: 1.5,color: AppColors.blueBgColor))
                ),
                child: Row(
                  children: [
                    Image.asset(AssetData.notificationIcONE),
                    const SizedBox(width: 5.0,),
                    Wrap(
                      children: [
                        AppText(StringData.notificationE,color: AppColors.blackColor,softwrap: true,),
                      ],
                    ),
                  ],
                ),
              );
                }),
             
            ],
          ),
        ),
      ),
    );
  }
}