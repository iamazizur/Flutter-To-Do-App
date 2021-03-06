// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:clear_to_do/screens/main_screen/main_screen.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_screen/main_screen_firebase.dart';
import 'screens/main_screen/task_list_firestore.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/routes_generator.dart';
import 'firebase_options.dart';
//must import
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ClearToDo());
}

class ClearToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Clear To Do',
      initialRoute: MainScreenFirebase.id,
      routes: {
        TaskList.id: (context) => TaskList(
              parentId: '',
            ),
        MainScreenFirebase.id: (context) => MainScreenFirebase(),
        SignInScreen.id: (context) => SignInScreen(),
        Signup.id: (context) => Signup(),
        SplashScreen.id: (context) => SplashScreen(),
        MainScreen.id: (context) => MainScreen(),
        MainSubScreen.id: (context) => MainSubScreen(
              list: null,
            )
      },
      onGenerateRoute: RoutGenerator.generateRoute,
    );
  }
}
