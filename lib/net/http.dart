import 'dart:io';

import '../net/token_interceptor.dart';
import 'package:dio/dio.dart';

import 'http_config.dart';
import 'http_handler.dart';
import 'network_interceptor.dart';

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  late Dio _dio;

  HttpHandler httpHandler = DefaultHttpHandler();

  ///通用全局单例，第一次使用时初始化
  Http._internal() {
    _setup(HttpConfig.baseUrl);
  }

  void _setup(String baseUrl) {
    var options = BaseOptions(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: const Duration(seconds: HttpConfig.connectTimeout),
      receiveTimeout: const Duration(seconds: HttpConfig.receiveTimeout),
      sendTimeout: const Duration(seconds: HttpConfig.sendTimeout),
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8",
      },
    );
    Dio dio = Dio(options);
    dio.interceptors;
    dio.interceptors.add(NetworkInterceptor());
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(LogInterceptor());
    _dio = dio;
  }

  void resetBaseUrl(String baseUrl) {
    _setup(baseUrl);
  }

  ///close
  void close({bool force = false}) {
    _dio.close(force: force);
  }

  ///delete
  Future<dynamic> delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) {
    return _dio
        .delete(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  ///delete
  Future<dynamic> deleteUri(Uri uri,
      {data, Options? options, CancelToken? cancelToken}) {
    return _dio
        .deleteUri(uri, data: data, options: options, cancelToken: cancelToken)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> download(String urlPath, savePath,
      {ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options}) {
    return _dio.download(urlPath, savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: Headers.contentLengthHeader,
        data: data,
        options: options);
  }

  Future<Response> downloadUri(Uri uri, savePath,
      {ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options}) {
    return _dio.downloadUri(uri, savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: Headers.contentLengthHeader,
        data: data,
        options: options);
  }

  Future<Response> fetch(RequestOptions requestOptions) {
    return _dio.fetch(requestOptions);
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .get(path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> getUri(Uri uri,
      {Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .getUri(uri,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<Response> head(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) {
    return _dio.head(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
  }

  Future<Response> headUri(Uri uri,
      {data, Options? options, CancelToken? cancelToken}) {
    return _dio.headUri(uri,
        data: data, options: options, cancelToken: cancelToken);
  }

  Future<dynamic> patch(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .patch(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> patchUri(Uri uri,
      {data,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .patchUri(uri,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .post(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> postUri(Uri uri,
      {data,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .postUri(uri,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .put(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> putUri(Uri uri,
      {data,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .putUri(uri,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> request(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .request(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> requestUri(Uri uri,
      {data,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio
        .requestUri(uri,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((value) {
      return _handleResponse(value);
    }).catchError((e) {
      return _handleError(e);
    });
  }

  Future<dynamic> _handleResponse(Response<dynamic> value) =>
      httpHandler.handleResponse(value);

  Future<dynamic> _handleError(e) => httpHandler.handleError(e);
}
