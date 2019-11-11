import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'multi_counter_store.dart';

/// Put inside Provider to easily make it global accessed
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MultiCounterStore>(builder: (_) => MultiCounterStore()),
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
    final multiCounterStore = Provider.of<MultiCounterStore>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Observer(
        builder: (_) {
          return Column(
            children: <Widget>[
              RaisedButton(
                onPressed: multiCounterStore.addCounter,
                child: const Text('Add Counter'),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: multiCounterStore.counters.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CounterPage(counter: multiCounterStore.counters[index]))),
                    title: Text('Count: ${multiCounterStore.counters[index].value}'),
                    trailing: const Icon(Icons.navigate_next),
                    leading: IconButton(
                      color: Colors.red,
                      icon: const Icon(Icons.delete),
                      onPressed: () => multiCounterStore.removeCounter(index),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  final SingleCounter counter;

  const CounterPage({Key key, @required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: const Icon(Icons.remove),
                    onPressed: counter.decrement,
                  ),
                  Expanded(
                    child: Center(
                      child: Observer(
                        builder: (_) => Text('${counter.value}', style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: const Icon(Icons.add),
                    onPressed: counter.increment,
                  ),
                ],
              ),
              FlatButton(
                child: const Text('Reset'),
                textColor: Colors.red,
                onPressed: counter.reset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
