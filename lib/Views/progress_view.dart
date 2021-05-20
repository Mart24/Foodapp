import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Services/database_operations.dart';
import 'package:food_app/Widgets/food_list.dart';
import 'package:food_app/Widgets/horizontal_button_bar.dart';

class Progress extends StatefulWidget {
  Progress({Key key})
      : super(
          key: key,
        );

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  ContactOperations contactOperations = ContactOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFLite Tutorial'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              HorizontalButtonBar(),
              FutureBuilder(
                future: contactOperations.getAllContacts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print('error');
                  var data = snapshot.data;
                  return snapshot.hasData
                      ? ContactsList(data)
                      : new Center(
                          child: Text('You have no contacts'),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
