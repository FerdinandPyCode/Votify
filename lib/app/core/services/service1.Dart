import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ServicesApi1 {}

abstract class ServicesApiDio extends ServicesApi1 {
  String completeUrls = '';
  String classNames = 'UNKNOWN';
  Dio dio = Dio();

  void initialization();
  final String tokens;

  ServicesApiDio(this.tokens, {required String className}) {
    initialization();
  }
  getHeaders(bool withAuthorization) {
    Map<String, String> header = {
      'Accept': 'application/json',
    };
    if (withAuthorization) {
      // add to header the authorisations flags*
      header["Authorization"] = 'Bearer $tokens';
    }
    return header;
  }

  Future<dynamic> get1({bool withAuthorization = true, String? url}) async {
    try {
      if (kDebugMode) {
        log("${getHeaders(withAuthorization)}", name: 'headers');
      }
      final result = await dio.get(
        url ?? completeUrls,
        options: Options(headers: getHeaders(withAuthorization)),
      );
      if (kDebugMode) {
        log('$result');
      }
      if (kDebugMode) {
        print(classNames);
      }
      return result.data;
    } on DioError catch (e, strace) {
      if (kDebugMode) {
        log('\x1B[31m$classNames class \x1B[0m');
        // print(e.toString());
        log(strace.toString());
      }
      throw e.response?.data;
    }
  }

  Future<dynamic> retrieve1(
      {required String id, String? url, bool withAuthorization = true}) async {
    try {
      final result = await dio.get((url ?? completeUrls) + '$id/',
          options: Options(headers: getHeaders(withAuthorization)));
      if (kDebugMode) {
        print(classNames);
      }
      return result.data;
    }on DioError catch (e, strace) {
      if (kDebugMode) {
        print('\x1B[31m$classNames class \x1B[0m');
        print(e.toString());
        print(strace.toString());
      }
      throw e.response?.data;
    }
  }

  Future<dynamic> post1(
      {required Map<String, dynamic> body,
      String? url,
      bool withAuthorization = true}) async {
    try {
      if (kDebugMode) {
        log("${getHeaders(withAuthorization)}", name: 'headers');
        log("$body", name: 'body');
        print(body);
        // return;
      }
      final result = await dio.post(url ?? completeUrls,
          data: body,
          options: Options(
            headers: getHeaders(withAuthorization),
          ));
      if (kDebugMode) {
        print(classNames);
      }

      return result.data;
    }on DioError catch (e, strace) {
      if (kDebugMode) {
        log('\x1B[31m$classNames class \x1B[0m');
        print(e.toString());
        log(strace.toString());
      }
      throw e.response?.data;
    }
  }

  Future<dynamic> update1(
      {required Map<String, dynamic> body,
      String? url,
      required String id,
      String methode = 'PUT',
      bool withAuthorization = true}) async {
    try {
      switch (methode.toUpperCase()) {
        case 'PUT':
          final result = await dio.put(url ?? completeUrls + '$id/',
              options: Options(headers: getHeaders(withAuthorization)),
              data: body);
          if (kDebugMode) {
            print(classNames);
          }

          return result.data;
        case 'PATCH':
          final result = await dio.patch(url ?? completeUrls + '$id/',
              options: Options(headers: getHeaders(withAuthorization)),
              data: body);
          if (kDebugMode) {
            print(classNames);
          }

          return result.data;
        default:
          if (kDebugMode) {
            print(classNames);
          }

          return [];
      }
    }on DioError catch (e, strace) {
      if (kDebugMode) {
        print('\x1B[31m$classNames class \x1B[0m');
         print(e.toString());
        log(strace.toString());
      }
      throw e.response?.data;
    }
  }

  Future<Response<dynamic>> delete1(
      {required String id, String? url, bool withAuthorization = true}) async {
    try {
      final result = await dio.delete(
        url ?? completeUrls + '$id/',
        options: Options(headers: getHeaders(withAuthorization)),
      );
      if (kDebugMode) {
        print(classNames);
      }

      return result;
    }on DioError catch (e, strace) {
      if (kDebugMode) {
        log('\x1B[31m$classNames class \x1B[0m');
        // print(e.toString());
        log(strace.toString());
      }
      throw e.response?.data;
    }
  }
}
