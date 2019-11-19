import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'post.dart';

part 'serializers.g.dart';

@SerializersFor([Post])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
