import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/models/post.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

class PostUninitialized extends PostState {}

class PostError extends PostState {
  final String msg;

  const PostError(this.msg);

  @override
  List<Object> get props => [msg];
}

class PostLoaded extends PostState {
  final BuiltList<Post> posts;
  final bool hasReachedMax;

  const PostLoaded({@required this.posts, this.hasReachedMax = false})
      : assert(posts != null);

  PostLoaded copyWith({posts, hasReachedMax}) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
