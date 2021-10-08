import 'package:flutter/material.dart';
import 'package:food_app/Views/goals/goals_add_screen.dart';
import 'package:food_app/Widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class GoalsIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF379A69),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF27AA69).withOpacity(0.2),
        ),
        child: Scaffold(
          appBar: _AppBar(),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              _Header(),
              Expanded(child: _TimelineGoal()),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineGoal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                isFirst: true,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: Color(0xFF27AA69),
                  padding: EdgeInsets.all(6),
                ),
                endChild: const _RightChild(
                  asset: 'assets/icons/first_idea.png',
                  title: 'Think of a Goal',
                  message:
                      'It can be anything; a train ticket, clothing basket, car ride.',
                ),
                beforeLineStyle: const LineStyle(
                  color: Color(0xFF27AA69),
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: Color(0xFF27AA69),
                  padding: EdgeInsets.all(6),
                ),
                endChild: const _RightChild(
                  asset: 'assets/icons/second_calculate.png',
                  title: 'Calculate Goal',
                  message: 'Search online for the amount of CO² it costs.',
                ),
                beforeLineStyle: const LineStyle(
                  color: Color(0xFF27AA69),
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: Color(0xFF27AA69),
                  padding: EdgeInsets.all(6),
                ),
                endChild: const _RightChild(
                  asset: 'assets/icons/third_fillin.png',
                  title: 'Fill in this App',
                  message: 'Stay below 500 kg/Co² for a reachable goal.',
                ),
                beforeLineStyle: const LineStyle(
                  color: Color(0xFF27AA69),
                ),
                afterLineStyle: const LineStyle(
                  color: Color(0xFF27AA69),
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                isLast: true,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: Color(0xFF27AA69),
                  padding: EdgeInsets.all(6),
                ),
                endChild: const _RightChild(
                  disabled: false,
                  asset: 'assets/icons/fourth_start.png',
                  title: 'Start eating Sustainable',
                  message:
                      'Fill in starting your date. The more sustainable your diet, the more you save!',
                ),
                beforeLineStyle: const LineStyle(
                  color: Color(0xFF27AA69),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GoalsAddScreen()));
              },
              text: Text('Set up Co2 Goal'),
            ),
          ],
        ),
      ]),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(asset, height: 50),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: GoogleFonts.yantramanav(
                    color: disabled
                        ? const Color(0xFFBABABA)
                        : const Color(0xFF636564),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.yantramanav(
                    color: disabled
                        ? const Color(0xFFD5D5D5)
                        : const Color(0xFF636564),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9E9),
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Each day below 5kg/Co² is saved',
                    style: GoogleFonts.yantramanav(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: const Color(0xFF27AA69),
      // leading: const Icon(Icons.menu),
      centerTitle: true,
      title: Text(
        'Set a Co2 goal',
        // style: GoogleFonts.neuton(
        //     color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(35);
}
