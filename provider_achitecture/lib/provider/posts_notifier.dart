import 'package:flutter/foundation.dart';
import 'package:provider_arc/core/services/dialog_service.dart';
import 'package:provider_arc/locator.dart';

import '../core/models/post.dart';
import '../core/services/api.dart';
import 'base_notifier.dart';

class PostsNotifier extends BaseNotifier {
  Api _api;
  final _dialogService = locator<DialogService>();

  PostsNotifier({@required Api api}) : _api = api;

  List<Post> posts;

  Future<void> getPosts(int userId) async {
    busy(true);
    posts = await _api.getPostsForUser(userId);
    busy(false);
  }

  Future<void> showDialog() async {
    print('dialog called');
    var dialogResult = await _dialogService.showDialog(
      title: 'Custom Title',
      description: 'FilledStacks architecture rocks',
    );
    if (dialogResult.confirmed) {
      print('User has confirmed');
    } else {
      print('User cancelled the dialog');
    }
  }
}
