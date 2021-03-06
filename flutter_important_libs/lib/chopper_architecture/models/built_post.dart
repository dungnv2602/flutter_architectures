import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'built_post.g.dart';

abstract class BuiltPost implements Built<BuiltPost, BuiltPostBuilder> {
  // IDs are set in the back-end.
  // In a POST request, BuiltPost's ID will be null.
  // Only BuiltPosts obtained through a GET request will have an ID.
  @nullable
  int get id;

  String get title;

  String get body;

  BuiltPost._();

  factory BuiltPost([void Function(BuiltPostBuilder) updates]) = _$BuiltPost;

  static Serializer<BuiltPost> get serializer => _$builtPostSerializer;

  static BuiltPost fromJson(Map<String, dynamic> json) => serializers.deserializeWith(BuiltPost.serializer, json);

  String toJson() => json.encode(serializers.serializeWith(BuiltPost.serializer, this));
}
