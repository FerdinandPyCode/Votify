import 'package:flutter/material.dart';
import 'package:votify/app/core/constants/asset_data.dart';
import 'package:votify/app/core/generated/widgets/app_input_end_text_widget/app_input.dart';
import 'package:votify/app/core/generated/dynamique_button.dart';
import 'package:votify/app/screem/home_screem/home_screem.dart';

import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_text.dart';

class LoginScreem extends StatefulWidget {
  const LoginScreem({super.key});

  @override
  State<LoginScreem> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  var _formKey = GlobalKey<FormState>();
  late bool signInLoading;
  late bool googleIsLoading;
  late bool facebookIsLoading;
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    signInLoading = false;
    googleIsLoading = false;
    facebookIsLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          StringData.welcomBack,
          weight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        SizedBox(
          height: heigth * .02,
        ),
        Form(
            key: _formKey = GlobalKey<FormState>(),
            child: Column(
              children: [
                //Email
                AppInput(
                    hint: StringData.mailExemple,
                    hasSuffix: false,
                    controller: textEditingControllerEmail,
                    label: StringData.mail,
                    width: width,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringData.mailError;
                      }
                      return null;
                    }),

                SizedBox(
                  height: heigth * .03,
                ),

                //Password
                AppInput(
                    hasSuffix: false,
                    controller: textEditingControllerPassword,
                    label: StringData.password,
                    width: width,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringData.passwordError;
                      }
                      return null;
                    }),
                SizedBox(
                  height: heigth * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Forget Password
                    InkWell(
                      onTap: () {},
                      child: AppText(
                        StringData.forgetPassword,
                        color: AppColors.blackColor,
                      ),
                    ),

                    //Reset Password
                    InkWell(
                      onTap: () {},
                      child: AppText(
                        StringData.resetIt,
                        color: AppColors.blueBgColor,
                      ),
                    ),
                  ],
                ),
                // Sign In button
                SizedBox(
                  height: heigth * .02,
                ),
                Center(
                  child: signInLoading
                      ? CircularProgressIndicator(
                          color: AppColors.blueBgColor,
                        )
                      : DynamiqueButton(
                          action: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                signInLoading = true;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHomeScreem()));
                            } else {
                              setState(() {
                                signInLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: AppText(
                                  StringData.fieldError,
                                  color: AppColors.blackColor,
                                )),
                              );
                            }
                          },
                          bgColor: AppColors.blueBgColor,
                          childs: Center(child: AppText(StringData.signIn)),
                          height: heigth * .065,
                          radius: 15.0,
                          width: width * .35,
                        ),
                ),
                SizedBox(
                  height: heigth * .06,
                ),
                Center(
                  child: AppText(
                    StringData.continueWith,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(
                  height: heigth * .02,
                ),

                // Connect with google or facebook
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Connection with google
                    DynamiqueButton(
                        hasShadow: true,
                        childs: Image.asset(
                          AssetData.google,
                          width: width * .2,
                          height: width * .1,
                          fit: BoxFit.cover,
                        ),
                        width: width * .2,
                        height: width * .1,
                        action: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              signInLoading = false;
                              googleIsLoading = true;
                              facebookIsLoading = false;
                            });
                          } else {
                            setState(() {
                              signInLoading = false;
                              facebookIsLoading = false;
                              googleIsLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: AppText(
                                StringData.fieldError,
                                color: AppColors.blackColor,
                              )),
                            );
                          }
                        },
                        bgColor: AppColors.backgroundColor,
                        radius: 10.0),

                    //Connect with Facebook
                    DynamiqueButton(
                        hasShadow: true,
                        childs: Image.asset(
                          AssetData.facebook,
                          width: width * .2,
                          height: width * .1,
                        ),
                        width: width * .2,
                        height: width * .1,
                        action: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              signInLoading = false;
                              facebookIsLoading = true;
                              googleIsLoading = false;
                            });
                          } else {
                            setState(() {
                              signInLoading = false;
                              facebookIsLoading = false;
                              googleIsLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: AppText(
                                StringData.fieldError,
                                color: AppColors.blackColor,
                              )),
                            );
                          }
                        },
                        bgColor: AppColors.backgroundColor,
                        radius: 10.0),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
