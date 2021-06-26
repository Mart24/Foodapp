import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:sqflite/sqflite.dart';

part 'dairy_states.dart';

class DairyCubit extends Cubit<DairyStates> {
  DairyCubit() : super(AppStateInitial());

  static DairyCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  double kCalSum = 0;
  double carbs = 0;
  double protein = 0;
  double fats = 0;
  double sugars = 0;
  double saturatedFat = 0;
  double dietaryFiber = 0;

  double fatPercent = 0;
  double carbsPercent = 0;
  double proteinPercent = 0;
  double sugarsPercent = 0;
  double saturatedFatPercent = 0;
  double dietaryFiberPercent = 0;

  //
  // void sumKcal(double amount) {
  //   sum += amount;
  //   emit(SumUpdated());
  // }

  void sumAll(List<QueryDocumentSnapshot> list) {
    print('sum called');
    kCalSum = carbs = fats = protein = sugars = saturatedFat = dietaryFiber = 0;
    List<num> ids = [];
    list.forEach((element) {
      Map<String, dynamic> data = element.data();
      kCalSum += data['kcal'];
      carbs += data['carbs'];
      fats += data['fat'];
      protein += data['protein'];
      ids.add(data['productid']);
    });

    _sumSugars(ids);
    kCalSum = double.parse(kCalSum.toStringAsFixed(2));
    carbs = double.parse(carbs.toStringAsFixed(2));
    fats = double.parse(fats.toStringAsFixed(2));
    protein = double.parse(protein.toStringAsFixed(2));
    emit(SumBasicUpdated());
    print('energy' + kCalSum.toString());
    print('carbs: $carbs');
    print('carbs: $fats');
    print('protein: $protein');
  }

  Future<void> _sumSugars(List<num> ids) async {
    print('SumSugars called');
    sugars = saturatedFat = dietaryFiber = 0;
    FirebaseFirestore.instance
        .collection('fdd')
        .where('productid', whereIn: ids)
        .get()
        .then((value) {
      List<QueryDocumentSnapshot> docs = value.docs;
      docs.forEach((element) {
        print('element ${element.id}');
        sugars += element.data()['sugars'];
        saturatedFat += element.data()['saturatedfat'];
        dietaryFiber += element.data()['dietaryfiber'];
      });

      emit(SumOtherUpdated());
    });
  }

  void calcPercents() {
    fatPercent = carbsPercent = proteinPercent =
        dietaryFiberPercent = sugarsPercent = saturatedFatPercent = 0;
    double daySum = fats + carbs + protein;
    fatPercent = fats / daySum;
    carbsPercent = carbs / daySum;
    proteinPercent = protein / daySum;

    sugarsPercent = sugars / carbs;
    dietaryFiberPercent = dietaryFiber / carbs;
    saturatedFatPercent = saturatedFat / fats;

    fatPercent = double.parse((fatPercent * 100).toStringAsFixed(2));
    carbsPercent = double.parse((carbsPercent * 100).toStringAsFixed(2));
    proteinPercent = double.parse((proteinPercent * 100).toStringAsFixed(2));

    sugarsPercent = double.parse((sugarsPercent * 100).toStringAsFixed(2));
    dietaryFiberPercent =
        double.parse((dietaryFiberPercent * 100).toStringAsFixed(2));
    saturatedFatPercent =
        double.parse((saturatedFatPercent * 100).toStringAsFixed(2));

    emit(PercentsUpdated());
    print('Fat Percent: $fatPercent');
    print('Carbs Percent: $carbsPercent');
    print('Protein Percent: $proteinPercent');

    print('Saturated Fat Percent: $saturatedFatPercent');
    print('Sugars Percent: $sugarsPercent');
    print('dietaryFiber Percent: $dietaryFiberPercent');
  }
}
