import 'package:flutter/material.dart';
import 'package:food_app/Models/fooddata.dart';
import 'package:food_app/Services/fooddata_service.dart';

class FoodList extends StatelessWidget {
  List<FooddataSQL> fooddatas;

  FoodList(List<FooddataSQL> this.fooddatas, {Key key}) : super(key: key);
  DatabaseService contactOperations = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: fooddatas.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('${fooddatas[index].productid}'),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ' ${fooddatas[index].foodname} ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => EditContactPage(
                              //                 contact: contacts[index],
                              //               )));
                            },
                            color: Colors.orange,
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            onDismissed: (direction) {
              //       contactOperations.deleteContact(contacts[index]);
            },
          );
        },
      ),
    );
  }
}
