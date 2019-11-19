import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_timer/bloc/bloc.dart';

import 'actions_widget.dart';

class MyTimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Timer')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0),
            child: Center(
              child: BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  final String minutesStr = ((state.duration / 60) % 60)
                      .floor()
                      .toString()
                      .padLeft(2, '0');
                  final String secondsStr =
                      (state.duration % 60).floor().toString().padLeft(2, '0');
                  return Text(
                    '$minutesStr:$secondsStr',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          BlocBuilder<TimerBloc, TimerState>(
            condition: (prevState, currState) =>
                currState.runtimeType != prevState.runtimeType,
            builder: (context, state) => MyActionsWidget(),
          )
        ],
      ),
    );
  }
}
