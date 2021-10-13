part of 'productOne_cubit.dart';

abstract class ProductOneStates {
  const ProductOneStates();
}

class SearchStateInitial1 extends ProductOneStates {}

class ScanValidResultReturned1 extends ProductOneStates {
  final String scanResult;

  ScanValidResultReturned1({@required this.scanResult});
}

class SearchCancelled1 extends ProductOneStates {}

class SearchPlatformError1 extends ProductOneStates {}

class SearchResultFound1 extends ProductOneStates {
  // final Trip trip;

  SearchResultFound1(
      // {@required this.trip}
      );
}

class SearchResultNotFound1 extends ProductOneStates {}
