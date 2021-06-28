import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'Widgets/Navigation_widget.dart';
import 'package:food_app/Services/auth_service.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/Views/sign_up_view.dart';
import 'package:food_app/Views/introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: BlocProvider<DairyCubit>(
        create: (BuildContext context) => DairyCubit()..getUsersTripsList(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test123',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) =>
                SignUpView(authFormType: AuthFormType.signUp),
            '/signIn': (BuildContext context) =>
                SignUpView(authFormType: AuthFormType.signIn),
            '/home': (BuildContext context) => HomeController(),
          },
        ),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : OnBoardingPage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
