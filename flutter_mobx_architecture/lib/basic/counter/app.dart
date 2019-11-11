import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'counter.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 15,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: 2.5,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.black54,
            tabs: List.generate(
              15,
              (index) => Tab(
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  child: Text(
                    'Tab $index',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(15, (index) => CounterObserver()),
        ),
      ),
    );
  }
}

class CounterObserver extends StatelessWidget {
  final counter = Counter(); // instantiate the store

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('TIMES'),
            Observer(
              builder: (_) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
