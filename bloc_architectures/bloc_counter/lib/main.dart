import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/counter/counter_bloc.dart';
import 'blocs/counter/counter_event.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/theme/theme_event.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Bloc Counter',
            theme: theme,
            home: BlocProvider<CounterBloc>(
              builder: (_) => CounterBloc(),
              child: MyHomePage(),
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => BlocProvider.of<CounterBloc>(context)
                  .add(CounterEvent.increment),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: FloatingActionButton(
              child: Icon(Icons.update),
              onPressed: () => BlocProvider.of<CounterBloc>(context)
                  .add(CounterEvent.decrement),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: FloatingActionButton(
              child: Icon(Icons.adb),
              onPressed: () =>
                  BlocProvider.of<ThemeBloc>(context).add(ThemeEvent.toggle),
            ),
          ),
        ],
      ),
    );
  }
}
