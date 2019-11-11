import 'package:flutter_flavors_architecture/services/api/api.dart';
import 'package:flutter_flavors_architecture/services/post_service/post_service.dart';
import 'package:flutter_flavors_architecture/services/storage_service/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStorageService extends Mock implements StorageService {}

class MockApi extends Mock implements Api {}

void main() {
  group('PostService Test | ', () {
    test('Constructing Service should find correct dependencies', () {
      var postService = PostService();
      expect(postService != null, true);
    });

    test('Given postId=1, should call StorageService with postId=1', () async {
      var mockStorageService = MockStorageService();

      var mockApi = MockApi();
      when(mockApi.likePost(1)).thenAnswer((_) => Future.value(true));

      var postService = PostService(api: mockApi, storageService: mockStorageService);
      await postService.likePost(1);
      verify(mockStorageService.likePost(1));
    });
  });
}
