import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:food_app/Widgets/custom_button.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/goal_cubit.dart';

// import 'package:food_app/shared/dairy_cubit.dart';
import 'package:intl/intl.dart';

class GoalsAddScreen extends StatelessWidget {
  const GoalsAddScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoalCubit goalCubit = GoalCubit.instance(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Goals add screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocConsumer<GoalCubit, GoalStates>(
                        listener: (BuildContext context, state) {},
                        listenWhen: (prevS, newS) {
                          if ((newS is DoneUploadingImageState &&
                                  prevS is StartUploadingImageState) ||
                              newS is StartUploadingImageState) {
                            return true;
                          } else
                            return false;
                        },
                        buildWhen: (prevS, newS) {
                          if ((newS is DoneUploadingImageState &&
                                  prevS is StartUploadingImageState) ||
                              newS is StartUploadingImageState) {
                            return true;
                          } else
                            return false;
                        },
                        builder: (BuildContext context, state) {
                          print('rebuild image');
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                height: 150,
                                child: (goalCubit.state
                                        is StartUploadingImageState)
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : (goalCubit.state
                                            is DoneUploadingImageState||goalCubit.imageAsBytes!=null)
                                        ? Image.file(goalCubit.imageAsFile)
                                        : Image.asset('assets/img1.jpg'),
                              ),
                              Positioned(
                                right: 0,
                                bottom: -15,
                                child: TextButton.icon(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.7)),
                                  ),
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Add Image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    goalCubit.pickGoalImage();
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: goalCubit.goalName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (value) {
                        goalCubit.setGoalInfo(goalName: value);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        Text(
                          'Co2 Goal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: TextFormField(
                            initialValue: goalCubit.co2Goal.toString(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              goalCubit.setGoalInfo(co2Goal: int.parse(value));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'kg/Co2',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            theme: DatePickerTheme(),
                            currentTime: goalCubit.startDate ?? DateTime.now(),
                            minTime: DateTime(DateTime.now().year - 10),
                            maxTime: DateTime(DateTime.now().year + 10),
                            onChanged: (date) {
                              print('change $date');
                            },
                            onConfirm: (date) {
                              print('confirm $date');
                              goalCubit.setGoalInfo(startDate: date);
                            },
                            locale: LocaleType.en,
                          );
                        },
                        child: Text(
                          'Start Date',
                          style: TextStyle(
                              // color: Theme.of(context).primaryColor,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      BlocConsumer<GoalCubit, GoalStates>(
                        listener: (BuildContext context, state) {},
                        builder: (BuildContext context, state) => Text(
                          '${DateFormat.yMMMMd().format(goalCubit.startDate)}',
                          style: TextStyle(
                              // color: Theme.of(context).accentColor,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            onPressed: () {
              var d = goalCubit.startDate;
              AppCubit.instance(context).insertIntoDB('goals', {
                'userId': FirebaseAuth.instance.currentUser.uid,
                'co2Goal': goalCubit.co2Goal,
                'goalName': goalCubit.goalName,
                'startDate': DateTime(d.year, d.month, d.day).toIso8601String(),
                'image': goalCubit.imageAsBytes
              });
              Navigator.of(context).pop();
            },
            text: Text('Save Goal'),
          )
        ],
      ),
    );
  }
}


