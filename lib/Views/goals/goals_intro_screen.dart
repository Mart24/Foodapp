import 'package:flutter/material.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/goals/goals_add_screen.dart';
import 'package:food_app/Widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          //  backgroundColor: Colors.white,
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
                  color: kPrimaryColor,
                  padding: EdgeInsets.all(6),
                ),
                endChild: _RightChild(
                  asset: 'assets/icons/first_idea.png',
                  title: AppLocalizations.of(context).goal1atext,
                  message: AppLocalizations.of(context).goal1btext,
                ),
                beforeLineStyle: const LineStyle(
                  color: kPrimaryColor,
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: kPrimaryColor,
                  padding: EdgeInsets.all(6),
                ),
                endChild: _RightChild(
                  asset: 'assets/icons/second_calculate.png',
                  title: AppLocalizations.of(context).goal2atext,
                  message: AppLocalizations.of(context).goal2btext,
                ),
                beforeLineStyle: const LineStyle(
                  color: kPrimaryColor,
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: kPrimaryColor,
                  padding: EdgeInsets.all(6),
                ),
                endChild: _RightChild(
                  asset: 'assets/icons/third_fillin.png',
                  title: AppLocalizations.of(context).goal3atext,
                  message: AppLocalizations.of(context).goal3btext,
                ),
                beforeLineStyle: const LineStyle(
                  color: kPrimaryColor,
                ),
                afterLineStyle: const LineStyle(
                  color: kPrimaryColor,
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                isLast: true,
                indicatorStyle: const IndicatorStyle(
                  width: 20,
                  color: kPrimaryColor,
                  padding: EdgeInsets.all(6),
                ),
                endChild: _RightChild(
                  disabled: false,
                  asset: 'assets/icons/fourth_start.png',
                  title: AppLocalizations.of(context).goal4atext,
                  message: AppLocalizations.of(context).goal4btext,
                ),
                beforeLineStyle: const LineStyle(
                  color: kPrimaryColor,
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
              text: Text(AppLocalizations.of(context).goalbuttontext),
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
                    // color: disabled
                    //     ? const Color(0xFFBABABA)
                    //     : const Color(0xFF636564),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.yantramanav(
                    // color: disabled
                    //     ? const Color(0xFFD5D5D5)
                    //     : const Color(0xFF636564),
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
        //    color: Color(0xFFF9F9F9),
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
                    AppLocalizations.of(context).goalheader2ntext,
                    style: GoogleFonts.yantramanav(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
      backgroundColor: kPrimaryColor,
      // leading: const Icon(Icons.menu),
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context).goalheaderntext,
        style: TextStyle(color: Colors.white),
        // style: GoogleFonts.neuton(
        //     color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(35);
}
