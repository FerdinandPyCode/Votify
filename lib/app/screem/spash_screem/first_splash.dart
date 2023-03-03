// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/helper_preferences.dart';
import 'package:votify_2/app/core/utils/providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:votify_2/app/screem/home_screem/home_screem.dart';
import 'package:votify_2/app/screem/log_sign_screem/login_template.dart';
import 'package:votify_2/app/screem/spash_screem/last_splash.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late TimerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TimerController.seconds(2);
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return TimerControllerListener(
      listener: (BuildContext context, TimerValue value) async {
       
        if (ref.read(mAuthRef).currentUser != null) {
          ref.read(userAuth.notifier).userId =
              ref.read(mAuthRef).currentUser!.uid;

          await ref.read(userController).getMyInfos();
          navigateToNextPageWithTransition(context, const MyHomeScreem(),
              back: false);
        } else {
          bool first = await HelperPreferences.checkKey("FIRST_TIME");
          if (!first) {
            await HelperPreferences.saveStringValue("FIRST_TIME", "1");
            navigateToNextPageWithTransition(context, const LastSplashScreem(),
                back: false);
          } else {
            navigateToNextPageWithTransition(
                context, const LoginTemplateScreem(),
                back: false);
          }
        }
        _controller.dispose();
      },
      listenWhen: (previousValue, currentValue) {
        return currentValue.remaining == 0;
      },
      controller: _controller,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 50,
              right: 50,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetData.appIcon,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 40,
                right: 0,
                left: 0,
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
