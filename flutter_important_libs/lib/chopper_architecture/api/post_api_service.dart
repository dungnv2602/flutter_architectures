import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';

import '../models/built_post.dart';
import 'built_value_converter.dart';
import 'mobile_data_interceptor.dart';

part 'post_api_service.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  // helper methods that help you create your service
  static PostApiService instance([ChopperClient client]) => _$PostApiService(client);

  // helper methods that help you create your service
  static PostApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        // The generated implementation
        _$PostApiService(),
      ],
      // Converts data using BuiltValueConverter instead of standard json.
      converter: BuiltValueConverter(),
      interceptors: <dynamic>[
        // header interceptor
        HeadersInterceptor({'Cache-Control': 'no-cache'}),
        // useful for logging
        HttpLoggingInterceptor(),
        // mobile sensitive interceptor
        MobileDataInterceptor(),
        (Request request) async {
          chopperLogger.info('Performed a ${request.method} request');
          return request;
        },
        (Response response) async {
          if (response.statusCode != 200) {
            chopperLogger.severe('Request gone wrong with status: ${response.statusCode}');
          }
          return response;
        }
      ],
    );

    // The generated class with the ChopperClient passed in
    return _$PostApiService(client);
  }

  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '/{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );
}
