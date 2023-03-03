import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/dynamique_button.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_simple_input.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/models/user_model.dart';
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
  //final TextEditingController _mailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String profil = '';
  bool isLoading = false;

  void selectImage() async {
    profil = await UtilsFonction.pickImage(ImageSource.gallery);
    setState(() {});
  }

  @override
  void initState() {
    profil = ref.read(userAuth).me.profilePic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        profilUrl: profil,
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
              SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: SizedBox(
                        height: 90,
                        width: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:AppImageNetwork(
                            url: profil,
                          )//:Image.asset(AssetData.profilVotify),
                        ),
                      ),
                    ),
                    // profil != ''
                    //     ? CircleAvatar(
                    //         radius: 64,
                    //         backgroundImage: FileImage(File(profil)),
                    //       )
                    //     : CircleAvatar(
                    //         radius: 64,
                    //         backgroundColor: AppColors.greySkyColor,
                    //         backgroundImage: AssetImage(AssetData.google),
                    //       ),
                    // AppImageNetwork(
                    //   url: profil.isEmpty ? default_user_pic : profil,
                    // ),
                    // Positioned(
                    //     bottom: -10,
                    //     left: 80.0,
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       width: 40.0,
                    //       height: 40.0,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(50.0),
                    //           color: AppColors.blueBgColor),
                    //       child: IconButton(

                    //           //add photo button
                    //           onPressed: selectImage,
                    //           icon: Icon(
                    //             Icons.add_a_photo,
                    //             color: AppColors.backgroundColor,
                    //           )),
                    //     ))
                    Positioned(
                      bottom: 6,
                      right: 4,
                      child: InkWell(
                        onTap: () async {
                          PickedFile? pickedFile = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              profil = pickedFile.path;
                            });
                          }
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 35,
                          color: AppColors.blackColor,
                        ),
                      ),
                    )
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
                    
                    //Email

                    ListTile(
                      leading: IconButton(
                        onPressed: () {},
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
                        onTap: () {},
                        validator: (value) {
                          return null;
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ref.read(userAuth).me.email,
                            hintStyle: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0)),
                      ),
                    ),

                    //Username
                    ListTile(
                      onTap: (() {
                        _showDialog(context, action: () {
                          setState(() {});
                        },
                            controller: _usernameController,
                            hintText: ref.watch(userAuth).me.username,
                            title: 'Nom d\'utilisateur');
                      }),
                      leading: IconButton(
                        onPressed: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _usernameController,
                              hintText: ref.watch(userAuth).me.username,
                              title:
                                  '${StringData.enterYour}${StringData.password}');
                        },
                        icon: Icon(
                          Icons.person,
                          color: AppColors.greyBlackColor,
                        ),
                      ),
                      title: AppText(
                        'Nom d\'utilisateur',
                        color: AppColors.greyBlackColor,
                        size: 12.0,
                      ),
                      subtitle: TextFormField(
                        onTap: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _usernameController,
                              hintText: ref.watch(userAuth).me.username,
                              title: 'Nom d\'utilisateur');
                        },
                        controller: _usernameController,
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
                            hintText: ref.watch(userAuth).me.username,
                            hintStyle: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0)),
                      ),
                    ),
                    //Name
                    ListTile(
                      onTap: (() {
                        _showDialog(context, action: () {
                          setState(() {});
                        },
                            controller: _nameController,
                            hintText: ref.watch(userAuth).me.lastName,
                            title: '${StringData.enterYour}${StringData.name}');
                      }),
                      leading: IconButton(
                        onPressed: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _nameController,
                              hintText: ref.watch(userAuth).me.lastName,
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
                        onTap: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _nameController,
                              hintText: ref.watch(userAuth).me.lastName,
                              title:
                                  '${StringData.enterYour}${StringData.name}');
                        },
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
                            hintText: ref.watch(userAuth).me.lastName,
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
                            hintText: ref.watch(userAuth).me.firstName,
                            title:
                                '${StringData.enterYour}${StringData.surname}');
                      }),
                      leading: IconButton(
                        onPressed: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _surnameController,
                              hintText: ref.watch(userAuth).me.firstName,
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
                        onTap: () {
                          _showDialog(context, action: () {
                            setState(() {});
                          },
                              controller: _surnameController,
                              hintText: ref.watch(userAuth).me.firstName,
                              title:
                                  '${StringData.enterYour}${StringData.surname}');
                        },
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

                    const SizedBox(
                      height: 12.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: DynamiqueButton(
                  childs: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? CupertinoActivityIndicator(
                              radius: 10,
                              color: AppColors.backgroundColor,
                            )
                          : AppText(
                              "Save",
                              color: AppColors.backgroundColor,
                              size: 12.0,
                            ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Image.asset(
                        AssetData.go,
                        color: AppColors.backgroundColor,
                      )
                    ],
                  ),
                  width: 100,
                  height: 40,
                  bgColor: AppColors.blueBgColor,
                  radius: 10,
                  action: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String img = profil;
                    if (!img.startsWith("http") && img.isNotEmpty) {
                      img = await ref
                          .read(userController)
                          .addImageToStorage(File(img));
                    }

                    UserModel u = ref.read(userAuth).me.copyWith(
                        username: _usernameController.text,
                        firstName: _surnameController.text,
                        lastName: _nameController.text,
                        profilePic: img);
                    await ref.read(userController).updateUser(u);
                    setState(() {
                      isLoading = false;
                    });
                    Fluttertoast.showToast(
                        msg: "Profile mis à jour avec succès !!!");
                  },
                ),
              ),
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
