import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;
  LoggingInterceptor? loggingInterceptor = LoggingInterceptor();

  Dio dio = Dio();
  String tokens = "";

  getHeaders(bool withAuthorization) {
    Map<String, String> header = {
      //'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (withAuthorization) {
      // add to header the authorisations flags*
      header["Authorization"] = 'Bearer $tokens';
    }
    return header;
  }

  DioClient(this.baseUrl, this.tokens) {
    //token = sharedPreferences.getString(AppConstants.TOKEN);
    //print(token);
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 3)
      ..httpClientAdapter;

    dio.interceptors.add(loggingInterceptor!);
  }

  Future<Response> get(
    String uri,
    bool withAuthorization, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(headers: getHeaders(withAuthorization)),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    bool withAuthorization = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: getHeaders(withAuthorization)),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    bool withAuthorization = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: getHeaders(withAuthorization)),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    bool withAuthorization = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: getHeaders(withAuthorization)),
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  getHeaders2() {
    Map<String, String> header = {
      'Accept': 'application/json',
      "Authorization": 'Bearer $tokens',
      'Content-Type': 'multipart/form-data'
    };
    return header;
  }

  Future<dynamic> postFile({required FormData body, String url = ''}) async {
    Response result;
    try {
      result = await dio.post(url,
          data: body,
          options: Options(
            headers: getHeaders2(),
          ));
      return result;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response?.data.toString());

        print(url);
      }
      return null;
    }
  }
}
