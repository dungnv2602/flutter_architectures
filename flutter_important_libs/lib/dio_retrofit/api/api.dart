import 'package:dio/dio.dart';
import 'package:flutter_architectures/chopper_architecture/models/models.dart';
import 'package:retrofit/retrofit.dart';
part 'api.g.dart';

//@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
@RestApi(baseUrl: '/posts')
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('')
  Future<List<BuiltPost>> getPosts();

  @POST('')
  Future<BuiltPost> postPost(
    @Body() BuiltPost body,
  );

  @GET('/{id}')
  
  Future<BuiltPost> getPost(@Path('id') int id);
}
