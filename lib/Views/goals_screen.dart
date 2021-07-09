import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  String type;

  @override
  void initState() {
    super.initState();
    type = 'Calories';
    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser.uid;
    final AppCubit appCubit = AppCubit.instance(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 0,
        // title: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //   child: DropdownButton(
        //     isExpanded: true,
        //     value: type,
        //     underline: Container(),
        //     dropdownColor: Colors.grey[700],
        //     iconSize: 25,
        //     iconDisabledColor: Colors.grey,
        //     iconEnabledColor: Colors.white,
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold),
        //     items: [
        //       DropdownMenuItem(
        //         child: Text('Calories'),
        //         value: 'Calories',
        //       ),
        //       DropdownMenuItem(
        //         child: Text('Co2'),
        //         value: 'Co2',
        //       ),
        //     ],
        //     onChanged: (newITem) {
        //       print(newITem);
        //       setState(() {
        //         type = newITem;
        //       });
        //     },
        //   ),
        // ),
        title: Text('Goals'),
        toolbarHeight: 100,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: Container(
            height: 50,
            color: Colors.green.withOpacity(0.35),
            child: TabBar(
              onTap: (index) {
                if (index == 0) {
                  appCubit.getOneWeekData(appCubit.database, uid);
                } else if (index == 1) {
                  appCubit.getOneMonthData(appCubit.database, uid);
                } else if (index == 2) {
                  appCubit.getThreeMonthData(appCubit.database, uid);
                } else {
                  print('error in tab index');
                }
              },
              indicator: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(5),
              ),
              controller: tabController,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              tabs: [
                Text('1 Week'),
                Text('1 Month'),
                Text('3 Months'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          OneWeekGraph(),
          OneMonthGraph(),
          ThreeMonthsGraph(),
        ],
      ),
    );
  }
}

class OneWeekGraph extends StatelessWidget {
  const OneWeekGraph({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit.instance(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          if (state is DatabaseGetLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  legend: Legend(
                    isVisible: true,
                    // title: LegendTitle(text: type),
                    isResponsive: true,
                    position: LegendPosition.top,
                    alignment: ChartAlignment.near,
                    orientation: LegendItemOrientation.horizontal,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Calories'),
                      labelAlignment: LabelAlignment.start),
                  enableAxisAnimation: true,
                  // adding multiple axis
                  axes: <ChartAxis>[
                    NumericAxis(
                        name: 'yAxis',
                        opposedPosition: true,
                        title: AxisTitle(text: 'Co2'))
                  ],
                  series: <LineSeries<double, DateTime>>[
                    LineSeries<double, DateTime>(
                        name: 'Calories',
                        dataSource: appCubit.oneWeekCals,
                        xValueMapper: (double calories, int index) {
                          return DateTime.parse(appCubit.oneWeekQueryResult[index]['date']);

                          // String day = DateFormat.MEd().format(DateTime.parse(
                          //     appCubit.oneWeekQueryResult[index]['date']));
                          // return day;
                        },
                        yValueMapper: (double calories, int index) => calories),
                    LineSeries<double, DateTime>(
                        name: 'Co2',
                        dataSource: appCubit.oneWeekCo2,
                        xValueMapper: (double co2, int index) {
                          return DateTime.parse( appCubit.oneWeekQueryResult[index]['date']);

                          // String day = DateFormat.MEd().format(DateTime.parse(
                          //     appCubit.oneWeekQueryResult[index]['date']));
                          // return day;
                        },
                        yValueMapper: (double co2, int index) => co2,
                        yAxisName: 'yAxis'),
                  ]),
            );
          }
        });
  }
}

class OneMonthGraph extends StatelessWidget {
  const OneMonthGraph({
    Key key,
    // @required this.oneMonthData,
  }) : super(key: key);

  // final List<Map> oneMonthData;

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit.instance(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          if (state is DatabaseGetLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    isResponsive: true,
                    position: LegendPosition.top,
                    alignment: ChartAlignment.near,
                    orientation: LegendItemOrientation.horizontal,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryXAxis: DateTimeAxis(),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Calories'),
                      labelAlignment: LabelAlignment.start),
                  enableAxisAnimation: true,
                  // adding multiple axis
                  axes: <ChartAxis>[
                    NumericAxis(
                        name: 'yAxis',
                        opposedPosition: true,
                        title: AxisTitle(text: 'Co2'))
                  ],
                  series: <LineSeries<double, DateTime>>[
                    LineSeries<double, DateTime>(
                        name: 'Calories',
                        dataSource: appCubit.oneMonthCals,
                        xValueMapper: (double calories, int index) {
                          return DateTime.parse(appCubit.oneMonthQueryResult[index]['date']);

                          // String day = DateFormat.Md().format(DateTime.parse(
                          //     appCubit.oneMonthQueryResult[index]['date']));
                          // return day;
                        },
                        yValueMapper: (double calories, int index) => calories),
                    LineSeries<double, DateTime>(
                      name: 'Co2',
                      dataSource: appCubit.oneMonthCo2,
                      xValueMapper: (double co2, int index) {
                        return DateTime.parse(appCubit.oneMonthQueryResult[index]['date']);

                        // String day = DateFormat.Md().format(DateTime.parse(
                        //     appCubit.oneMonthQueryResult[index]['date']));
                        // return day;
                      },
                      yValueMapper: (double co2, int index) => co2,
                      // xAxisName: 'xAxis',
                      yAxisName: 'yAxis',
                    ),
                  ]),
            );
          }
        });
  }
}

class ThreeMonthsGraph extends StatelessWidget {
  const ThreeMonthsGraph({
    Key key,
    // @required this.threeMonthsData,
  }) : super(key: key);

  // final List<Map> threeMonthsData;

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit.instance(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          if (state is DatabaseGetLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  legend: Legend(
                    isVisible: true,
                    // title: LegendTitle(text: type),
                    isResponsive: true,
                    position: LegendPosition.top,
                    alignment: ChartAlignment.near,
                    orientation: LegendItemOrientation.horizontal,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Calories'),
                      labelAlignment: LabelAlignment.start),
                  enableAxisAnimation: true,
                  // adding multiple axis
                  axes: <ChartAxis>[
                    NumericAxis(
                        name: 'yAxis',
                        opposedPosition: true,
                        title: AxisTitle(text: 'Co2'))
                  ],
                  series: <LineSeries<double, DateTime>>[
                    LineSeries<double, DateTime>(
                        name: 'Calories',
                        dataSource: appCubit.threeMonthsCals,
                        xValueMapper: (double calories, int index) {
                          return DateTime.parse( appCubit.threeMonthsQueryResult[index]['date']);

                          // String day = DateFormat.m().format(DateTime.parse(
                          //     appCubit.threeMonthsQueryResult[index]['date']));
                          // return day;
                        },
                        yValueMapper: (double calories, int index) => calories),
                    LineSeries<double, DateTime>(
                        name: 'Co2',
                        dataSource: appCubit.threeMonthsCo2,
                        xValueMapper: (double co2, int index) {
                          return DateTime.parse( appCubit.threeMonthsQueryResult[index]['date']);

                          // String day = DateFormat.MEd().format(DateTime.parse(
                          //     appCubit.threeMonthsQueryResult[index]['date']));
                          // return day;
                        },
                        yValueMapper: (double co2, int index) => co2,
                        yAxisName: 'yAxis'),
                  ]),
            );
          }
        });
  }
}
