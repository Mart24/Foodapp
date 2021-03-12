import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:food_app/Views/sign_up_view.dart';

const colorlightgreen = const Color(0xFFE0EFD9);
const colordarkgreen = const Color(0xFF7AA573);

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => SignUpView(authFormType: AuthFormType.signUp)),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 27.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: colorlightgreen,
      imagePadding: EdgeInsets.only(top: 40),
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Het eten op ons bord komt van over de hele wereld",
          body: "Hier Martijn en Neel nog even een leuk tekstje bij zetten.",
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Veel schade aan de wereld door voedselconsumptie",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ontwikkel een duurzaam en vooral gezond lifestyle",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('img3'),
          footer: RaisedButton(
            onPressed: () {
              _onIntroEnd(context);
            },
            child: const Text(
              'Laten we beginnen!',
              style: TextStyle(color: Colors.white),
            ),
            color: colordarkgreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "Another title page",
        //   body: "Another beautiful body text for this example onboarding",
        //   image: _buildImage('img2'),
        //   decoration: pageDecoration,
        // ),
        // PageViewModel(
        //   title: "Title of last page",
        //   bodyWidget: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   image: _buildImage('img1'),
        //   decoration: pageDecoration,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Sla over'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Start!', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: colordarkgreen,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: const Center(child: Text("This is the screen after Introduction")),
//     );
//   }
// }
