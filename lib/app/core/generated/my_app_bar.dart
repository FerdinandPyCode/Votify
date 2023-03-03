import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/generated/widgets/utils/utils.dart';
import '../../screem/voting_screems/notification_screem.dart';
import '../../screem/voting_screems/profil.dart';
import 'package:badges/badges.dart' as badges;

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget leadingWidget;
  final double nbrNotification;
  final String profilUrl;
  bool isSecond = false;
  Widget? disconnectWidget;
  MyAppBar(
      {super.key,
      required this.leadingWidget,
      this.nbrNotification = 1,
      this.isSecond = false,
      this.disconnectWidget,
      this.profilUrl = ''});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AppBar(
      title: badges.Badge(
        badgeStyle: badges.BadgeStyle(badgeColor: AppColors.blueBgColor),
        position: badges.BadgePosition.topEnd(top: 0.0, end: 0.0),
        showBadge: nbrNotification >= 1 ? true : false,
        // badgeContent: AppText(
        //   nbrNotification.toInt().toString(),
        //   color: AppColors.backgroundColor,
        // ),
        child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
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
                    child: AppImageNetwork(
                  url: UtilsFonction.profile,
                  fit: BoxFit.contain,
                )
                    //Image.asset(
                    // profilUrl.isNotEmpty?profilUrl:AssetData.profilVotify,
                    //width: 40.0,
                    // height:40.0,
                    // ),
                    ),
              )
      ],
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
