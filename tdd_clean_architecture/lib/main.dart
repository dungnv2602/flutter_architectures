import 'package:flutter/material.dart';
import 'features/number_trivia/presentation/pages/pages.dart';
import 'service_locator.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NumberTriviaPage(),
    );
  }
}