import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dairy_states.dart';

class DairyCubit extends Cubit<DairyStates> {
  DairyCubit() : super(AppStateInitial());

  static DairyCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  List<QueryDocumentSnapshot> tripsList = [],
      breakfastList = [],
      lunchList = [],
      dinerList = [],
      snacksList = [],
      otherList = [];
  double kCalSum = 0,
      breakfastKcalSum = 0,
      lunchKcalSum = 0,
      dinerKcalSum = 0,
      snacksKcalSum = 0,
      othersKcalSum = 0;
  double sumco2Sum = 0,
      breakfastsumco2Sum = 0,
      lunchsumco2Sum = 0,
      dinersumco2Sum = 0,
      snackssumco2Sum = 0,
      otherssumco2Sum = 0;
  double carbs = 0,
      protein = 0,
      fats = 0,
      sugars = 0,
      saturatedFat = 0,
      dietaryFiber = 0,
      co2Sum = 0;
  double fatPercent = 0,
      carbsPercent = 0,
      proteinPercent = 0,
      sugarsPercent = 0,
      saturatedFatPercent = 0,
      dietaryFiberPercent = 0;

  DateTime currentDate = DateTime.now();

  void init() {
    tripsList =
        breakfastList = lunchList = dinerList = snacksList = otherList = [];
    kCalSum = breakfastKcalSum = lunchKcalSum = dinerKcalSum = snacksKcalSum =
        othersKcalSum = sumco2Sum = breakfastsumco2Sum = lunchsumco2Sum =
            dinersumco2Sum = snackssumco2Sum = otherssumco2Sum = 0;
    carbs = protein = fats = sugars = saturatedFat = dietaryFiber = co2Sum = 0;
    fatPercent = carbsPercent = proteinPercent =
        sugarsPercent = saturatedFatPercent = dietaryFiberPercent = 0;

    currentDate = DateTime.now();
  }

  void sumAll([List<DocumentSnapshot> givenTripsList]) {
    print('sum called');
    kCalSum = breakfastKcalSum = lunchKcalSum = dinerKcalSum = snacksKcalSum =
        othersKcalSum = co2Sum = sumco2Sum = breakfastsumco2Sum =
            lunchsumco2Sum = dinersumco2Sum = snackssumco2Sum =
                otherssumco2Sum = carbs =
                    fats = protein = sugars = saturatedFat = dietaryFiber = 0;
    // List<num> ids = [];

    tripsList.forEach((element) {
      Map<String, dynamic> data = element.data();
      kCalSum += data['kcal'];
      carbs += data['carbs'];
      fats += data['fat'];
      protein += data['protein'];
      sumco2Sum += data['co2'];
      co2Sum += data['co2'];
      sugars += data['sugars'];
      saturatedFat += data['saturatedfat'];
      dietaryFiber += data['dietaryfiber'];
      //ids.add(data['productid']);
    });
    breakfastList.forEach((element) {
      Map<String, dynamic> data = element.data();
      breakfastKcalSum += data['kcal'];
      breakfastsumco2Sum += data['co2'];
    });
    lunchList.forEach((element) {
      Map<String, dynamic> data = element.data();
      lunchKcalSum += data['kcal'];
      lunchsumco2Sum += data['co2'];
    });
    dinerList.forEach((element) {
      Map<String, dynamic> data = element.data();
      dinerKcalSum += data['kcal'];
      dinersumco2Sum += data['co2'];
    });
    snacksList.forEach((element) {
      Map<String, dynamic> data = element.data();
      snacksKcalSum += data['kcal'];
      snackssumco2Sum += data['co2'];
    });
    otherList.forEach((element) {
      Map<String, dynamic> data = element.data();
      othersKcalSum += data['kcal'];
      otherssumco2Sum += data['co2'];
    });
    //_sumSugars(ids);
    kCalSum = double.parse(kCalSum.toStringAsFixed(1));
    carbs = double.parse(carbs.toStringAsFixed(1));
    fats = double.parse(fats.toStringAsFixed(1));
    co2Sum = double.parse(co2Sum.toStringAsFixed(1));
    protein = double.parse(protein.toStringAsFixed(1));
    sugars = double.parse(sugars.toStringAsFixed(1));
    saturatedFat = double.parse(saturatedFat.toStringAsFixed(1));
    dietaryFiber = double.parse(dietaryFiber.toStringAsFixed(1));
    emit(SumBasicUpdated());
    print('sum calculated');
    // print('energy' + kCalSum.toString());
    // print('carbs: $carbs');
    // print('carbs: $fats');
    // print('protein: $protein');
    // print('sugars: $sugars');
    // print('saturatedFat: $saturatedFat');
    // print('dietaryFiber: $dietaryFiber');
  }

