import 'package:flutter/foundation.dart';

import '../core/models/comment.dart';
import '../core/services/api.dart';
import 'base_notifier.dart';

class CommentsNotifier extends BaseNotifier {
  Api _api;

  List<Comment> comments;
  
  CommentsNotifier({@required Api api}) : _api = api;

  Future<void> fetchComments(int postId) async {
    busy(true);
    comments = await _api.getCommentsForPost(postId);
    busy(false);
  }
}
