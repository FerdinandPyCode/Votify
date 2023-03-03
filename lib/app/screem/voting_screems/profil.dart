import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_simple_input.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/helper_preferences.dart';
import 'package:votify_2/app/core/utils/providers.dart';
import 'package:votify_2/app/screem/log_sign_screem/login_template.dart';
import '../../core/constants/color.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/utils/utils.dart';

class ProfilScreem extends ConsumerStatefulWidget {
  const ProfilScreem({super.key});

  @override
  ConsumerState<ProfilScreem> createState() => _ProfilScreemState();
}

class _ProfilScreemState extends ConsumerState<ProfilScreem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  void selectImage() async {
    Uint8List im = await UtilsFonction.pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leadingWidget: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_sharp, color: AppColors.blueBgColor)),
        isSecond: true,
        disconnectWidget: disconnectWidget(),
      ),
      floatingActionButton: const FlotingActionButon(),
      bottomNavigationBar: const MyBottomNavigation(
        currentIndex: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: AppColors.greySkyColor,
                            backgroundImage: AssetImage(AssetData.google),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80.0,
                        child: Container(
                          alignment: Alignment.center,
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: AppColors.blueBgColor),
                          child: IconButton(

                              //add photo button
                              onPressed: selectImage,
                              icon: Icon(
                                Icons.add_a_photo,
                                color: AppColors.backgroundColor,
                              )),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.greySkyColor),
                child: Column(
                  children: [
                    //Name
                    ListTile(
                      onTap: (() {
                        _showDialog(context, action: () {
                          setState(() {});
                        },
                            controller: _nameController,
                            hintText: StringData.userNameExemple.split(' ')[0],
                            title: '${StringData.enterYour}${StringData.name}');
                      }),
                      leading: IconButton(
                        onPressed: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _nameController,
                              hintText:
                                  StringData.userNameExemple.split(' ')[0],
                              title:
                                  '${StringData.enterYour}${StringData.name}');
                        },
                        icon: Icon(
                          Icons.person_outline,
                          color: AppColors.greyBlackColor,
                        ),
                      ),
                      title: AppText(
                        StringData.name,
                        color: AppColors.greyBlackColor,
                        size: 12.0,
                      ),
                      subtitle: TextFormField(
                        readOnly: true,
                        controller: _nameController,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.blueBgColor,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: ref.read(userAuth).me.lastName,
                            hintStyle: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),

                    //Surname
                    ListTile(
                      onTap: (() {
                        _showDialog(context, action: () {
                          setState(() {});
                        },
                            controller: _surnameController,
                            hintText: StringData.userNameExemple.split(' ')[1],
                            title:
                                '${StringData.enterYour}${StringData.surname}');
                      }),
                      leading: IconButton(
                        onPressed: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _surnameController,
                              hintText:
                                  StringData.userNameExemple.split(' ')[1],
                              title:
                                  '${StringData.enterYour}${StringData.surname}');
                        },
                        icon: Icon(
                          Icons.person_outline,
                          color: AppColors.greyBlackColor,
                        ),
                      ),
                      title: AppText(
                        StringData.surname,
                        color: AppColors.greyBlackColor,
                        size: 12.0,
                      ),
                      subtitle: TextFormField(
                        readOnly: true,
                        controller: _surnameController,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.blueBgColor,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: ref.read(userAuth).me.firstName,
                            hintStyle: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    //Email

                    ListTile(
                      onTap: (() {
                        _showDialog(context, action: () {
                          setState(() {});
                        },
                            controller: _mailController,
                            hintText: StringData.mailExemple,
                            title: '${StringData.enterYour}${StringData.mail}');
                      }),
                      leading: IconButton(
                        onPressed: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _mailController,
                              hintText: StringData.mailExemple,
                              title:
                                  '${StringData.enterYour}${StringData.mail}');
                        },
                        icon: Icon(
                          Icons.mail,
                          color: AppColors.greyBlackColor,
                        ),
                      ),
                      title: AppText(
                        StringData.mail,
                        color: AppColors.greyBlackColor,
                        size: 12.0,
                      ),
                      subtitle: TextFormField(
                        controller: _mailController,
                        validator: (value) {
                          return null;
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.blueBgColor,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: ref.read(userAuth).me.email,
                            hintStyle: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),

                    //Password
                    ListTile(
                      onTap: (() {
                        _showDialog(context, action: () {
                          setState(() {});
                        },
                            controller: _nameController,
                            hintText: StringData.password,
                            title:
                                '${StringData.enterYour}${StringData.password}');
                      }),
                      leading: IconButton(
                        onPressed: () {
                          _showDialog(context, action: () { 
                            setState(() {});
                          },
                              controller: _nameController,
                              hintText: StringData.password,
                              title:
                                  '${StringData.enterYour}${StringData.password}');
                        },
                        icon: Icon(
                          Icons.lock,
                          color: AppColors.greyBlackColor,
                        ),
                      ),
                      title: AppText(
                        StringData.password,
                        color: AppColors.greyBlackColor,
                        size: 12.0,
                      ),
                      subtitle: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          return null;
                        },
                        obscuringCharacter: '.',
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.blueBgColor,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: '***********',
                            hintStyle: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0)),
                      ),
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

  void _showDialog(BuildContext context,
      {String title = '',
      required TextEditingController controller,
      required VoidCallback action,
      String hintText = ''}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText(
            title,
            color: AppColors.blackColor,
            weight: FontWeight.bold,
            size: 25.0,
          ),
          content: AppSimpleInput(
            hasSuffix: false,
            hintText: hintText,
            textEditingController: controller,
            validator: (value) {
              return null;
            },
          ),
          actions: <Widget>[
            //Cancel
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: AppText(
                  StringData.cancel,
                  color: AppColors.blueBgColor,
                  size: 14.0,
                )),

            //Save
            TextButton(
                onPressed: () {
                  action;
                  Navigator.pop(context);
                },
                child: AppText(
                  StringData.save,
                  color: AppColors.blueBgColor,
                  size: 14.0,
                )),
          ],
        );
      },
    );
  }

  Widget disconnectWidget() {
    return InkWell(
      onTap: () async {
        HelperPreferences.clear();
        await ref.read(userController).logOut();
        navigateToNextPageWithTransition(context, const LoginTemplateScreem(),
            back: false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.logout,
          color: AppColors.redColor,
          size: 25,
        ),
      ),
    );
  }
}
