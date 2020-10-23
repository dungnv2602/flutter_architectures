import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movies_bloc.dart';
import 'movies_bloc_view.dart';

List<Genre> genres = List.generate(
    20, (index) => Genre(id: index + 1, name: (index + 1).toString()));

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
                .map(
                  (genre) => ChangeNotifierProvider<MoviesBloc>(
                    create: (context) =>
                        MoviesBloc()..getMoviesWithGenre(genre),
                    child: MoviesConsumer(
                      loadedBuilder: (context, movies) => MoviesView(
                        movies: movies,
                        genre: genre,
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class MoviesView extends StatefulWidget {
  const MoviesView({
    Key key,
    @required this.movies,
    @required this.genre,
  })  : assert(movies != null),
        assert(genre != null),
        super(key: key);

  final List<Movie> movies;
  final Genre genre;

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.movies.length,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text('Movie: ${widget.movies[index].name}'),
          trailing: Text('Genre: ${widget.genre.name}'),
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
