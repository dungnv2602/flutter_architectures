import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_architecture/features/number_trivia/presentation/bloc/bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({Key key}) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: const Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: getConcreteTrivia,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: const Text('Get random trivia'),
                onPressed: getRandomTrivia,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void getConcreteTrivia() {
    BlocProvider.of<NumberTriviaBloc>(context).add(
        NumberTriviaEvent.getConcreteNumber(numberString: controller.text));
    clearTextController();
  }

  void getRandomTrivia() {
    BlocProvider.of<NumberTriviaBloc>(context).add(NumberTriviaEvent.getRandomNumber());
    clearTextController();
  }

  void clearTextController() {
    controller.clear();
  }
}
