import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/constants/conf.dart';
import 'package:votify_2/app/core/models/user_model.dart';
import 'package:votify_2/app/core/services/parse_result.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/helper_preferences.dart';
import 'package:votify_2/app/core/utils/providers.dart';

class UserAuth extends ChangeNotifier {
  UserModel me = UserModel.initial();
  String token = "";
}

class UserController {
  final Ref ref;
  String url = ConfString.BASE_URL + ConfString.AUTH_URL;
  UserController(this.ref);

  Future<FetchData> loginUser(String email, String password) async {
    FetchData result = FetchData(data: null, error: "");

    String myUrl = '${url}jwt/create/';

    Map<String, String> data = {'email': email, 'password': password};

    try {
      await ref.read(dio).post(myUrl, data: data).then((value) async {
        if (value.statusCode == 200) {
          ref.read(userAuth.notifier).token = value.data['refresh'];
          HelperPreferences.saveStringValue("TOKEN_KEY", value.data['refresh']);
          await getMe();
          result.data = true;
        } else {
          result.error = value.data['detail'];
        }
        return result;
      });
    } catch (e) {
      logd(e.toString());
      result.data = false;
      result.error = e.toString();
    }
    return result;
  }

  //   createUser(UserModel userModel) async {
  //   FetchData data = await getWhere({"email": userModel.email});
  //   if (data.error!.isNotEmpty) {
  //     return data.error;
  //   }
  //   List<UserModel> users = data.data;
  //   if (users.isNotEmpty) {
  //     return "Ce email est déjà utilisé par un autre utilisateur";
  //   }
  //   String error = "";
  //   try {
  //     await ref
  //         .read(mAuthRef)
  //         .createUserWithEmailAndPassword(
  //             email: userModel.email, password: userModel.password)
  //         .then((value) async {
  //       if (ref.read(mAuthRef).currentUser != null) {
  //         userModel.user_id = ref.read(mAuthRef).currentUser!.uid;
  //         userModel.fcm = (await FirebaseMessaging.instance.getToken())!;
  //         await ref.read(userRepo).create(userModel);
  //         //saveUser(userModel);
  //       }
  //       return value;
  //     });
  //   } catch (e) {
  //     error = e.toString();
  //   }
  //   return error;
  // }

  // getUser(int userId) async {
  //   FetchData data = await getWhere({"user_id": userId});
  //   logd(data);
  //   if (data.data.isNotEmpty) {
  //     return data.data.first;
  //   } else {
  //     return UserModel.initial();
  //   }
  // }

  getMe() async {
    String myUrl = '${url}users/me/';

    await ref.read(dio).get(myUrl, true).then((value) {
      logd(value);
      if (value.statusCode == 200) {
        UserModel userModel = UserModel.fromMap(value.data);
        ref.read(userAuth.notifier).me = userModel;
      } else {
        logd(value.data['detail']);
      }
    });
  }
}
