// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:clear_to_do/screens/main_screen/main_screen.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'utils/routes_generator.dart';

void main() => runApp(ClearToDo());

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
      initialRoute: MainScreen.id,
      routes: {
        SplashScreen.id : (context) => SplashScreen(),
        MainScreen.id : (context) => MainScreen(),
        MainSubScreen.id : (context) => MainSubScreen(list: null,)
      },
      onGenerateRoute: RoutGenerator.generateRoute,
    );
  }
}
