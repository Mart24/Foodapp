part of 'app_cubit.dart';

abstract class AppStates {
  const AppStates();
}

class AppStateInitial extends AppStates {}

class DatabaseCreatedState extends AppStates {
  DatabaseCreatedState();
}

class DatabaseTableCreatedState extends AppStates {
  DatabaseTableCreatedState();
}

class DatabaseOpenedState extends AppStates {
  DatabaseOpenedState();
}

class DatabaseClosedState extends AppStates {
  DatabaseClosedState();
}

class DatabaseInsertedState extends AppStates {

}

class DatabaseUpdatedState extends AppStates {
  int updatedRecordID;

  DatabaseUpdatedState({
    @required this.updatedRecordID,
  });
}

class DatabaseCountedState extends AppStates {
  int count;

  DatabaseCountedState({
    @required this.count,
  });
}

class DatabaseGetState extends AppStates {}

class DatabaseGetLoadingState extends AppStates {}


class DatabaseRecordDeletedState extends AppStates {}
