import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/fooddata_json.dart';
import 'package:food_app/Services/fooddata_service_json_.dart';
// import 'package:food_app/Services/database_operations.dart';
// import 'package:food_app/Services/fooddata_service.dart';
// import 'package:food_app/Widgets/bestes_widget.dart';
// import 'package:food_app/Widgets/food_list.dart';
// import 'package:food_app/Widgets/horizontal_button_bar.dart';

class Foodpage extends StatefulWidget {
  Foodpage({Key key})
      : super(
          key: key,
        );

  @override
  _FoodpageState createState() => _FoodpageState();
}

class _FoodpageState extends State<Foodpage> {
  final dbService = DatabaseService();

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<FooddataSQLJSON>>(
            future: dbService.getFooddata(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].productid.toString()),
                      trailing: Text(snapshot.data[index].foodname),
                    );
                  });
            }));
  }
}
//   DatabaseService contactOperations = DatabaseService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SQFLite Tutorial'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               HorizontalButtonBar(),
//               FutureBuilder(
//                 future: contactOperations.getFooddata(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) print('error');
//                   var data = snapshot.data;
//                   return snapshot.hasData
//                       ? FoodList(data)
//                       : new Center(
//                           child: Text('You have no contacts'),
//                         );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
