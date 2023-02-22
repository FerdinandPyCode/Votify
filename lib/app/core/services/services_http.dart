import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:votify/app/core/services/service1.Dart';
import 'package:votify/app/core/services/setting_config.dart';

abstract class ServicesApi extends ServicesApiDio {
  String completeUrl = '';
  final String className;
  final String token;
  ServicesApi({required this.className, required this.token})
      : super(token, className: className) {
    initialization();
    super.completeUrls = completeUrl;

    super.classNames = className;
  }

  @override
  void initialization();

  Future<dynamic> list({String? url}) async {
    if (kDebugMode) {
      print(className);
    }
    try {
      final result = await http.get(
        Uri.parse(url ?? completeUrl),
        headers: SettingConfig.getHeader(token: token),
      );
      if (kDebugMode) {
        print("[$className]:  ${result.body}");

        log(className);
      }
      final response = jsonDecode(SettingConfig.utf8Fromat(result.body));

      return response;
    } catch (e, strace) {
      if (kDebugMode) {
        log('$className : ${e.toString()}');
        print(strace);
      }
      rethrow;
    }
  }

  Future<dynamic> retrive({required String id, String? url}) async {
    try {
      if (kDebugMode) {
        print(className);
      }
      final result = await http.get(
        url != null ? Uri.parse(url + '/$id') : Uri.parse(completeUrl + '/$id'),
        headers: SettingConfig.getHeader(token: token),
      );
      final response = jsonDecode(SettingConfig.utf8Fromat(result.body));
      return response;
    } catch (e) {
      if (kDebugMode) {
        log('$className : ${e.toString()}');
      }
      rethrow;
    }
  }

  Future<dynamic> post({required Map<String, String> body, String? url}) async {
    if (kDebugMode) {
      print(className);
    }
    try {
      final result = await http.post(Uri.parse(url ?? completeUrl),
          headers: SettingConfig.getHeader(token: token), body: body);
      if (kDebugMode) {
        print(SettingConfig.getHeader(token: token));

        print(result.statusCode);
      }
      final response = jsonDecode(SettingConfig.utf8Fromat(result.body));
      if (kDebugMode) {
        print(response);
      }
      return response;
    } catch (e) {
      log('$className : ${e.toString()}');
      rethrow;
    }
  }

  Future<dynamic> update(
      {required Map<String, String> body,
      required String id,
      String? url}) async {
    if (kDebugMode) {
      print(className);
    }
    try {
      final result = await http.patch(
          url != null
              ? Uri.parse(url + '/$id')
              : Uri.parse(completeUrl + '/$id'),
          headers: SettingConfig.getHeader(token: token),
          body: body);
      final response = jsonDecode(SettingConfig.utf8Fromat(result.body));
      return response;
    } catch (e) {
      log('$className : ${e.toString()}');
      rethrow;
    }
  }

  Future<void> delete({required String id, String? url}) async {
    try {
      if (kDebugMode) {
        print(className);
      }
      /*final result =*/ await http.delete(
        url != null ? Uri.parse(url + '/$id') : Uri.parse(completeUrl + '/$id'),
        headers: SettingConfig.getHeader(token: token),
      );
      // final response = jsonDecode(result.body);
      // return response;
    } catch (e) {
      log('$className : ${e.toString()}');
      rethrow;
    }
  }
}
