import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import '../../screem/voting_screems/notification_screem.dart';
import '../../screem/voting_screems/profil.dart';
import '../constants/asset_data.dart';
import 'package:badges/badges.dart' as badges;

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget leadingWidget;
  final double nbrNotification;
  bool isSecond = false;
  Widget? disconnectWidget;
  MyAppBar(
      {super.key,
      required this.leadingWidget,
      this.nbrNotification = 1,
      this.isSecond = false,
      this.disconnectWidget});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AppBar(
      title: badges.Badge(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationScreen()));
        },
        badgeStyle: badges.BadgeStyle(badgeColor: AppColors.blueBgColor),
        position: badges.BadgePosition.topEnd(top: 0.0, end: -5.0),
        showBadge: nbrNotification >= 1 ? true : false,
        badgeContent: AppText(
          nbrNotification.toInt().toString(),
          color: AppColors.backgroundColor,
        ),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.blackColor,
              size: 35.0,
            )),
      ),
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
      leading: leadingWidget,
      actions: [
        isSecond
            ? disconnectWidget!
            : InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilScreem()));
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.backgroundColor,
                  maxRadius: height * .06,
                  child: Image.asset(
                    AssetData.google,
                  ),
                ),
              )
      ],
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
