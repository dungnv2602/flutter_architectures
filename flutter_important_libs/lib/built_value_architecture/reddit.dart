import 'package:built_value/serializer.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'reddit.g.dart';

abstract class Reddit implements Built<Reddit, RedditBuilder> {
  Children get data;

  Reddit._();

  factory Reddit([void Function(RedditBuilder) updates]) = _$Reddit;

  static Serializer<Reddit> get serializer => _$redditSerializer;
}

abstract class Children implements Built<Children, ChildrenBuilder> {
  BuiltList<Data> get children;

  Children._();

  factory Children([void Function(ChildrenBuilder) updates]) = _$Children;

  static Serializer<Children> get serializer => _$childrenSerializer;
}

abstract class Data implements Built<Data, DataBuilder> {
  Post get data;

  Data._();

  factory Data([void Function(DataBuilder) updates]) = _$Data;

  static Serializer<Data> get serializer => _$dataSerializer;
}

abstract class Post implements Built<Post, PostBuilder> {
  String get id;
  String get author;
  String get url;
  String get title;
  String get thumbnail;
  String get subreddit;
  int get ups;

//  VehicleType get type;

  Post._();

  factory Post([void Function(PostBuilder) updates]) = _$Post;

  static Serializer<Post> get serializer => _$postSerializer;
}

class VehicleType extends EnumClass {
  static const VehicleType car = _$car;
  static const VehicleType motorbike = _$motorbike;
  static const VehicleType train = _$train;
  static const VehicleType plane = _$plane;

  const VehicleType._(String name) : super(name);

  static BuiltSet<VehicleType> get values => _$values;
  static VehicleType valueOf(String name) => _$valueOf(name);

  static Serializer<VehicleType> get serializer => _$vehicleTypeSerializer;
}

//String toJson() {
//  return json
//      .encode(serializers.serializeWith(BuiltVehicle.serializer, this));
//}
//
//static BuiltVehicle fromJson(String jsonString) {
//return serializers.deserializeWith(
//BuiltVehicle.serializer, json.decode(jsonString));
//}
