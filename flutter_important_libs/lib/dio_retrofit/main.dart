import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'api/custom_cache_interceptor.dart';
import 'api/custom_error_interceptor.dart';
import 'api/api.dart';
import 'home_page.dart';

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

RestClient _setupClient() {
  Dio dio = Dio()
    //    ..httpClientAdapter = Http2Adapter(ConnectionManager(
//      idleTimeout: 10000,
//    ))
    ..transformer = FlutterTransformer()
    ..options.baseUrl = 'https://jsonplaceholder.typicode.com'
    ..options.headers['Content-Type'] = 'application/json'
    ..options.receiveTimeout = 5000 // 5s
    ..options.connectTimeout = 5000 // 5s
    ..interceptors.addAll([
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: false,
        error: true,
        compact: true,
        maxWidth: 90,
        logPrint: (log) => debugPrint(log),
      ),
      CacheInterceptor(),
      DioErrorInterceptor(),
    ]);

  return RestClient(dio);
}

void main() {
  runApp(
    Provider(
      builder: (_) => _setupClient(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    ),
  );
}
