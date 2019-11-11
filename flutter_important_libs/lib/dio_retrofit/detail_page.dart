import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architectures/chopper_architecture/models/models.dart';
import 'package:provider/provider.dart';
import 'api/api.dart';

class DetailPage extends StatelessWidget {
  final int postId;

  const DetailPage({Key key, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chopper Blog'),
      ),
      body: FutureBuilder<BuiltPost>(
        future: Provider.of<RestClient>(context, listen: false).getPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                ),
              );
            }
            final post = snapshot.data;
            return _buildPost(post);
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
