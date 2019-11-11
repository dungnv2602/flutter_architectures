import 'package:flutter/material.dart';
import 'package:flutter_architectures/generated/i18n.dart';

import 'settings_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).homePage),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage())),
            ),
          ],
        ),
        body: const Center());
  }
}
