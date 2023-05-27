import 'dart:convert';

import 'package:dio/dio.dart';

import 'http_error.dart';

abstract class HttpHandler {
  Future handleResponse(Response<dynamic> response);

  Future handleError(dynamic error);
}

class DefaultHttpHandler extends HttpHandler {
  @override
  Future handleResponse(Response response) {
    return _handleResponse(response);
  }

  Future<dynamic> _handleResponse(Response<dynamic> response) {
    int statusCode = response.statusCode ?? 0;
    return switch (statusCode) {
      < 200 => Future.error(HttpError(
          statusCode == 0 ? "RESPONSE_ERROR" : "$statusCode",
          "网络链接失败\n${response.statusMessage ?? ""}",
          httpCode: statusCode)),
      >= 200 && < 300 => _handleData(response.data),
      >= 400 && < 500 => Future.error(HttpError(
          statusCode == 0 ? "RESPONSE_ERROR" : "$statusCode",
          "客户端异常\n${response.statusMessage ?? ""}",
          httpCode: statusCode)),
      >= 500 && < 600 => Future.error(HttpError(
          statusCode == 0 ? "RESPONSE_ERROR" : "$statusCode",
          "服务器异常\n${response.statusMessage ?? ""}",
          httpCode: statusCode)),
      _ => Future.error(HttpError(
          statusCode == 0 ? "RESPONSE_ERROR" : "$statusCode",
          response.statusMessage ?? "响应错误",
          httpCode: statusCode)),
    };
  }

  Future<dynamic> _handleData(dynamic data) {
    if (data == null) {
      return Future.error(HttpError("DATA_EXCEPTION", "返回数据为空"));
    }
    if (data is String) {
      if (data.isEmpty) {
        return Future.error(HttpError("DATA_EXCEPTION", "返回数据为空"));
      }
      return _decodeData(data);
    }
    if (data is Map<String, dynamic>) {
      return _decodeMap(data);
    }
    return Future.error(HttpError("DATA_TYPE_MISMATCH", "响应数据无法解析"));
  }

  Future<dynamic> _decodeData(dynamic data) {
    dynamic decodedData = jsonDecode(data);
    if (decodedData is! Map<String, dynamic>) {
      return Future.error(HttpError("DATA_EXCEPTION", "数据解析异常"));
    }
    return _decodeMap(decodedData);
  }

  Future<dynamic> _decodeMap(Map<String, dynamic> data) {
    if (data.containsKey("status")) {
      return Future.error(HttpError("${data["status"]}", "登录过期，请重新登录",
          httpCode: data["status"]));
    }
    int code = data["code"];
    if (code != 200) {
      return Future.error(HttpError("ERROR_CODE", data["msg"]));
    }
    return Future.value(data["data"]);
  }

  @override
  Future handleError(error) {
    return _handleError(error);
  }

  Future<dynamic> _handleError(dynamic error) {
    return switch (error) {
      DioError => _handleDioError(error),
      HttpError => Future.error(error),
      Error => Future.error(HttpError(
          "ERROR", error.stackTrace?.toString() ?? "程序错误",
          error: error)),
      Exception =>
        Future.error(HttpError("EXCEPTION", error.toString(), error: error)),
      _ => _defaultError(error),
    };
  }

  Future<dynamic> _handleDioError(DioError error) {
    DioErrorType type = error.type;
    return switch (type) {
      DioErrorType.connectionTimeout =>
        Future.error(HttpError("CONNECT_TIMEOUT", "连接超时", error: error)),
      DioErrorType.sendTimeout =>
        Future.error(HttpError("SEND_TIMEOUT", "发送超时", error: error)),
      DioErrorType.receiveTimeout =>
        Future.error(HttpError("RECEIVE_TIMEOUT", "接收超时", error: error)),
      DioErrorType.badResponse => _handBadResponse(error),
      DioErrorType.cancel =>
        Future.error(HttpError("CANCEL", "请求取消", error: error)),
      DioErrorType.unknown || _ => Future.error(HttpError("UNKNOWN_ERROR",
          error.message ?? "${error.error ?? error.stackTrace}",
          error: error)),
    };
  }

  Future<dynamic> _handBadResponse(DioError error) {
    Response? response = error.response;
    if (response == null) {
      return Future.error(
        HttpError("RESPONSE_ERROR", "请求无响应", error: error),
      );
    }
    dynamic data = response.data;
    if (data == null) {
      return Future.error(
        HttpError("RESPONSE_ERROR", "请求响应为空", error: error),
      );
    }
    if (data is Map) {
      return Future.error(
          HttpError(data["code"], data["message"], error: error));
    }
    if (data is String) {
      dynamic jsonData = json.decode(data);
      if (jsonData is Map) {
        return Future.error(
            HttpError(jsonData["code"], jsonData["message"], error: error));
      } else {
        return Future.error(
            HttpError("BAD_RESPONSE", "请求失败，请检查后再试", error: error));
      }
    }
    return Future.error(
        HttpError("DATA_TYPE_MISMATCH", "响应数据无法解析", error: error));
  }

  Future<dynamic> _defaultError(dynamic error) {
    return Future.error(HttpError("OTHER_ERROR", error, error: error));
  }
}
