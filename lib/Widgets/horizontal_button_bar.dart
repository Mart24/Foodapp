import 'package:flutter/material.dart';
import 'package:food_app/Views/progress_add_view.dart';
import 'package:food_app/Views/progress_search_view.dart';

class HorizontalButtonBar extends StatelessWidget {
  HorizontalButtonBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'contacts',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddContactPage()));
            },
            child: Icon(Icons.person_add),
          ),
          FloatingActionButton(
            heroTag: 'search',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
