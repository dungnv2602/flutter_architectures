import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class MobileDataInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityRs = await Connectivity().checkConnectivity();

    final isMobileData = connectivityRs == ConnectivityResult.mobile;
    final isLargefile = request.url.contains(RegExp(r'(/large|/video|/posts)'));

    if (isMobileData && isLargefile) throw MobileDataException();

    return request;
  }
}

class MobileDataException implements Exception {
  final msg = 'Downloading large files on a mobile data connection may incur costs';

  @override
  String toString() {
    return msg;
  }
}
