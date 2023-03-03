import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/models/notif_model.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';

import '../../core/constants/color.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
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
      body: SingleChildScrollView(
        child: SizedBox(
          //padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                StringData.notification,
                color: AppColors.blueBgColor,
                size: 25.0,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 16.0,
              ),
              StreamBuilder(
                  stream: ref.watch(notifController).myNotifs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<NotifModel> liste = snapshot.data ?? [];
                      if (liste.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: AppText(
                            "Aucune notification pour le moment !",
                            color: AppColors.blackColor,
                          ),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: liste.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: getSize(context).width * 0.05),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                //width: double.infinity,
                                //height: 80.0,
                                decoration: BoxDecoration(
                                    color: AppColors.greySkyColor,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: AppColors.blueBgColor))),
                                child: ListTile(
                                  title: AppText(
                                    liste[index].title,
                                    color: AppColors.blackColor,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    size: 20,
                                    weight: FontWeight.bold,
                                  ),
                                  subtitle: AppText(
                                    liste[index].description,
                                    color: AppColors.blackColor,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading:
                                      Image.asset(AssetData.notificationIcONE),
                                )
                                // Row(
                                //   children: [
                                //     Image.asset(AssetData.notificationIcONE),
                                //     const SizedBox(
                                //       width: 5.0,
                                //     ),
                                //     Column(
                                //       children: [
                                //         AppText(
                                //           liste[index].title,
                                //           color: AppColors.blackColor,
                                //           softwrap: true,
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                );
                          });
                    } else if (snapshot.hasError) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: AppText("Une erreur est survenue !"),
                      );
                    } else {
                      return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
