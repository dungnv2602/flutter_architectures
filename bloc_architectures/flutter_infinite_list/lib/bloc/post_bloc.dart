import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_infinite_list/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;
  PostBloc({@required this.httpClient}) : assert(httpClient != null);

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    final currentState = state;

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        final posts = await _fetchPosts(0, 20);

        if (currentState is PostUninitialized) {
          yield PostLoaded(posts: posts);
        }
        if (currentState is PostLoaded) {
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (error) {
        yield PostError(error.toString());
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<BuiltList<Post>> _fetchPosts(int startIndex, int limit) async {
    final url =
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit';

    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List;
      return BuiltList<Post>(list.map((post) => Post.fromJson(post)));
    } else {
      throw Exception(response.body.toString());
    }
  }

  @override
  Stream<PostState> transformEvents(Stream<PostEvent> events,
      Stream<PostState> Function(PostEvent event) next) {
    return super.transformEvents(
        (events as Observable<PostEvent>)
            .debounceTime(const Duration(milliseconds: 500)),
        next);
  }
}
