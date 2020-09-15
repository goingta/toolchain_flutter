import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toolchain_flutter/common/global.dart';

class Server<T> {
  String baseUrl;

  static const SEND_TIME_OUT = 30000;
  static const RECEIVE_TIME_OUT = 30000;

  static Dio _dio;

  static Dio getDioInstance() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          sendTimeout: SEND_TIME_OUT,
          receiveTimeout: RECEIVE_TIME_OUT,
        ),
      );
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print("请求开始 ${options.uri}");
        },
        onResponse: (Response response) {
          print("返回数据 $response");
        },
        onError: (DioError e) {
          print("发生错误 $e");
        },
      ));
    }
    return _dio;
  }

  Server() {
    switch (Global.env) {
      case "dev":
        baseUrl = 'http://toolchain.developer.doctorwork.com/';
        break;
      case "qa":
        baseUrl = 'http://toolchain.qa.doctorwork.com/';
        break;
      case "pre":
        baseUrl = 'http://toolchain.pre.doctorwork.com/';
        break;
      case "prd":
        baseUrl = 'http://toolchain.doctorwork.com/';
        break;
    }
  }

  /// 不直接调用，可以子类复写
  @protected
  Future<T> request(String requestMethod, String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> data,
      FormData formData}) async {
    assert(baseUrl != null, 'baseUrl不能为空');
    Dio dio = getDioInstance();
    String requestUrl = baseUrl + path;
    try {
      Response response = await dio.request(
        requestUrl,
        queryParameters: queryParameters,
        data: data == null ? formData : data,
        options: Options(
          method: requestMethod,
          headers: headers,
        ),
      );
      return response.data;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<T> get(
    String path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) async {
    return request(
      "GET",
      path,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<T> post(String path,
      {Map<String, dynamic> data,
      Map<String, dynamic> formData,
      Map<String, dynamic> headers}) async {
    return request(
      "POST",
      path,
      data: data,
      formData: FormData.fromMap(formData),
      headers: headers,
    );
  }
}
