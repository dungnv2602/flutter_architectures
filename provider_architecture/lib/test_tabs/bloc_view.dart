import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

class BlocView<T> extends StatefulWidget {
  const BlocView({
    Key key,
    @required this.bloc,
    this.onBlocReady,
    @required this.loadedBuilder,
  })  : assert(bloc != null),
        assert(loadedBuilder != null),
        super(key: key);

  final Bloc<T> bloc;

  final BlocFuncion<T> onBlocReady;

  final Widget Function(BuildContext context, T result) loadedBuilder;

  @override
  _BlocViewState createState() => _BlocViewState();
}

class _BlocViewState<T> extends State<BlocView<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.onBlocReady != null) {
      
      widget.bloc.invokeFunction(widget.onBlocReady);
    }
  }

  @override
  void dispose() {
    print('BlocView disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Bloc<T>>(
      create: (_) => widget.bloc,
      child: Consumer<Bloc<T>>(
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
