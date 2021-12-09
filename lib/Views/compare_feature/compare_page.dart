import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Views/compare_feature/comparison_view.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Widgets/rounded_button.dart';
import 'package:food_app/shared/productOne_cubit.dart';
import 'package:food_app/shared/productTwo_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'comparison_search_page.dart';

class ComparePage extends StatefulWidget {
  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final newTrip = Trip(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null);

  @override
  Widget build(BuildContext context) {
    ProductOneCubit productOneCubit = ProductOneCubit.instance(context);
    ProductTwoCubit productTwoCubit = ProductTwoCubit.instance(context);
    try {
      print(
          'rebuild compare page: ${ProductOneCubit.tappedTripP1.name ?? ''}, ${ProductTwoCubit.tappedTrip.name ?? ''}');
    } catch (e) {
      print('first rebuild');
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).comparevietheadertext,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(2),
        // height: double.infinity,
        // color: Colors.black,
        child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: scrollController,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProductOne(
                        scrollController: scrollController,
                        newTrip: newTrip,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      ProductTwo(
                        scrollController: scrollController,
                        newTrip: newTrip,
                      ),
                    ]),
              ),
            ]),
      ),
    );
  }
}

class ProductTwo extends StatelessWidget {
  const ProductTwo(
      {Key key, @required this.scrollController, @required this.newTrip})
      : super(key: key);
  final ScrollController scrollController;
  final Trip newTrip;

  @override
  Widget build(BuildContext context) {
    ProductTwoCubit productTwoCubit = ProductTwoCubit.instance(context);

    return Expanded(
      key: ValueKey('e2'),
      child: Container(
        height: double.infinity,
        //  color: Colors.grey[100],
        child: BlocConsumer<ProductTwoCubit, ProductTwoStates>(
            buildWhen: (previous, current) {
              if (current == previous) {
                return false;
              } else {
                return true;
              }
            },
            key: ValueKey('p2'),
            bloc: productTwoCubit,
            listener: (context, state) {},

            // listener: (context, state) {
            //   if (state is ScanValidResultReturned2) {
            //     print('SearchValidResultReturned');
            //     print(productTwoCubit.scanResult);
            //
            //     productTwoCubit.searchOnDb();
            //   } else if (state is SearchResultFoundTwo) {
            //     print('SearchResultFound');
            //     print(productTwoCubit.scanResult);
            //     Navigator.of(context).pop();
            //   } else if (state is SearchResultNotFound2) {
            //     print('SearchResultNotFound');
            //     print(productTwoCubit.scanResult);
            //
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             title: Text('This Product is not found currently'),
            //             content: Text(
            //                 'we work hard to include all the product in our database, please search for a similar product or send us an email'),
            //             actions: [
            //               RoundedButton(
            //                 color: Colors.green,
            //                 text: 'OK',
            //               )
            //             ],
            //           );
            //         });
            //   } else {
            //     print('___^----^___');
            //   }
            // },
            builder: (context, state) {
              if (state is SearchResultFoundTwo) {
                print('product2: ${ProductTwoCubit.tappedTrip.name}');

                return ComparisonView(
                  key: ValueKey('product2'),
                  trip: ProductTwoCubit.tappedTrip,
                  productNumber: 2,
                  scrollController: scrollController,
                );
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: 'product2',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompareSearch2(
                                  key: ValueKey('CompareSearch2'),
                                  // productNumber: 2,
                                ),
                              ));
                        },
                        label: const Text(
                          'Product 2',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                    ]);
              }
            }),
      ),
    );
  }
}

class ProductOne extends StatelessWidget {
  const ProductOne(
      {Key key, @required this.scrollController, @required this.newTrip})
      : super(key: key);
  final ScrollController scrollController;
  final Trip newTrip;

  @override
  Widget build(BuildContext context) {
    ProductOneCubit productOneCubit = ProductOneCubit.instance(context);

    return Expanded(
      key: ValueKey('e1'),
      child: Container(
        //  color: Colors.grey[100],
        height: double.infinity,
        child: BlocConsumer<ProductOneCubit, ProductOneStates>(
            buildWhen: (previous, current) {
              if (current == previous) {
                return false;
              } else {
                return true;
              }
            },
            key: ValueKey('p1'),
            bloc: productOneCubit,
            listener: (context, state) {},
            // listener: (context, state) {
            //   if (state is ScanValidResultReturned1) {
            //     print('SearchValidResultReturned');
            //     print(productOneCubit.scanResult);
            //
            //     productOneCubit.searchOnDb();
            //   } else if (state is SearchResultFound1) {
            //     print('SearchResultFound');
            //     print(productOneCubit.scanResult);
            //
            //     Navigator.of(context).pop();
            //   } else if (state is SearchResultNotFound1) {
            //     print('SearchResultNotFound');
            //     print(productOneCubit.scanResult);
            //
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             title: Text('This Product is not found currently'),
            //             content: Text(
            //                 'we work hard to include all the product in our database, please search for a similar product or send us an email'),
            //             actions: [
            //               RoundedButton(
            //                 color: Colors.green,
            //                 text: 'OK',
            //               )
            //             ],
            //           );
            //         });
            //   } else {
            //     print('___^----^___');
            //   }
            // },
            builder: (context, state) {
              if (state is SearchResultFound1) {
                print('product1: ${ProductOneCubit.tappedTripP1.name}');
                return ComparisonView(
                  key: ValueKey('product1'),
                  trip: ProductOneCubit.tappedTripP1,
                  productNumber: 1,
                  scrollController: scrollController,
                );
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: 'product1',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompareSearch1(
                                  key: ValueKey('CompareSearch1'),
                                  // productNumber: 1,
                                ),
                              ));
                        },
                        label: const Text('Product 1',
                            style: TextStyle(color: Colors.white)),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                    ]);
              }
            }),
      ),
    );
  }
}
