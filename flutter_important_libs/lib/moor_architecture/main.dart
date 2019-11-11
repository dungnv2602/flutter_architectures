//import 'package:flutter/material.dart';
//import 'moor_db.dart';
//import 'package:provider/provider.dart';
//void main()=>runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final db = AppDatabase();
//    return MultiProvider(
//      providers: [
//        Provider<TaskDao>(
//          builder: (_)=> db.taskDao,
//        ),
//        Provider<TagDao>(
//          builder: (_)=> db.tagDao,
//        ),
//      ],
//      child: MaterialApp(
//        home: HomePage(),
//      ),
//    );
//  }
//}
//
//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
