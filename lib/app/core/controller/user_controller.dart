import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:votify_2/app/core/constants/conf.dart';
import 'package:votify_2/app/core/models/user_model.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';

class UserAuth extends ChangeNotifier {
  UserModel me = UserModel.initial();
  String token = "";
  String userId = '';
}

class UserController {
  final Ref ref;
  String url = ConfString.AUTH_URL;
  UserController(this.ref);

  // Future<FetchData> loginUser(String email, String password) async {
  //   FetchData result = FetchData(data: null, error: "");

  //   String myUrl = '${url}jwt/create/';

  //   Map<String, String> data = {'email': email, 'password': password};

  //   try {
  //     logd('Avant le post de dio');
  //     await ref.read(dio).post(myUrl, data: data).then((value) async {
  //       if (value.statusCode == 200) {
  //         ref.read(userAuth.notifier).token = value.data['refresh'];
  //         HelperPreferences.saveStringValue("TOKEN_KEY", value.data['refresh']);
  //         ref.refresh(dio);
  //         await getMe();
  //         result.data = true;
  //       } else {
  //         result.error = value.data['detail'];
  //       }
  //       return result;
  //     });
  //   } catch (e) {
  //     logd(e.toString());
  //     result.data = false;
  //     result.error = e.toString();
  //   }
  //   return result;
  // }

  // Future<FetchData> createUser(Map<String, String> data) async {
  //   FetchData result = FetchData(data: null, error: "");
  //   String myUrl = '${url}users/';

  //   try {
  //     logd(data);
  //     logd('Avant le post de dio');
  //     await ref.read(dio).post(myUrl, data: data).then((value) {
  //       logd(value);
  //       if (value.statusCode == 201) {
  //         UserModel data = UserModel.fromMap(value.data);
  //         result.data = data;
  //       } else {
  //         result.error =
  //             "Une erreur s'est produite... (${value.statusMessage})";
  //       }
  //     });
  //   } catch (e) {
  //     result.error = e.toString();
  //   }
  //   return result;
  // }

  // Future<bool> activeAccount(String email, String code) async {
  //   String myUrl = '${url}users/activation/$email/$code/';

  //   await ref.read(dio).get(myUrl, true).then((value) {
  //     logd(value);
  //     if (value.statusCode == 200) {
  //       if (value.data['message'] == 'Account activted successfully') {
  //         return true;
  //       }
  //     } else {
  //       logd(value.data['message']);
  //     }
  //   });
  //   return false;
  // }

  // getMe() async {
  //   String myUrl = '${url}users/me/';

  //   await ref.read(dio).get(myUrl, true).then((value) {
  //     logd(value);
  //     if (value.statusCode == 200) {
  //       UserModel userModel = UserModel.fromMap(value.data);
  //       ref.read(userAuth.notifier).me = userModel;
  //     } else {
  //       logd(value.data['detail']);
  //     }
  //   });
  // }

  Future<UserModel> getMyInfos() async {
    UserModel userModel =
        await UserController(ref).getUser(ref.read(mAuthRef).currentUser!.uid);
    logd(userModel);
    ref.read(userAuth.notifier).me = userModel;
    return userModel;
  }

  Future<void> saveUser(UserModel userModel) async {
    ref.read(userRef).doc(userModel.userId).set(userModel.toMap());
    await getMyInfos();
  }

  Future<void> updateUser(UserModel userModel) async {
    await ref.read(userRef).doc(userModel.userId).update(userModel.toMap());
    await getMyInfos();
  }

  Future<UserModel> getUser(
    String uid,
  ) async {
    UserModel u = UserModel.initial();
    await ref.read(userRef).doc(uid).get().then((value) {
      if (value.exists && value.data() != null) {
        u = UserModel.fromMap(value.data() as Map<String, dynamic>)
            .copyWith(userId: uid);
      }
    });
    return u;
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult =
          await ref.read(mAuthRef).signInWithCredential(credential);
      if (authResult.user == null) {
        return false;
      } else {
        String fullName = authResult.user!.displayName!;
        String firstname = "";
        String lastname = "";
        if (fullName.split(" ").length > 1) {
          firstname = fullName.split(" ")[0];
          lastname = fullName.split(" ")[fullName.split(" ").length - 1];
        } else {
          firstname = fullName;
        }
        String? token = await FirebaseMessaging.instance.getToken();
        UserModel user = UserModel.initial().copyWith(
          firstName: firstname,
          fcm: token,
          lastName: lastname,
          email: authResult.user!.email,
          phone: authResult.user!.phoneNumber,
          profilePic: authResult.user!.photoURL,
          userId: ref.read(mAuthRef).currentUser!.uid,
        );
        await saveUser(user);
        return true;
      }
    } catch (e, ee) {
      logd(e);
      logd(ee);
      return false;
    }
  }

  Future<String> addImageToStorage(File file) async {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    final ref1 =
        ref.read(thumbStorageRef).child("profil").child(date.toString());
    UploadTask task = ref1.putFile(file);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    String urlString = await snapshot.ref.getDownloadURL();

    return urlString;
  }

  Future<bool> signIn(String mail, String pwd) async {
    final userCredential = await ref
        .read(mAuthRef)
        .signInWithEmailAndPassword(email: mail, password: pwd);
    final User? user = userCredential.user;
    if (user == null) {
      return false;
    } else {
      ref.read(userAuth.notifier).userId = ref.read(mAuthRef).currentUser!.uid;

      UserModel user = await getUser(ref.read(mAuthRef).currentUser!.uid);

      user.userId = ref.read(mAuthRef).currentUser!.uid;
      ref.read(userAuth.notifier).me = user;

      return true;
    }
  }

  //Création user
  Future<bool> createUserFirebase(
    String mail,
    String pwd,
    String username, {
    String firtsname = '',
    String lastname = '',
  }) async {
    final userCredential = await ref
        .read(mAuthRef)
        .createUserWithEmailAndPassword(email: mail, password: pwd);
    final User? user = userCredential.user;
    try {
      if (user != null) {
        String? token = await FirebaseMessaging.instance.getToken();
        UserModel userModel = UserModel.initial().copyWith(
            username: username,
            fcm: token,
            email: mail,
            firstName: firtsname,
            lastName: lastname,
            userId: ref.read(mAuthRef).currentUser!.uid);
        //Save the user
        await saveUser(userModel);

        return true;
      }
    } catch (e, ee) {
      logd(e);
      logd(ee);
      return false;
    }

    return false;
  }

  Future<void> logOut() async {
    await ref.read(mAuthRef).signOut();
  }
}

//hernandezdecos96@gmail.com
//Password229@