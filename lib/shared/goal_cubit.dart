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
  String goalName;
  int co2Goal;
  Uint8List imageAsBytes;
  File imageAsFile;

  void init() {
    goalName = '';
    co2Goal = 0;
    DateTime now = DateTime.now();
    imageAsBytes =Uint8List.fromList([]);
    startDate = DateTime(now.year, now.month, now.day);
  }

  Future<void> pickGoalImage() async {
    ImagePicker.pickImage(source: ImageSource.gallery)
        .then((File imageFile) async {

      if (imageFile != null) {
        emit(StartUploadingImageState());
        print(StartUploadingImageState);
        imageAsFile = imageFile;
        imageAsBytes = await imageFile.readAsBytes();
        emit(DoneUploadingImageState());
        print(DoneUploadingImageState);
      } else {
        emit(CancelChoosingImageState());
      }
    }).catchError((e) {
      print(e);
      emit(ErrorUploadingImageState());
      print(ErrorUploadingImageState);
    });
  }

  setGoalInfo({String goalName, int co2Goal, DateTime startDate}) {
    this.goalName = goalName ?? this.goalName;
    this.co2Goal = co2Goal ?? this.co2Goal;
    this.startDate = startDate ?? this.startDate;
    print(
        'current goa info\n goal name: ${this.goalName}, co2Goal: ${this.co2Goal}, startDate: ${this.startDate}');
    emit(DoneSettingGoal());
  }
}
