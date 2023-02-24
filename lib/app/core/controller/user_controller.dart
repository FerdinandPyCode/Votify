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
  String url = ConfString.AUTH_URL;
  UserController(this.ref);

  Future<FetchData> loginUser(String email, String password) async {
    FetchData result = FetchData(data: null, error: "");

    String myUrl = '${url}jwt/create/';

    Map<String, String> data = {'email': email, 'password': password};

    try {
      logd('Avant le post de dio');
      await ref.read(dio).post(myUrl, data: data).then((value) async {
        logd(value);
        if (value.statusCode == 200) {
          ref.read(userAuth.notifier).token = value.data['refresh'];
          HelperPreferences.saveStringValue("TOKEN_KEY", value.data['refresh']);
          ref.refresh(dio);
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

  Future<FetchData> createUser(Map<String, String> data) async {
    FetchData result = FetchData(data: null, error: "");
    String myUrl = '${url}users/';

    try {
      logd(data);
      
      await ref.read(dio).post(myUrl, data:data).then((value) {
        logd(value);
        if (value.statusCode == 201) {
          UserModel data = UserModel.fromMap(value.data);
          result.data = data;
        } else {
          result.error =
              "Une erreur s'est produite... (${value.statusMessage})";
        }
      });
    } catch (e) {
      result.error = e.toString();
    }
    return result;
  }

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

//hernandezdecos96@gmail.com
//Password229@