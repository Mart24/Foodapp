import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:get/get_core/get_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

part 'goal_states.dart';

class GoalCubit extends Cubit<GoalStates> {
  GoalCubit() : super(GoalStateInitial());

  static GoalCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  DateTime startDate = DateTime.now();
  String goalName = '';
  int co2Goal = 0;
  Uint8List imageAsBytes;
  File imageAsFile;
  List<Map> goalQueryResult = [];

  List<double> eatenCals = [];
  List<double> eatenCo2 = [];
  List<double> savedCo2 = [];
  List<DateTime> goalDays = [];

  double overallSavedSum = 0;
  double weekSavedSum = 0;
  double weekCo2Sum = 0;

  void init() {
    goalName = '';
    co2Goal = 0;
    DateTime now = DateTime.now();
    imageAsBytes = Uint8List.fromList([]);
    startDate = DateTime(now.year, now.month, now.day);
  }

  Future<void> pickGoalImage() async {
    ImagePicker.pickImage(source: ImageSource.gallery)
        .then((File imageFile) async {
      if (imageFile != null) {
        print('emitting: StartUploadingImageState');
        emit(StartUploadingImageState());
        print(StartUploadingImageState);
        imageAsFile = imageFile;
        imageAsBytes = await imageFile.readAsBytes();
        print('emitting: DoneUploadingImageState');
        emit(DoneUploadingImageState());
        print(DoneUploadingImageState);
      } else {
        print('emitting: CancelChoosingImageState');

        emit(CancelChoosingImageState());
      }
    });
    //   .catchError((e) {
    // print(e);
    // print('emitting: ErrorUploadingImageState');
    //
    // emit(ErrorUploadingImageState());
    // print(ErrorUploadingImageState);
    // });
  }

  setGoalInfo({String goalName, int co2Goal, DateTime startDate}) {
    this.goalName = goalName ?? this.goalName;
    this.co2Goal = co2Goal ?? this.co2Goal;
    this.startDate = startDate ?? this.startDate;
    print(
        'current goal info\n goal name: ${this.goalName}, co2Goal: ${this.co2Goal}, startDate: ${this.startDate}');
    emit(DoneSettingGoal());
  }

  Future<void> getGoalData(
      Database database, String tableName, DateTime startDate) async {
    // emit(DatabaseGetLoadingState());
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    database.query(tableName,
        limit: 90,
        where: "date >= ? and date <= ?",
        whereArgs: [
          startDate.toIso8601String(),
          now.toIso8601String()
        ]).then((value) {
      goalQueryResult = value;

      print('retrived ${value.length}');

      int i = 0;
      value.forEach((element) {
        double sub = 5 - element['co2'];
        double saved = (sub < 0) ? 0 : sub;
        print(
            '${element['date']}: eaten Co2: ${element['co2']}, saved Co2: $saved');
        goalDays.add(DateTime.parse(element['date']));
        eatenCals.add(element['calories']);
        eatenCo2.add(element['co2']);
        savedCo2.add(saved);
        i++;
      });

      overallSavedSum = _sum(savedCo2, savedCo2.length);
      weekSavedSum = _sum(savedCo2, 7);
      weekCo2Sum = _sum(eatenCo2, 7);

      emit(GoalDataGetDone());
    });
  }

  double _sum(List<double> list, int num) {
    double sum = 0;
    int listLength = list.length;
    int sub = listLength - num;

    if (sub < 0) {
      sub = 0;
    }

    for (int i = listLength - 1; i >= sub; i--) {
      sum += list[i];
    }

    return sum;
  }
}
