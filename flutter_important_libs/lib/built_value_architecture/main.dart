import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;

import 'injector.dart';
import 'reddit.dart';

void main() {
  Injector.config(RepoType.PROD);
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  })  : injector = Injector(),
        super(key: key);
  final Injector injector;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuiltList<Post> _posts = BuiltList<Post>([]);
  final client = Client();

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final posts = await widget.injector.redditRepo.fetchReddits(client);
    setState(() {
      _posts = posts;
    });
  }

  List<Widget> buildListTiles() {
    return _posts
        .map((post) => ListTile(
              leading: Container(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: post.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text('Title: ${post.title} by ${post.author}'),
              subtitle: Text(
                'Subreddit: ${post.subreddit} with ${post.ups} upvotes',
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _fetch,
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 2000),
          firstChild: const Center(
            child: CircularProgressIndicator(),
          ),
          secondChild: ListView(
            shrinkWrap: true,
            children: buildListTiles(),
          ),
          crossFadeState: _posts.isNotEmpty ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }
}
