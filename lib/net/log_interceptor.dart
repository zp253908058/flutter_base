import 'package:dio/dio.dart';

import '../../../util/log.dart';

class LogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var sb = StringBuffer();
    var request = response.requestOptions;
    sb.writeln("正确响应");
    sb.writeln("URL: ${request.method} ${request.uri}");
    sb.writeln("请求头: ${request.headers}");
    sb.writeln("请求参数: ${request.queryParameters}");
    sb.writeln("请求数据: ${request.data}");
    sb.writeln("状态码: ${response.statusCode}");
    sb.writeln("响应头: ${response.headers}");
    sb.writeln("额外信息: ${response.extra}");
    sb.writeln("响应数据: ${response.data}");
    Log.d(sb.toString());
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var request = err.requestOptions;
    var response = err.response;
    var sb = StringBuffer();
    sb.writeln("错误响应");
    sb.writeln("URL: ${request.method} ${request.uri}");
    sb.writeln("请求头: ${request.headers}");
    sb.writeln("请求参数: ${request.queryParameters}");
    sb.writeln("请求数据: ${request.data}");
    if (response == null) {
      sb.writeln("无响应");
    } else {
      sb.writeln("状态码: ${response.statusCode}");
      sb.writeln("额外信息: ${response.extra}");
      sb.writeln("错误响应数据: ${response.data}");
    }
    Log.d(sb.toString());
    handler.next(err);
  }
}
