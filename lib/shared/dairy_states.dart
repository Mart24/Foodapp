part of 'dairy_cubit.dart';

abstract class DairyStates {
  const DairyStates();
}

class AppStateInitial extends DairyStates {}

class SumBasicUpdated extends DairyStates {}

class SumOtherUpdated extends DairyStates {}

class PercentsUpdated extends DairyStates {}

class CurrentDateUpdated extends DairyStates {}

class GetUserTripsListState extends DairyStates {}
