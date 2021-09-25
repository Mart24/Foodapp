import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Models/ingredients.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStateInitial());

  static SearchCubit instance(BuildContext context) => BlocProvider.of(context, listen: false);

  String scanResult;

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#32CD32",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      emit(SearchPlatformError());
      scanResult = 'Can not scan the barcode';
    }
    // if (!context.) return;
    if (scanResult != null) {
      this.scanResult = scanResult;
      if (scanResult == (-1).toString()) {
        emit(SearchCancelled());
      } else {
        emit(ScanValidResultReturned(scanResult: scanResult));
      }
    }
  }

  Future searchOnDb() async {
    QuerySnapshot<Map<String, dynamic>> searchResult = await FirebaseFirestore.instance
        .collection('fdd')
        .where('ean', isEqualTo: num.tryParse(scanResult))
        .get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> productDocs = searchResult.docs;
    if (productDocs.length > 0) {
      QueryDocumentSnapshot<Map<String,dynamic>> productDoc = productDocs[0];
      print('searchDB');
      print(productDoc['productid']);
      Trip trip = Trip.fromSnapshot(productDoc);
      emit(SearchResultFound(trip: trip));
    } else {
      emit(SearchResultNotFound());
    }
  }
}
