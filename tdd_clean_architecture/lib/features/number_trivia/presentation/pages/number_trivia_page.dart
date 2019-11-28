import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_architecture/service_locator.dart';

import '../presentation.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider(
        builder: (context) => locator<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(message: 'Start searching');
                    }
                    if (state is Loading) {
                      return const LoadingWidget();
                    }
                    if (state is Loaded) {
                      return TriviaDisplay(trivia: state.trivia);
                    }
                    if (state is Error) {
                      return MessageDisplay(message: state.msg);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                const TriviaControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
