import 'package:votify_2/app/core/services/services_http.dart';
import 'package:votify_2/app/core/services/setting_config.dart';

class AuthService extends ServicesApi {
  @override
  final String token;

  AuthService({required this.token})
      : super(className: 'AuthService', token: token);

  @override
  void initialization() {
    super.completeUrl =
        SettingConfig.baseUrl + SettingConfig.loginWithGoogleEndPoint;
  }
}
