import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/generated/dynamique_button.dart';

import '../log_sign_screem/login_template.dart';

class LastSplashScreem extends StatelessWidget {
  const LastSplashScreem({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: heigth * .1),
        child: Center(
          child: Column(
            children: [
              //Load image on screem
              Image.asset(
                AssetData.jouet,
                width: width,
                height: heigth * .4,
              ),
              SizedBox(
                height: heigth * .05,
              ),
              //SvgPicture.asset(AssetData.jouetS,width: width,height: heigth*.5,),

              Container(
                //Container description
                padding: EdgeInsets.symmetric(
                    vertical: heigth * .04, horizontal: width * .15),
                height: heigth * .4,
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.greyBlackColor,
                          offset: const Offset(0, -20),
                          blurRadius: 20.0,
                          blurStyle: BlurStyle.outer)
                    ]),
                //Container child
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      StringData.splashTitle,
                      weight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(
                      height: heigth * .03,
                    ),
                    AppText(
                      StringData.splashContent,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(
                      height: heigth * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DotsIndicator(
                          dotsCount: 3,
                          position: 0,
                        ),
                        DynamiqueButton(
                            childs: Icon(
                              Icons.arrow_forward,
                              color: AppColors.backgroundColor,
                              size: heigth * .04,
                            ),
                            width: width * .25,
                            height: heigth * .045,
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginTemplateScreem()));
                            },
                            bgColor: AppColors.blueBgColor,
                            radius: 10.0)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
