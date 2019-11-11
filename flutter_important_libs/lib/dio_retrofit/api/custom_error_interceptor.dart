import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err) async {
    final msg = _errorInterceptor(err);
    debugPrint(msg);
    return err;
  }

  String _errorInterceptor(DioError error) {
    String errorDescription = "";
    switch (error.type) {
      case DioErrorType.DEFAULT:
        errorDescription = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
            "Received invalid status code: ${error.response.statusCode} - Message: ${error.response.data}";
        break;
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
    }
    return errorDescription;
  }
}
