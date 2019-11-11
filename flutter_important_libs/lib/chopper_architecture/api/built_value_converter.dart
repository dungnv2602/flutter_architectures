import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';

import '../models/serializers.dart';

class BuiltValueConverter extends JsonConverter {
  @override
  Request convertRequest(Request request) {
    return super.convertRequest(
      request.replace(
        // request.body is of type dynamic, but we know that it holds only BuiltValue classes (BuiltPost).
        // Before sending the request to the network, serialize it to a List/Map using a BuiltValue serializer.
//        body: serializers.serializeWith(
//            // Since convertRequest doesn't have a type parameter, Serializer's type will be determined at runtime
//            serializers.serializerForType(request.body.runtimeType),
//            request.body),
//      ),
        body: serializers.serialize(request.body),
      ),
    );
  }

  @override
  Response<BodyType> convertResponse<BodyType, SingleItemType>(
    Response response,
  ) {
    // The response parameter contains raw binary JSON data by default.
    // Utilize the already written code which converts this data to a dynamic Map or a List of Maps.
    final Response dynamicResponse = super.convertResponse(response);
    // customBody can be either a BuiltList<SingleItemType> or just the SingleItemType (if there's no list).
    final BodyType customBody = _convertToCustomObject<SingleItemType>(dynamicResponse.body);
    // Return the original dynamicResponse with a no-longer-dynamic body type.
    return dynamicResponse.replace<BodyType>(body: customBody);
  }

  dynamic _convertToCustomObject<T>(dynamic value) {
    // If the type which the response should hold is explicitly set to a dynamic Map,
    // there's nothing we can convert.
    if (value is T) {
      return value;
    }
    // else if it's a list
    if (value is List)
      //deserialize list
      return _deserializeListOf<T>(value);
    else
      // else if it's a single map, deserialize map
      return _deserialize<T>(value);
  }

  BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList<T>(
        value.map<T>((element) => _deserialize<T>(element)).toList(growable: false),
      );

  T _deserialize<T>(dynamic value) => serializers.deserializeWith<T>(
        serializers.serializerForType(T),
        value,
      );
}