
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/screem/log_sign_screem/login.dart';

log(dynamic text) {
  if (kDebugMode) {
    print(text);
  }
}


Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

navigateToNextPage(BuildContext context, Widget widget, {bool back = true}) {
  if (back) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  } else {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => widget));
  }
}

navigateToNextPageWithTransition(BuildContext context, Widget widget, {bool back = true}) {
  if (back) {
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
        return widget;
      }, transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }),
    );
  } else {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
        return widget;
      }, transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }),
    );
  }
}

showSnackBar(BuildContext context, String message, {String closeMsg = "OK"}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.w700),
    ),
    backgroundColor: AppColors.whiteOpac,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: closeMsg,
      textColor: AppColors.redColor,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showFlushBar(BuildContext context, String title, String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
    backgroundColor: Colors.black.withOpacity(0.85),
    duration: const Duration(seconds: 3),
    borderRadius: BorderRadius.circular(10),
    titleText: Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
    ),
    messageText: Text(
      message,
      style: const TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
    ),
  ).show(context);
}

void showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          child: SizedBox(
            width: 40,
            height: 60,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      });
}

Center errorLoading(err, stack) {
  log(err);
  log(stack);
  return const Center(child: Text("Une erreur s'est produite pendant le chargement...."));
}

Center loadingError() {
  return const Center(
    child: CupertinoActivityIndicator(),
  );
}

showLogoutModal(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      backgroundColor: AppColors.backgroundColor,
      builder: (context) {
        return Container(
          height: getSize(context).height / 1.5,
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 100, child: Image.asset("assets/img/logo_short.png")),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () async {
                  showFlushBar(context, "Information", "Déconnexion effectuée...");
                  //await ref.read(mAuthRef).signOut();
                  //AppLock.of(context)!.disable();
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                        return const LoginScreem();
                      }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                              Animation<double> secondaryAnimation, Widget child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      }),
                      (Route route) => false);
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.logout),
                        SizedBox(
                          width: 15,
                        ),
                        AppText(
                          "Déconnexion",
                          size: 20,
                          isNormal: false,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
            ],
          ),
        );
      });
}

// void showConfirmAlert(
//   BuildContext context,
//   String title,
//   String message,
//   String confirmText,
//   String rejectText,
//   Function() onPressed,
// ) {
//   Alert(
//     context: context,
//     type: AlertType.warning,
//     title: title,
//     desc: message,
//     onWillPopActive: true,
//     useRootNavigator: false,
//     closeFunction: () {
//       Navigator.pop(context);
//     },
//     buttons: [
//       DialogButton(
//         child: AppText(
//           confirmText,
//           color: Colors.white,
//         ),
//         onPressed: onPressed,
//         width: 120,
//       ),
//       DialogButton(
//         child: AppText(
//           rejectText,
//           color: Colors.white,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         width: 120,
//       )
//     ],
//   ).show();
// }
