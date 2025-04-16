import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';

class ApiClient {
  final Dio _dio;
  final GlobalStorage _hive;

  ApiClient(
    this._dio,
    this._hive,
  ) {
    _dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseURL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('➡️ Request: ${options.method} ${options.uri}');
            print('🔑 Headers: ${options.headers}');
            print('📂 Data: ${options.data}');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('⬅️ Status code: ${response.statusCode}');
            print('📂 Data: ${response.data}');
          }

          return handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            print('❌ Error: ${error.response?.statusCode}');
            print('📂 Data: ${error.response?.data}');
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> request({
    required String endpoint,
    required ApiMethods method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    bool useJWT = false,
    CancelToken? cancelToken,
  }) async {
    Response response;
    headers ??= {};

    String? accessToken = _hive.accessToken;
    String bearerJWT = 'Bearer $accessToken';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${dotenv.env['WOO_CONSUMER_KEY']}:${dotenv.env['WOO_CONSUMER_SECRET']}'))}';

    if (useJWT) {
      if (accessToken != null) {
        headers['Authorization'] = bearerJWT;
      }
    } else {
      headers['Authorization'] = basicAuth;
    }

    Options options = Options(headers: headers);

    switch (method) {
      case ApiMethods.get:
        response = await _dio.get(
          endpoint,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        break;
      case ApiMethods.post:
        response = await _dio.post(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        break;
      case ApiMethods.put:
        response = await _dio.put(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        break;
      case ApiMethods.patch:
        response = await _dio.patch(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        break;
      case ApiMethods.delete:
        response = await _dio.delete(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        break;
    }

    return response.data;
  }
}
