import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider/posts_notifier.dart';
import 'package:provider_architecture/ui/routing/global_navigator.dart';
import 'package:provider_architecture/ui/routing/router.dart';

import '../../core/models/post.dart';
import '../../core/models/user.dart';
import 'base_view.dart';

class PostsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PostsNotifier>(
      notifier: PostsNotifier(api: Provider.of(context)),
      onNotifierReady: (notifier) =>
          notifier.getPosts(Provider.of<User>(context)?.id),
      consumerBuilder: (context, notifier, child) {
        return notifier.isBusy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: notifier.posts.length,
                itemBuilder: (context, index) {
                  final post = notifier.posts[index];
                  return PostListItem(
                    notifier: notifier,
                    post: post,
                    onTap: () {
                      return pushNamed(route: RoutePaths.post, arguments: post);
                    },
                  );
                },
              );
      },
    );
  }
}

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;
  final PostsNotifier notifier;

  const PostListItem({
    this.post,
    this.onTap,
    this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
            ),
            Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
            FlatButton(
              color: Colors.white,
              child: const Text(
                'Show Dialog',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await notifier.showDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
