import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/fooddata_json.dart';
import 'package:food_app/Services/fooddata_service_json_.dart';

class Foodpage extends StatefulWidget {
  final FooddataSQLJSON food;
  Foodpage({Key key, @required this.food}) : super(key: key);

  @override
  _FoodpageState createState() => _FoodpageState();
}

class _FoodpageState extends State<Foodpage> {
  final dbService = DatabaseService();
  String keyword;
  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Typ hier iets'),
                  onChanged: (value) {
                    keyword = value;
                    setState(() {});
                  },
                ),
              ),
              Container(
                height: 800,
                child: Testwidget(dbService: dbService, keyword: keyword),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Testwidget extends StatelessWidget {
  const Testwidget({
    Key key,
    @required this.dbService,
    @required this.keyword,
  }) : super(key: key);

  final DatabaseService dbService;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FooddataSQLJSON>>(
      future: dbService.searchFooddata(keyword),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data[index].foodname),
                // trailing: Text(snapshot.data[index].productid.toString()),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         Foodamound(snapshot.data[index].foodname),
                  //   ),
                  // );
                },
              );
            });
      },
    );
  }
}
