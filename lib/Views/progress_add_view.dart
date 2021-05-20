import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/foodname.dart';
import 'package:food_app/Services/database_operations.dart';
import 'package:food_app/Views/progress_view.dart';

class AddContactPage extends StatefulWidget {
  AddContactPage({Key key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  ContactOperations contactOperations = ContactOperations();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFLite Tutorial'),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Progress()));
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _surnameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Surname'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final contact = Contact(
              name: _nameController.text, surname: _surnameController.text);

          contactOperations.createContact(contact);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
