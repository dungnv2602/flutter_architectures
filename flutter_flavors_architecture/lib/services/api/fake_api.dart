import '../services_utils.dart';
import 'api.dart';

class FakeApi implements Api {
  @override
  Future<bool> likePost(int postId) async {
    await fakeDelay();
    if (postId == 1) {
      return true;
    }
    return false;
  }
}
