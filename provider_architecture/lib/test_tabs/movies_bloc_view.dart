import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movies_bloc.dart';

class MoviesBlocView extends StatefulWidget {
  const MoviesBlocView({
    Key key,
    @required this.bloc,
    @required this.loadedBuilder,
    this.onBlocReady,
  })  : assert(bloc != null),
        assert(loadedBuilder != null),
        super(key: key);

  final MoviesBloc bloc;

  final Widget Function(BuildContext context, List<Movie> result) loadedBuilder;

  final void Function(MoviesBloc) onBlocReady;

  @override
  _MoviesBlocViewState createState() => _MoviesBlocViewState();
}

class _MoviesBlocViewState extends State<MoviesBlocView> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.onBlocReady != null && mounted) {
      widget.onBlocReady(widget.bloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoviesBloc>.value(
      value: widget.bloc,
      child: Consumer<MoviesBloc>(
        builder: (context, bloc, child) {
          switch (bloc.state) {
            case BlocState.idle:
              return Container();
            case BlocState.loading:
              return const Center(child: CircularProgressIndicator());
            case BlocState.loaded:
              return widget.loadedBuilder(context, bloc.result);
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class MoviesConsumer extends StatelessWidget {
  const MoviesConsumer({Key key, this.loadedBuilder}) : super(key: key);
  final Widget Function(BuildContext context, List<Movie> result) loadedBuilder;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesBloc>(
      builder: (context, bloc, child) {
        switch (bloc.state) {
          case BlocState.idle:
            return Container();
          case BlocState.loading:
            return const Center(child: CircularProgressIndicator());
          case BlocState.loaded:
            return loadedBuilder(context, bloc.result);
          default:
            return Container();
        }
      },
    );
  }
}
