import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'api/api.dart';
import 'home_page.dart';

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

ChopperClient _chopperClient = ChopperClient(
  // The first part of the URL is now here
  baseUrl: 'https://jsonplaceholder.typicode.com',
  services: [
    // The generated implementation
    PostApiService.instance(),
  ],
  // Converts data using BuiltValueConverter instead of standard json.
  converter: BuiltValueConverter(),
  interceptors: <dynamic>[
    // header interceptor
    HeadersInterceptor({'Cache-Control': 'no-cache'}),
    // useful for logging
    HttpLoggingInterceptor(),
    // mobile sensitive interceptor
    MobileDataInterceptor(),
    (Request request) async {
      chopperLogger.info('Performed a ${request.method} request');
      return request;
    },
    (Response response) async {
      if (response.statusCode != 200) {
        chopperLogger.severe('Request gone wrong with status: ${response.statusCode}');
      }
      return response;
    }
  ],
);

void main() {
  _setupLogging();
  runApp(
    Provider<PostApiService>(
      builder: (_) => _chopperClient.getService<PostApiService>(),
      dispose: (_, __) => _chopperClient.dispose(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    ),
  );
}
