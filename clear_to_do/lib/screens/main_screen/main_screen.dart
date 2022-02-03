// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: headingTaskList.length,
          itemBuilder: (context, index) {
            int val = (255 - (index * 30));
            if (val <= 0) val = 0;
            var _text = headingTaskList[index]['name'].toString();
            var _args = headingTaskList[index]['task'];

            return Container(
              color: Color.fromRGBO((val), 0, 0, 1),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                onTap: () {
                  // Navigator.pushNamed(context, MainSubScreen.id);
                  Navigator.of(context)
                      .pushNamed('/mainSubScreen', arguments: _args);
                },
                onLongPress: () {
                  setState(() {
                    headingTaskList.removeAt(index);
                    print('Long Pressed at index: $index');
                  });
                },
                title: Text(
                  _text,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
