import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStateInitial());

  static AppCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  double sum = 0;
  double carbs = 0;
  double protein = 0;
  double fat = 0;

  //
  // void sumKcal(double amount) {
  //   sum += amount;
  //   emit(SumUpdated());
  // }

  void sumAll(List<QueryDocumentSnapshot> list) {
    print('sum called');
    sum = carbs = fat = protein = 0;
    list.forEach((element) {
      sum += element.data()['kcal'];
      carbs += element.data()['carbs'];
      fat += element.data()['fat'];
      protein += element.data()['protein'];
    });
    print(sum);
    emit(SumUpdated());
  }
}
