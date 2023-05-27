import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor {
  final Connectivity _connectivity = Connectivity();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
        handler.next(options);
        break;
      case ConnectivityResult.none:
      default:
        DioError error = DioError(
          requestOptions: options,
          type: DioErrorType.unknown,
          message: "无网络连接",
        );
        handler.reject(error);
    }
  }
}
