import 'package:flutter/foundation.dart';

class HttpConfig {
  ///超时配置，单位:秒
  static const int connectTimeout = 15 * 60;
  static const int receiveTimeout = 15 * 60;
  static const int sendTimeout = 15 * 60;

  ///base url
  static const String testUrl = "http://192.168.1.1:8080/";
  static const String prodUrl = "https://192.168.1.1:8080/";

  static const String baseUrl = kDebugMode ? testUrl : prodUrl;
  static String token = "";
}
