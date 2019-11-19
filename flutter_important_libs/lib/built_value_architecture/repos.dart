import 'dart:convert';

import 'package:built_collection/built_collection.dart';

import 'reddit.dart';
import 'serializers.dart';

import 'package:http/http.dart' as http;

const String url = 'https://www.reddit.com/r/popular/new.json?count=25';

class ProdRedditRepos extends RedditRepos {
  @override
  Future<BuiltList<Post>> fetchReddits(http.Client client) async {
    final reponse = await client.get(url);

    final reddit = serializers.deserializeWith(Reddit.serializer, json.decode(reponse.body));

    return BuiltList<Post>(reddit.data.children.map((Data data) => data.data));
  }
}

class MockRedditRepos extends RedditRepos {
  @override
  Future<BuiltList<Post>> fetchReddits(http.Client client) {
    return null;
  }
}

abstract class RedditRepos {
  Future<BuiltList<Post>> fetchReddits(http.Client client);
}
