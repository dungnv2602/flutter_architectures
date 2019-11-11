import 'package:flutter/material.dart';
import 'package:flutter_architectures/generated/i18n.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChangeLanguagePage())),
            child: ListTile(
              title: Text(S.of(context).changeLanguage),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeLanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).changeLanguage),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text(S.of(context).english),
              trailing: Icon(Icons.access_alarm),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text(S.of(context).vietnamese),
              trailing: Icon(Icons.ac_unit),
            ),
          ),
        ],
      ),
    );
  }
}
