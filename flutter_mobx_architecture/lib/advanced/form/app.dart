import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'form_store.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final store = FormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => store.name = value,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Pick a name',
                  errorText: store.error.name,
                ),
              ),
            ),
            Observer(
              builder: (_) => AnimatedOpacity(
                child: const LinearProgressIndicator(),
                duration: Duration(milliseconds: 300),
                opacity: store.isNameCheckPending ? 1 : 0,
              ),
            ),
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => store.email = value,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Set an email',
                  errorText: store.error.email,
                ),
              ),
            ),
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => store.password = value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Set a password',
                  errorText: store.error.password,
                ),
              ),
            ),
            RaisedButton(
              child: const Text('Sign up'),
              onPressed: store.validateAll,
            ),
          ],
        ),
      ),
    );
  }
}
