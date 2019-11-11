import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'contact.dart';
import 'main.dart' show CONTACTS;

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box(CONTACTS),
      builder: (_, box) {
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (_, index) {
            final contact = box.getAt(index) as Contact;
            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.age.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      box.putAt(index, Contact('${contact.name}*', contact.age + 1));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => box.deleteAt(index),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
