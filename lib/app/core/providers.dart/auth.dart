// ignore_for_file: prefer_is_not_empty, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/strings.dart';
import '../models/user_model.dart';
import '../services/auth.dart';
import '../services/setting_config.dart';
import 'base.dart';

class Auth extends BaseProvider {
  late UserModel _user;
  static DateTime defaultDate = DateTime(2017, 9, 7, 17, 30);
  // late String _access;
  late String _refresh;
  late DateTime _expiryRefreshDate;
  Timer? _authTimerRefresh;
  late AuthService authService;
  //final AppCubit? appCubit;

  Auth() : super('Auth') {
    _resetVarablesToDefaultValue();
  }

  _resetVarablesToDefaultValue() {
    _refresh = '';
    _expiryRefreshDate = Auth.defaultDate;

    _user = UserModel.defaultValue;
    authService = AuthService(token: '');
  }

  String get token {
    if (_expiryRefreshDate.isAfter(DateTime.now()) && _refresh != '') {
      return _refresh;
    }
    return '';
  }
  
  //Recuperer l'utilisateur 
  UserModel get user {
    return _user;
  }

//Voir si l'utilisateur est connecté  
  bool get isAuth {
    return _refresh.isNotEmpty;
  }

 /* void suscriber({bool unsusbibe = false}) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    if (!unsusbibe) {
      messaging.subscribeToTopic(_user.mail.replaceAll("@", "."));
      messaging.subscribeToTopic("all");
    } else {
      messaging.unsubscribeFromTopic(_user.mail.replaceAll("@", "."));
    }
  }*/

  /*_notifierDataAfterRefreshOrLogin(dynamic data) {
    _refresh = data[AuthString.refresh];
    _expiryRefreshDate = DateTime.fromMillisecondsSinceEpoch(
        double.parse(Jwt.parseJwt(data[AuthString.refresh])['exp'].toString())
                .toInt() *
            1000);
    notifyListeners();
  }*/

  /*_saveInSharePreference() async {
    String toSaveData = '';

    toSaveData = json.encode({
      AuthString.refresh: _refresh,
      AuthString.expiryRefreshDate: UtilsFunctions.formateDate(
          _expiryRefreshDate,
          format: StringData.formatDateTime),
    });

    PersistanceData.savePersistanceData(
        key: AuthString.userData, updateData: toSaveData);
  }*/

//Recupére les informations sur l'utilisateur 
  Future<void> _getUserInfo() async {
    _user = UserModel.fromMap(await authService.list(
        url: SettingConfig.baseUrl + "accounts/users/auth/me/"));
  }

