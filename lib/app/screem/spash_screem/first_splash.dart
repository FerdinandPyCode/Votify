

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:votify/app/core/constants/asset_data.dart';
import 'package:votify/app/core/constants/color.dart';

import 'last_splash.dart';

class FirstSplashScreem extends StatelessWidget {
  const FirstSplashScreem({super.key});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double heigth=MediaQuery.of(context).size.height;

    return AnimatedSplashScreen(
      
      nextScreen: const LastSplashScreem(), 
      splash: Scaffold(
        backgroundColor: AppColors.backgroundColor, 
        body: Center( 
          child:Image.asset(AssetData.appIcon,width: double.infinity,height: MediaQuery.of(context).size.height,fit: BoxFit.cover,)
        ),
        ),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        );
  }
}