  void calcPercents() {
    fatPercent = carbsPercent = proteinPercent =
        dietaryFiberPercent = sugarsPercent = saturatedFatPercent = 0;
    double daySum = fats + carbs + protein;
    if (daySum != 0) {
      fatPercent = fats / daySum;
      carbsPercent = carbs / daySum;
      proteinPercent = protein / daySum;
      saturatedFatPercent = saturatedFat / daySum;
    }
    if (carbs != 0) sugarsPercent = sugars / carbs;
    if (carbs != 0) dietaryFiberPercent = dietaryFiber / carbs;
    // if (fats != 0) saturatedFatPercent = saturatedFat / fats;

    fatPercent = double.parse((fatPercent * 100).toStringAsFixed(1));
    carbsPercent = double.parse((carbsPercent * 100).toStringAsFixed(1));
    proteinPercent = double.parse((proteinPercent * 100).toStringAsFixed(1));

    sugarsPercent = double.parse((sugarsPercent * 100).toStringAsFixed(1));
    dietaryFiberPercent =
        double.parse((dietaryFiberPercent * 100).toStringAsFixed(1));
    saturatedFatPercent =
        double.parse((saturatedFatPercent * 100).toStringAsFixed(1));

    emit(PercentsUpdated());
    print('percents calculated');
    // print('Fat Percent: $fatPercent');
    // print('Carbs Percent: $carbsPercent');
    // print('Protein Percent: $proteinPercent');
    //
    // print('Saturated Fat Percent: $saturatedFatPercent');
    // print('Sugars Percent: $sugarsPercent');
    // print('dietaryFiber Percent: $dietaryFiberPercent');
  }

  void updateCurrentDate(DateTime date) {
    currentDate = date;
    emit(CurrentDateUpdated());
    // getUsersTripsList();
    getUsersTripsStreamSnapshots();
  }

  Future<void> getUsersTripsList(Source source) async {
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
        .get(GetOptions(source: source))
        .then((myQuerySnapShot) {
      tripsList = myQuerySnapShot.docs;

      breakfastList = myQuerySnapShot.docs
          .where((element) => element.data()['categorie'] == "Breakfast")
          .toList();
      lunchList = myQuerySnapShot.docs
          .where((element) => element.data()['categorie'] == "Lunch")
          .toList();
      dinerList = myQuerySnapShot.docs
          .where((element) => element.data()['categorie'] == "Diner")
          .toList();
      snacksList = myQuerySnapShot.docs
          .where((element) => element.data()['categorie'] == "Snacks")
          .toList();
      otherList = myQuerySnapShot.docs
          .where((element) => element.data()['categorie'] == "Other")
          .toList();

      emit(GetUserTripsListState());
    });
  }

  Stream<QuerySnapshot> myStream;

  Future<void> getUsersTripsStreamSnapshots() async {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    final uid = FirebaseAuth.instance.currentUser.uid;

    // var now =cubit.currentDate;
    var now = currentDate;
    var start = Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    var end =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day, 23, 59, 59));
    print('Now: $now');
    print('Start: ${start.toDate()}');
    print('End: ${end.toDate()}');
    myStream = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('food_intake')
        .where('eatDate', isGreaterThanOrEqualTo: start)
        .where('eatDate', isLessThanOrEqualTo: end)
        .orderBy("eatDate", descending: true)
        .snapshots();

    myStream.listen((event) {
      print('stream listener');
      getUsersTripsList(Source.serverAndCache);
    });
    print('updated stream');
    emit(StreamUpdatedState());
    // yield* myStream;

    getUsersTripsList(Source.serverAndCache);
  }

  double calGoal = 2000.0;

  setCalGoal(double goal1) async {
    calGoal = goal1;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble('calGoal', goal1).then((value) {
        emit(CalGoalUpdatedState());
      });
    });
  }

  getCalGoal() async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('calGoal')) {
        calGoal = prefs.getDouble('calGoal');
        emit(CalGoalUpdatedState());
      } else {
        prefs.setDouble('calGoal', 2000.0).then((value) {
          calGoal = 2000.0;
          emit(CalGoalUpdatedState());
        });
      }
    });
  }

  double saveco2Goal = 5.0;

  setSaveGoal(double co2savegoal) async {
    saveco2Goal = co2savegoal;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble('saveGoal', co2savegoal).then((value) {
        emit(SaveGoalUpdatedState());
      });
    });
  }

  getSaveGoal() async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('saveGoal')) {
        saveco2Goal = prefs.getDouble('saveGoal');
        emit(SaveGoalUpdatedState());
      } else {
        prefs.setDouble('saveGoal', 5.0).then((value) {
          saveco2Goal = 5.0;
          emit(SaveGoalUpdatedState());
        });
      }
    });
  }

  // bool isDarkMode = true;

  // setDarkMode(bool darkmodevalue) async {
  //   isDarkMode = darkmodevalue;
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.setBool('saveDark', darkmodevalue).then((value) {
  //       emit(SaveGoalUpdatedState());
  //     });
  //   });
  // }

  // getdarkmode() async {
  //   SharedPreferences.getInstance().then((prefs) {
  //     if (prefs.containsKey('saveDark')) {
  //       isDarkMode = prefs.getBool('saveDark');
  //       emit(SaveGoalUpdatedState());
  //     } else {
  //       prefs.setBool('saveDark', true).then((value) {
  //         isDarkMode = true;
  //         emit(SaveGoalUpdatedState());
  //       });
  //     }
  //   });
  // }
}
