import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'random_stream_store.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RandomStreamStore>(builder: (_) => RandomStreamStore()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<RandomStreamStore>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Random Number', style: Theme.of(context).textTheme.title),
            Observer(
              builder: (_) {
                final value = store.randomStream.value;
                return Text(
                  '${value == null ? '---' : value}',
                  style: const TextStyle(fontSize: 48),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
