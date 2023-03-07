import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';
import 'package:votify_2/app/screem/home_screem/home_screem.dart';
import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_input.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_text.dart';
import '../../core/generated/dynamique_button.dart';

class SignUpScreem extends ConsumerStatefulWidget {
  const SignUpScreem({super.key});

  @override
  ConsumerState<SignUpScreem> createState() => _SignUpScreemState();
}

class _SignUpScreemState extends ConsumerState<SignUpScreem> {
  var _formKey = GlobalKey<FormState>();
  late bool signInLoading;
  late bool googleIsLoading;
  late bool facebookIsLoading;
  late bool isObscure;
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerUserName = TextEditingController();
  TextEditingController textEditingControllerFirstname =
      TextEditingController();
  TextEditingController textEditingControllerLastname = TextEditingController();

  @override
  void initState() {
    super.initState();
    signInLoading = false;
    googleIsLoading = false;
    facebookIsLoading = false;
    isObscure = false;
  }

  @override
  void dispose() {
    textEditingControllerEmail.dispose();
    textEditingControllerFirstname.dispose();
    textEditingControllerLastname.dispose();
    textEditingControllerPassword.dispose();
    textEditingControllerUserName.dispose();
    super.dispose();
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
          StringData.welcomVotify,
          color: AppColors.blackColor,
          size: 20.0,
        ),
        SizedBox(
          height: heigth * .04,
        ),
        Form(
            key: _formKey = GlobalKey<FormState>(),
            child: Column(
              children: [
                //Username
                AppInput(
                    hint: "username",
                    hasSuffix: false,
                    controller: textEditingControllerUserName,
                    label: "Nom d'utilisateur",
                    width: width,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringData.fieldError;
                      }
                      return null;
                    }),
                SizedBox(
                  height: heigth * .02,
                ),
                //firstname
                AppInput(
                    hint: "John",
                    hasSuffix: false,
                    controller: textEditingControllerFirstname,
                    label: "Prénom",
                    width: width,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringData.fieldError;
                      }
                      return null;
                    }),
                SizedBox(
                  height: heigth * .02,
                ),
                //Lastname
                AppInput(
                    hint: "DOE",
                    hasSuffix: false,
                    controller: textEditingControllerLastname,
                    label: "Nom de famille",
                    width: width,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringData.fieldError;
                      }
                      return null;
                    }),
                SizedBox(
                  height: heigth * .02,
                ),
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
                  height: heigth * .02,
                ),

                //Password
                AppInput(
                    hasSuffix: true,
                    isObscure: isObscure,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (isObscure == true) {
                              isObscure = false;
                            } else {
                              isObscure = true;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: AppColors.blackColor,
                        )),
                    controller: textEditingControllerPassword,
                    label: "Mot de passe",
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

                // Sign Up button
                SizedBox(
                  height: heigth * .05,
                ),
                Center(
                  child: signInLoading
                      ? CircularProgressIndicator(
                          color: AppColors.blueBgColor,
                        )
                      : DynamiqueButton(
                          action: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                signInLoading = true;
                              });

                              // Map<String, String> map = {
                              //   "username": textEditingControllerUserName.text,
                              //   "first_name": 'None',
                              //   "last_name": 'None',
                              //   "address": "None",
                              //   "phone": "None",
                              //   "email": textEditingControllerEmail.text,
                              //   "password": textEditingControllerPassword.text,
                              //   "re_password":
                              //       textEditingControllerPassword.text
                              // };

                              await ref
                                  .read(userController)
                                  .createUserFirebase(
                                      textEditingControllerEmail.text,
                                      textEditingControllerPassword.text,
                                      textEditingControllerUserName.text,
                                      firtsname:
                                          textEditingControllerFirstname.text,
                                      lastname:
                                          textEditingControllerLastname.text)
                                  .then(
                                (value) {
                                  if (value) {
                                    showFlushBar(context, "Création de compte",
                                        "Votre compte est créé avec succès !");
                                    navigateToNextPage(
                                        context, const MyHomeScreem(),
                                        back: false);
                                  } else {
                                    showFlushBar(context, "Création de compte",
                                        "La création du compte à échouer , mail déjà utilisé ou mot de passe trop court.");
                                  }
                                },
                              );

                              setState(() {
                                signInLoading = false;
                              });
                              // navigateToNextPage(
                              //     context, const ConfirmationCodePage());
                            } else {
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
                          childs: Center(child: AppText(StringData.signUp)),
                          height: heigth * .065,
                          radius: 15.0,
                          width: width * .35,
                        ),
                ),
                SizedBox(
                  height: heigth * .04,
                ),
                /*Center(
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
                                color: AppColors.backgroundColor,
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
                ),*/
                SizedBox(
                  height: heigth * .1,
                )
              ],
            ))
      ],
    );
  }
}
