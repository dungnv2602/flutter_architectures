import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/core/models/post.dart';
import 'package:provider_architecture/provider/comments_notifier.dart';
import 'package:provider_architecture/ui/shared/app_colors.dart';

import '../../core/models/comment.dart';
import '../../core/models/user.dart';
import '../shared/text_styles.dart';
import '../shared/ui_helpers.dart';
import 'base_view.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge,
            Text(post.title, style: headerStyle),
            Text(
              'by ${Provider.of<User>(context).name}',
              style: TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium,
            Text(post.body),
            CommentsView(post.id)
          ],
        ),
      ),
    );
  }
}

class CommentsView extends StatelessWidget {
  final int postId;

  CommentsView(this.postId);

  @override
  Widget build(BuildContext context) {
    return BaseView<CommentsNotifier>(
      notifier: CommentsNotifier(api: Provider.of(context)),
      onNotifierReady: (notifier) => notifier.fetchComments(postId),
      consumerBuilder: (context, notifier, child) {
        return notifier.isBusy
            ? Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                    itemCount: notifier.comments.length,
                    itemBuilder: (context, index) {
                      return CommentView(notifier.comments[index]);
                    }),
              );
      },
    );
  }
}

/// Renders a single comment given a comment model
class CommentView extends StatelessWidget {
  final Comment comment;

  const CommentView(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: commentColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          UIHelper.verticalSpaceSmall,
          Text(comment.body),
        ],
      ),
    );
  }
}
