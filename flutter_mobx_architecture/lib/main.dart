import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'advanced/hacker_news/app.dart';

/// flutter packages pub run build_runner watch --delete-conflicting-outputs
void main() async {
  final ref = await SharedPreferences.getInstance();
  runApp(App());
}
