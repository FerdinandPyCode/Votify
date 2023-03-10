import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votify/app/core/models/user_model.dart';

import '../../core/constants/asset_data.dart';
import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_input.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_text.dart';
import '../../core/generated/dynamique_button.dart';
import '../../core/providers.dart/auth.dart';

class SignUpScreem extends StatefulWidget {
  const SignUpScreem({super.key});

  @override
  State<SignUpScreem> createState() => _SignUpScreemState();
}

class _SignUpScreemState extends State<SignUpScreem> {
  var _formKey = GlobalKey<FormState>();
  late bool signInLoading;
  late bool googleIsLoading;
  late bool facebookIsLoading;
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController(); 
  TextEditingController textEditingControllerUserName = TextEditingController(); 
  UserModel userModel=UserModel.defaultValue; //Déclaration de l'utilisateur avec des valeur par défaut
  
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
    Auth auth=Provider.of<Auth>(context);  //Déclaration du provider 

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          StringData.welcomVotify,
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

                //Username 
                AppInput(
                    hint: StringData.userNameExemple,
                    hasSuffix: false,
                    controller: textEditingControllerUserName,
                    label: StringData.userName,
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
                
                // Sign Up button
                SizedBox(
                  height: heigth * .02,
                ),
                Center(
                  child: signInLoading?CircularProgressIndicator(color: AppColors.blueBgColor,):DynamiqueButton(
                    action: () {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          signInLoading=true;
                         
                        });
                        userModel.email=textEditingControllerEmail.text;
                        userModel.password=textEditingControllerPassword.text;
                        userModel.username=textEditingControllerUserName.text;
                        auth.register(user: userModel, password: textEditingControllerPassword.text).then((value){
                          if(value){
                            setState(() {
                              signInLoading=false;
                            });
                          }
                        });
                      }else{
                        setState(() {
                          signInLoading=false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: AppText(StringData.fieldError,color: AppColors.blackColor,)),);
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
                          if(_formKey.currentState!.validate()){
                        setState(() {
                          signInLoading=false;
                          googleIsLoading=true;
                          facebookIsLoading=false;
                        });
                      }else{
                        setState(() {
                          signInLoading=false;
                          facebookIsLoading=false;
                          googleIsLoading=false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: AppText(StringData.fieldError,color: AppColors.backgroundColor,)),);
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
                          if(_formKey.currentState!.validate()){
                        setState(() {
                          signInLoading=false;
                          facebookIsLoading=true;
                          googleIsLoading=false;
                        });
                      }else{
                        setState(() {
                          signInLoading=false;
                          facebookIsLoading=false;
                          googleIsLoading=false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: AppText(StringData.fieldError,color: AppColors.blackColor,)),);
                      }
                        },
                        bgColor: AppColors.backgroundColor,
                        radius: 10.0),
                  ],
                ), 
                SizedBox(height:heigth *.1,)
              ],
              
            ))
      ],
    );
  }
}