import 'package:dio/dio.dart';

import 'http_config.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    bool needToken = HttpConfig.token.isNotEmpty;
    if (needToken) {
      Map<String, dynamic> headers = options.headers;
      headers["token"] = HttpConfig.token;
    }
    handler.next(options);
  }
}
