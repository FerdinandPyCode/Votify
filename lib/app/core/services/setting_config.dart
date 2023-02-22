import 'dart:convert';

//Cette class permet d'avoir les configuration relatives pour avoir accès à notre API à notre APi 
class SettingConfig {

  static const String votifyApiKey ='WBMQ8QZH.6XwXnq3zlLyQQ91v1HwD4SLht3IaMfKA';  //Permet d'avoir la clé de notre API
  
  static const String googleApiKey = 'AIzaSyAcLi4BAMxCqaVKReE-DmVNdCBQpg8UbyM';
  static Map<String, String> getHeader({String token = ''}) {
    Map<String, String> header = {
      'votify-Api-Key': SettingConfig.votifyApiKey,
      'Accept': 'application/json',
    };
    if (token.isNotEmpty) header['Authorization'] = 'Bearer $token';
    return header;
  }

  static const String baseUrl = 'https://apioliini.herokuapp.com/';
  static const String serachEndPoint = 'api/search/';
  static const String loginWithGoogleEndPoint = 'api/login/google/';
  static const String productEndPoint = 'api/products/';
  static const String actualiteSlideEndPoint = 'api/actualites/';
  static const String pharmacyEndPoint = 'api/phamacies_public/';
  static const String notificationEndPoint = '/notification/notifications/';
  static const String reservationEndPOint = '/reservation/reservations/';

  static String utf8Fromat(String data) {
    //print('$data: ${utf8.decode(data.runes.toList())}');
    return utf8.decode(data.runes.toList());
  }
}

class PaysConfig {
  static const String devise = 'CFA';
}
