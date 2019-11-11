import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'contact.dart';
import 'contact_form.dart';
import 'contact_page.dart';

const CONTACTS = 'contacts';
final key = Hive.generateSecureKey();

void main() async {
  // get store dir
  final appDir = await getApplicationDocumentsDirectory();
  // init hive
  Hive.init(appDir.path);
  //register adapter globally
  Hive.registerAdapter(ContactAdapter(), 0); // typeId is 0
  // run app
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Hive.openBox(CONTACTS, compactionStrategy: (int total, int deleted) => deleted > 20),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));
            else
              return HomePage();
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.box(CONTACTS).compact(); // compact box to clean deleted items

    // clear data before app exit => only useful in some situations
    _clearBoxData();

    Hive.close();
    super.dispose();
  }

  void _clearBoxData() {
    Hive.box(CONTACTS).clear();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(child: ContactPage()),
          ContactForm(),
        ],
      ),
    );
  }
}
