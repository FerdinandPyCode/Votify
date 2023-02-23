import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/screem/log_sign_screem/sign_up.dart';

import 'login.dart';

class LoginTemplateScreem extends StatefulWidget {
  const LoginTemplateScreem({super.key});

  @override
  State<LoginTemplateScreem> createState() => _LoginTemplateScreemState();
}

class _LoginTemplateScreemState extends State<LoginTemplateScreem> {
//Variable
  late bool isLogin;

  @override
  void initState() {
    setState(() {
      isLogin = true;
    });
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: heigth * .01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Icon
                Center(
                    child: Image.asset(
                  AssetData.appIcon,
                  width: width * .7,
                  height: heigth * .3,
                )),

                //Body of page
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.blueBgColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.greyBlackColor,
                            offset: const Offset(0, 1),
                            blurRadius: 20.0,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Login Buttton
                          TextButton(
                              onPressed: () {
                                // Change isLogin value to  true
                                setState(() {
                                  isLogin = true;
                                });
                              },
                              child: AppText(
                                StringData.login,
                                weight: isLogin
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                size: isLogin ? heigth * .03 : heigth * .025,
                                color: isLogin
                                    ? AppColors.backgroundColor
                                    : AppColors.whiteOpac,
                              )),

                          //Sign up Button
                          TextButton(
                              onPressed: () {
                                // Change isLogin value to  false
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: AppText(
                                StringData.signUp,
                                weight: (!isLogin)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                size: (!isLogin) ? heigth * .03 : heigth * .025,
                                color: (!isLogin)
                                    ? AppColors.backgroundColor
                                    : AppColors.whiteOpac,
                              )),
                        ],
                      ),
                      Container(
                        width: width,
                        padding: EdgeInsets.symmetric(
                            vertical: heigth * .03, horizontal: width * .15),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0)),
                            color: AppColors.backgroundColor),
                        child: Column(
                          children: [
                            isLogin ? const LoginScreem() : const SignUpScreem()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
