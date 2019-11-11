import 'package:flutter/material.dart';

import 'contact.dart';
import 'package:hive/hive.dart';
import 'main.dart' show CONTACTS;

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;

  int _age;

  void _addContact(){
    _formKey.currentState.save();
    final contact = Contact(_name, _age);
    Hive.box(CONTACTS).add(contact); // add without key
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value)=> _name = value,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onSaved: (value)=> _age = int.parse(value),
                ),
              ),
            ],
          ),
          RaisedButton(
            child: Text('Add New Contact'),
            onPressed: _addContact,
          ),
        ],
      ),
    );
  }
}
