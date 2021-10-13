part of 'productTwo_cubit.dart';

abstract class ProductTwoStates {
  const ProductTwoStates();
}

class SearchStateInitial2 extends ProductTwoStates {}

class ScanValidResultReturned2 extends ProductTwoStates {
  final String scanResult;

  ScanValidResultReturned2({@required this.scanResult});
}

class SearchCancelled2 extends ProductTwoStates {}

class SearchPlatformError2 extends ProductTwoStates {}

class SearchResultFoundTwo extends ProductTwoStates {
  // final Trip trip;

  SearchResultFoundTwo(
      // {@required this.trip}
      );
}

class SearchResultNotFound2 extends ProductTwoStates {}