  /*Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    //  UtilsFunctions.prefs
    //       .setBool('new_install${UtilsFunctions.packageInfo.version}', false);
    // prefs.clear();
    if (kDebugMode) {
      print("Started");
    }
    if (!prefs.containsKey(AuthString.userData)) {
      return false;
    }

    final extractedUserData = jsonDecode(
        await PersistanceData.retrivePersistanceData(key: AuthString.userData));

    _expiryRefreshDate =
        DateTime.parse(extractedUserData[AuthString.expiryRefreshDate]);

    _refresh = extractedUserData[AuthString.refresh];
    authService = AuthService(token: _refresh);
    if (_expiryRefreshDate.isBefore(DateTime.now())) {
      return false;
    }
    await _getUserInfo();

    notifyListeners();

    /// Reintializ all property up there ......... and call [Auto LogOut] function

    _autoLogOut();
    return true;
  }*/


//Fonction de creation de compte 


Future<bool> forgetPassword({String? mail}) async {
    String url = " ";
    Map<String, String> body;
    dynamic data;
    if (mail == null) {
      return false;
    } else {
      body = {"email": mail.toString()};
      url = SettingConfig.baseUrl + "accounts/users/auth/reset_password/";
      data = await authService.post(body: body, url: url);
      if (data != null) {
        return false;
      }
      return true;
    }
  }


//------------------------------------------------------Fonction de creation de compte------------------------------------------------------------
  Future<dynamic> register(
      {required UserModel user,
      required String password,
      BuildContext? context}) async {

    Map<String, String> body = user
        .toMap();
    dynamic data = {"erreur":"404"};
    final prefs = await SharedPreferences.getInstance();
    try {
      
        data = await authService.post(
            body: body, url: "${SettingConfig.baseUrl}accounts/users/auth/");
   
      _user = UserModel.fromMap(data);
      //await _login(mail: user.mail, password: password, isLogin: true);*
      if(_user.id.toString().isNotEmpty){

        //Enregistrement des données dans le SharePreferences 
        prefs.setString(StringData.userName,user.username);
        prefs.setString(StringData.mail,user.email);
        prefs.setString(StringData.password,user.password); 

        if (kDebugMode) {
          print("L'id de creation de compte est "+_user.id.toString());
        }
        return true;
      }
      print("erreur de creation de compte  1111111111111111");
      return false;
    } catch (e) {
      print("erreur de creation de compte ");
      return false;
  }
}

//----------------------------------------------------Nouveau mot de passe----------------------------------------------------------------------
Future<bool> SetNewPassword(
      {required String mail,
      required String code,
      required String newPasword}) async {
    Map<String, String> body;
    dynamic data;
    body = {"new_password": newPasword, "activation_code": code, "email": mail};
    data = await authService.post(
        body: body,
        url: SettingConfig.baseUrl +
            "accounts/users/auth/reset_password_confirm/");

    print(data);

    if (data != null) {
      return false;
    }
    return true;
  }

//------------------------------------------------------------ Se connecter avec mot de passe et mail --------------------------------------------------------------
  Future<bool> login(
      {String? mail,
      String password = '',
      required bool isLogin}) async {
    late Map<String, String> body;
    dynamic data;
    try {
      

        body = {'email': mail!, 'password': password};
        data = await authService.post(
            body: body,
            url: SettingConfig.baseUrl + "accounts/users/auth/jwt/create/");


      if (data != null && data[AuthString.refresh] != null) {
        _refresh = data[AuthString.refresh];
        authService = AuthService(token: _refresh);
        final userinfo = await authService.list(
            url: SettingConfig.baseUrl + "accounts/users/auth/me/");
        _user = UserModel.fromMap(userinfo);
        //_notifierDataAfterRefreshOrLogin(data);

        // we try auto logout here
        _autoLogOut();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

//---------------------------------------------------------Se connecter avec google---------------------------------------------------------------
Future<bool> loginWithGooglle(
      {String? mail,
      String password = '',
      required bool isLogin}) async {
    late Map<String, String> body;
    dynamic data;
    try {
      

        body = {'email': mail!, 'password': password};
        data = await authService.post(
            body: body,
            url: SettingConfig.baseUrl + "accounts/users/auth/jwt/create/");


      if (data != null && data[AuthString.refresh] != null) {
        _refresh = data[AuthString.refresh];
        authService = AuthService(token: _refresh);
        final userinfo = await authService.list(
            url: SettingConfig.baseUrl + "accounts/users/auth/me/");
        _user = UserModel.fromMap(userinfo);
        //_notifierDataAfterRefreshOrLogin(data);

        // we try auto logout here
        _autoLogOut();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
  /*
  Future<dynamic> login(BuildContext context,
      {bool forceState = false,
      String? mail,
      String password = "",
      required bool isLogin}) async {
    try {
      if (mail == null) {
        User? user =
            await FireBaseAuthentications.signInWithGoogle(context: context);
        if (user != null) {
          bool _isLogin = await _login(user: user, isLogin: isLogin);

          if (_isLogin) {
            if (forceState) {
              while (appCubit!.state is! AppInitialState) {
                appCubit!.forceState(AppInitialState(
                  actualites: const [],
                  pharmacies: const [],
                  medications: const [],
                ));
                print("try to change state to AppInitialState");
              }
            }
            return true;
          } else {
            appCubit!.forceState(AppLoginSate(
              actualites: const [],
              pharmacies: const [],
              medications: const [],
            ));
            return false;
          }
        } else {
          return false;
        }
      } else {
        bool _isLogin =
            await _login(mail: mail, password: password, isLogin: isLogin);

        if (_isLogin) {
          if (forceState) {
            appCubit!.forceState(AppInitialState(
              actualites: const [],
              pharmacies: const [],
              medications: const [],
            ));
          }
          return true;
        } else {
          appCubit!.forceState(AppLoginSate(
            actualites: const [],
            pharmacies: const [],
            medications: const [],
          ));
          return false;
        }
      }
    } catch (e) {
      print("Erreur ohhhhhhhhhhhh: ${e}");
      return {'erreur': '404'};
    }
  }
*/

//-------------------------------------------------------Deconnexion-------------------------------------------------------------------
Future<void> logout({BuildContext? context}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(AuthString.userData);
    
     authService.post(body: {AuthString.refresh: _refresh}).then((value) {
      _resetVarablesToDefaultValue();
      notifyListeners();
     });
  }

  void _autoLogOut() async {
    if (_authTimerRefresh != null) {
      _authTimerRefresh!.cancel();
    }

    var timeToExpiry = _expiryRefreshDate.difference(DateTime.now()).inSeconds;
    _authTimerRefresh = Timer(Duration(seconds: timeToExpiry), logout);
  }


//-----------------------------------------------Confirmation du compte --------------------------------------------------------------------------
  Future<bool> confirmAccount(
      {required String number, required String email}) async {
    var data = await authService.get1(
        url: SettingConfig.baseUrl +
            "accounts/users/auth/users/activation/$email/$number/",
        withAuthorization: false);

    Map<String, dynamic> message = data as Map<String, dynamic>;

    if (message["message"] != null) {
      return message["message"] == "Account activted successfully";
    } else {
      return false;
    }
  }

//--------------------------------------------------------------Renvoyer le code de validation ---------------------------------------------------
  Future<bool> resendCode({required String email}) async {
    Map<String, String> body = {"email": email};

    await authService.post1(
        withAuthorization: false,
        body: body,
        url: SettingConfig.baseUrl + "/accounts/users/auth/resend_activation/");
    return true;
  }
}





