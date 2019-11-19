import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {
  int get id;
  String get title;
  String get body;

  factory Post([void Function(PostBuilder) updates]) = _$Post;

  Post._();

  static Serializer<Post> get serializer => _$postSerializer;

  static Post fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(serializer, json);

  Map<String, dynamic> toJson() => serializers.serializeWith(serializer, this);
}