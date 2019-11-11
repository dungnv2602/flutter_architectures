import '../api/api.dart';
import '../storage_service/storage_service.dart';

class PostService {
  final Api _api;
  final StorageService _storageService;

  PostService({
    Api api,
    StorageService storageService,
  })  : _api = api,
        _storageService = storageService;

  Future<bool> likePost(int postId) async {
    final postLiked = await _api.likePost(postId);
    if (postLiked) {
      // update local like
      await _storageService.likePost(postId);
    }
    return postLiked;
  }
}
