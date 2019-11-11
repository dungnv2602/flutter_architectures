import 'dart:async';

import '../services_utils.dart';
import 'storage_service.dart';

class FakeStorageService implements StorageService {
  final StreamController<int> _postUpdated = StreamController<int>.broadcast();

  @override
  Stream<int> get postUpdateStream => _postUpdated.stream;

  @override
  Future<bool> likePost(int postId, {bool unlike = false}) async {
    await fakeDelay();
    if (postId == 1) {
      _postUpdated.add(postId);
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _postUpdated.close();
  }
}
