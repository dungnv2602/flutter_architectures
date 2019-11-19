import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'models/post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<PostBloc>(
          builder: (_) => PostBloc(httpClient: http.Client())..add(Fetch()),
          child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();

  final _scrollThreshold = 200;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostUninitialized) {
          return MyLoader();
        }
        if (state is PostError) {
          return Center(
            child: Text(state.msg),
          );
        }
        if (state is PostLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('No Posts'),
            );
          }

          return ListView.builder(
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            itemBuilder: (_, index) {
              return index >= state.posts.length
                  ? MyLoader()
                  : PostWidget(post: state.posts[index]);
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold)
      BlocProvider.of<PostBloc>(context).add(Fetch());
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post})
      : assert(post != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${post.id}'),
      title: Text(post.title),
      subtitle: Text(post.body),
      isThreeLine: true,
      dense: true,
    );
  }
}

class MyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
        ),
        width: 33,
        height: 33,
      ),
    );
  }
}
