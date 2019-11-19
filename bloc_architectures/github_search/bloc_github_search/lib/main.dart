import 'package:common_github_search/common_github_search.dart';
import 'package:flutter/material.dart';

import 'search_form.dart';

void main() {
  final repo = GithubRepository(
    GithubCache(),
    GithubClient(),
  );
  runApp(MyApp(githubRepo: repo));
}

class MyApp extends StatelessWidget {
  final GithubRepository githubRepo;

  const MyApp({
    Key key,
    @required this.githubRepo,
  })  : assert(githubRepo != null),
        super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchForm(),
    );
  }
}
