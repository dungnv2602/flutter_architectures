import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_timer/bloc/bloc.dart';

class MyActionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///ignore: close_sinks, https://github.com/felangel/bloc/issues/587
    final bloc = BlocProvider.of<TimerBloc>(context);
    final currentState = bloc.state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (currentState is Ready) ...[
          FloatingActionButton(
            child: Icon(Icons.play_arrow),
            onPressed: () => bloc.add(
              Start(duration: currentState.duration),
            ),
          ),
        ],
        if (currentState is Running) ...[
          FloatingActionButton(
            child: Icon(Icons.pause),
            onPressed: () => bloc.add(
              Pause(),
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.replay),
            onPressed: () => bloc.add(
              Reset(),
            ),
          ),
        ],
        if (currentState is Paused) ...[
          FloatingActionButton(
            child: Icon(Icons.play_arrow),
            onPressed: () => bloc.add(
              Resume(),
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.replay),
            onPressed: () => bloc.add(
              Reset(),
            ),
          ),
        ],
        if (currentState is Finished) ...[
          FloatingActionButton(
            child: Icon(Icons.replay),
            onPressed: () => bloc.add(
              Reset(),
            ),
          ),
        ],
      ],
    );
  }
}
