import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/post_api_service.dart';
import 'models/built_post.dart';

class DetailPage extends StatelessWidget {
  final int postId;

  const DetailPage({Key key, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chopper Blog'),
      ),
      body: FutureBuilder<Response<BuiltPost>>(
        future: Provider.of<PostApiService>(context, listen: false).getPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final response = snapshot.data;
            if (response.isSuccessful) {
              // successful request
              final post = snapshot.data.body;
              return _buildPost(post);
            } else {
              // error from server
              final code = response.statusCode;
              final error = response.error;
              return Center(
                child: Text(
                  '$code - ${error.toString()}',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Padding _buildPost(BuiltPost post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            post.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(post.body),
        ],
      ),
    );
  }
}
