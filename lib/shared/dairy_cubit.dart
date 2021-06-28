import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:get/get_core/get_core.dart';
import 'package:sqflite/sqflite.dart';

part 'dairy_states.dart';

class DairyCubit extends Cubit<DairyStates> {
  DairyCubit() : super(AppStateInitial());

  static DairyCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  List<QueryDocumentSnapshot> tripsList = [];
  double kCalSum = 0;
  double carbs = 0;
  double protein = 0;
  double fats = 0;
  double sugars = 0;
  double saturatedFat = 0;
  double dietaryFiber = 0;
  double co2Sum = 0;

  double fatPercent = 0;
  double carbsPercent = 0;
  double proteinPercent = 0;
  double sugarsPercent = 0;
  double saturatedFatPercent = 0;
  double dietaryFiberPercent = 0;

  DateTime currentDate = DateTime.now();

  //
  // void sumKcal(double amount) {
  //   sum += amount;
  //   emit(SumUpdated());
  // }

  void sumAll() {
    print('sum called');
    kCalSum = co2Sum =
        carbs = fats = protein = sugars = saturatedFat = dietaryFiber = 0;
    List<num> ids = [];
    tripsList.forEach((element) {
      Map<String, dynamic> data = element.data();
      kCalSum += data['kcal'];
      carbs += data['carbs'];
      fats += data['fat'];
      protein += data['protein'];
      co2Sum += data['co2'];
      sugars += data['sugars'];
      saturatedFat += data['saturatedfat'];
      dietaryFiber += data['dietaryfiber'];
      //ids.add(data['productid']);
    });

    //_sumSugars(ids);
    kCalSum = double.parse(kCalSum.toStringAsFixed(0));
    carbs = double.parse(carbs.toStringAsFixed(2));
    fats = double.parse(fats.toStringAsFixed(2));
    co2Sum = double.parse(co2Sum.toStringAsFixed(2));
    protein = double.parse(protein.toStringAsFixed(2));
    sugars = double.parse(sugars.toStringAsFixed(2));
    saturatedFat = double.parse(saturatedFat.toStringAsFixed(2));
    dietaryFiber = double.parse(dietaryFiber.toStringAsFixed(2));
    emit(SumBasicUpdated());
    print('energy' + kCalSum.toString());
    print('carbs: $carbs');
    print('carbs: $fats');
    print('protein: $protein');
    print('sugars: $sugars');
    print('saturatedFat: $saturatedFat');
    print('dietaryFiber: $dietaryFiber');
  }

  // Future<void> _sumSugars(List<num> ids) async {
  //   print('SumSugars called');
  //   sugars = saturatedFat = dietaryFiber = 0;
  //   if (ids.isNotEmpty) {
  //     FirebaseFirestore.instance
  //         .collection('fdd')
  //         .where('productid', whereIn: ids)
  //         .get()
  //         .then((value) {
  //       List<QueryDocumentSnapshot> docs = value.docs;
  //       docs.forEach((element) {
  //         print('element ${element.id}');
  //         sugars += element.data()['sugars'];
  //         saturatedFat += element.data()['saturatedfat'];
  //         dietaryFiber += element.data()['dietaryfiber'];
  //       });

  //    emit(SumOtherUpdated());
  //   });
  // }
  // }

  void calcPercents() {
    fatPercent = carbsPercent = proteinPercent =
        dietaryFiberPercent = sugarsPercent = saturatedFatPercent = 0;
    double daySum = fats + carbs + protein;
    if (daySum != 0) {
      fatPercent = fats / daySum;
      carbsPercent = carbs / daySum;
      proteinPercent = protein / daySum;
    }
    if (carbs != 0) sugarsPercent = sugars / carbs;
    if (carbs != 0) dietaryFiberPercent = dietaryFiber / carbs;
    if (fats != 0) saturatedFatPercent = saturatedFat / fats;

    fatPercent = double.parse((fatPercent * 100).toStringAsFixed(1));
    carbsPercent = double.parse((carbsPercent * 100).toStringAsFixed(1));
    proteinPercent = double.parse((proteinPercent * 100).toStringAsFixed(1));

    sugarsPercent = double.parse((sugarsPercent * 100).toStringAsFixed(1));
    dietaryFiberPercent =
        double.parse((dietaryFiberPercent * 100).toStringAsFixed(1));
    saturatedFatPercent =
        double.parse((saturatedFatPercent * 100).toStringAsFixed(1));

    emit(PercentsUpdated());
    print('Fat Percent: $fatPercent');
    print('Carbs Percent: $carbsPercent');
    print('Protein Percent: $proteinPercent');

    print('Saturated Fat Percent: $saturatedFatPercent');
    print('Sugars Percent: $sugarsPercent');
    print('dietaryFiber Percent: $dietaryFiberPercent');
  }

  void updateCurrentDate(
    DateTime date,
  ) {
    currentDate = date;
    emit(CurrentDateUpdated());
    getUsersTripsList();
  }

  Future<void> getUsersTripsList() async {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    final uid = FirebaseAuth.instance.currentUser.uid;
    var now = currentDate;
    var start = Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    var end =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day, 23, 59, 59));
    print('Now: $now');
    print('Start: ${start.toDate()}');
    print('End: ${end.toDate()}');
    FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('food_intake')
        .where('eatDate', isGreaterThanOrEqualTo: start)
        .where('eatDate', isLessThanOrEqualTo: end)
        .orderBy("eatDate", descending: true)
        .get()
        .then((myQuerySnapShot) {
      List<QueryDocumentSnapshot> myList = myQuerySnapShot.docs;
      tripsList = myList;
      emit(GetUserTripsListState());
    });
  }
}
