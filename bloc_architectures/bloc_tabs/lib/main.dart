import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_bloc/blocs.dart';

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
                title: const Text('Bloc'),
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
            children: genres.map((genre) {
              return BlocProvider<MoviesBloc>(
                create: (_) => MoviesBloc(),
                child: GenreView(
                  genre: genre,
                ),
              );
            }).toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class GenreView extends StatefulWidget {
  final Genre genre;

  const GenreView({Key key, this.genre}) : super(key: key);
  @override
  _GenreViewState createState() => _GenreViewState();
}

class _GenreViewState extends State<GenreView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context)
        .add(MoviesEvent.fetchMoviesByGenre(widget.genre));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        return state.map(
          idle: (_) => Center(child: CircularProgressIndicator()),
          loading: (_) => Center(child: CircularProgressIndicator()),
          error: (error) => Text(
            error.msg,
            style: TextStyle(color: Colors.red),
          ),
          loaded: (loaded) {
            final movies = loaded.movies;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: movies.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(movies[index].name),
                  trailing: Text(movies[index].genre.id.toString()),
                );
              },
            );
          },
        );
      },
    );
  }
}

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: genres
              .map(
                (genre) => BlocProvider<MoviesBloc>(
                  create: (_) => MoviesBloc()..add(FetchMoviesByGenre(genre)),
                  child: BlocBuilder<MoviesBloc, MoviesState>(
                    builder: (context, state) {
                      return state.map(
                        idle: (_) => Center(child: CircularProgressIndicator()),
                        loading: (_) =>
                            Center(child: CircularProgressIndicator()),
                        error: (error) => Text(
                          error.msg,
                          style: TextStyle(color: Colors.red),
                        ),
                        loaded: (loaded) {
                          final movies = loaded.movies;
                          return SizedBox.fromSize(
                            size: Size.fromHeight(100),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return BlocProvider<MoviesBloc>.value(
                                    value: BlocProvider.of<MoviesBloc>(context),
                                    child: MoviesView(),
                                  );
                                }));
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                scrollDirection: Axis.horizontal,
                                itemCount: movies.length,
                                itemBuilder: (_, index) {
                                  return Text('${movies[index].name}');
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }
}

class MoviesView extends StatelessWidget {
  final List<Movie> movies;

  const MoviesView({Key key, this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          return state.map(
            idle: (_) => Center(child: CircularProgressIndicator()),
            loading: (_) => Center(child: CircularProgressIndicator()),
            error: (error) => Text(
              error.msg,
              style: TextStyle(color: Colors.red),
            ),
            loaded: (loaded) {
              final movies = loaded.movies;
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<MoviesBloc>(context)
                      .add(FetchMoviesByGenre(movies[0].genre));
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: movies.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(movies[index].name),
                      trailing: Text(movies[index].genre.id.toString()),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
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
      home: HomePage2(),
    );
  }
}
