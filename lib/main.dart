import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:food_app/shared/goal_cubit.dart';
import 'package:food_app/shared/search_cubit.dart';
import 'Widgets/Navigation_widget.dart';
import 'package:food_app/Services/auth_service.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/Views/sign_up_view.dart';
import 'package:food_app/Views/introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarColor: Colors.white));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => DairyCubit()..getUsersTripsList(Source.cache),
          ),
          BlocProvider(
            create: (BuildContext context) => GoalCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => SearchCubit(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test123',
          theme: ThemeData(
            primarySwatch: Colors.green,
            backgroundColor: Colors.yellow,
          ),
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
            '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
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
          if (signedIn) {
            print('auth signed in ${snapshot.data}');
            AppCubit.instance(context).createDB(snapshot.data, 'goals');
            return Home();
          } else {
            return OnBoardingPage();
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
