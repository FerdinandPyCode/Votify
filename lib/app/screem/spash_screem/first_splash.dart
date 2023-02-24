import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_controller/timer_controller.dart';

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

        String token 
        if (ref.watch(mAuthRef).currentUser == null) {
          navigateToNextPage(context, const LoginPage(), back: false);
        } else {
          // await ref.read(userController).setupUser();
          // navigateToNextPage(context, const HomePage(), back: false);
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

// class FirstSplashScreem extends StatelessWidget {
//   const FirstSplashScreem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double heigth = MediaQuery.of(context).size.height;

//     return AnimatedSplashScreen(
//       nextScreen: const LastSplashScreem(),
//       splash: Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         body: Center(
//             child: Image.asset(
//           AssetData.appIcon,
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height,
//           fit: BoxFit.cover,
//         )),
//       ),
//       duration: 3000,
//       splashTransition: SplashTransition.fadeTransition,
//       pageTransitionType: PageTransitionType.rightToLeft,
//     );
//   }
// }
