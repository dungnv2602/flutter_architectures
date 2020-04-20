import 'package:flutter/material.dart';

import 'bloc.dart';
import 'bloc_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: genres.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text('Provider'),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: genres
                      .map((genre) => Tab(child: Text(genre.name)))
                      .toList(growable: false),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: genres
                .map((genre) => BlocView<List<Movie>>(
                      bloc: Bloc<List<Movie>>(),
                      onBlocReady: mockMovie,
                      loadedBuilder: (_, genres) {
                        return GenreView(
                          genre: genre,
                        );
                      },
                    ))
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class GenreView extends StatefulWidget {
  const GenreView({
    Key key,
    @required this.genre,
  })  : assert(genre != null),
        super(key: key);

  final Genre genre;

  @override
  _GenreViewState createState() => _GenreViewState();
}

class _GenreViewState extends State<GenreView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin
    return ListView.builder(
      shrinkWrap: true,
      itemCount: genres.length,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(genres[index].name),
        );
      },
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
