part of 'search_cubit.dart';

abstract class SearchStates {
  const SearchStates();
}

class SearchStateInitial extends SearchStates {}

class ScanValidResultReturned extends SearchStates {
  final String scanResult;

  ScanValidResultReturned({@required this.scanResult});
}

class SearchCancelled extends SearchStates {}

class SearchPlatformError extends SearchStates {}

class SearchResultFound extends SearchStates {
  final Trip trip;

  SearchResultFound({@required this.trip});
}

class SearchResultNotFound extends SearchStates {}
