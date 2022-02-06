// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreenFirebase extends StatefulWidget {
  static const String id = 'mainScreenFirebaseFirebase';

  @override
  _MainScreenFirebaseState createState() => _MainScreenFirebaseState();
}

FirebaseFirestore _tasks = FirebaseFirestore.instance;

class _MainScreenFirebaseState extends State<MainScreenFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.amber,
                child: ElevatedButton(
                  child: Text('add'),
                  onPressed: () async {
                    var x = await _tasks
                        .collection('tasks')
                        .add({'name': 'Latest list with id', 'id': 1});
                    print(x);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: StreamsLists(),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamsLists extends StatefulWidget {
  @override
  State<StreamsLists> createState() => _StreamsListsState();
}

class _StreamsListsState extends State<StreamsLists> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = [];
          final lists = snapshot.data?.docs;
          // print('''
          //       snapshot.data?.docs.length : ${snapshot.data?.docs.length}
          //       snapshot.data?.docs[0] : ${snapshot.data?.docs[0]}
          //       ''');
          for (var item in lists!) {
            var x = item['name'];
            // print(item.id);
            list.add(x);
          }

          return ListView.builder(
            // itemCount: list.length,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              int val = (255 - (index * 30));
              if (val <= 0) val = 0;
              String title = snapshot.data?.docs[index]['name'];
              return Container(
                color: Color.fromRGBO((val), 0, 0, 1),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  onTap: () async {
                    print(snapshot.data?.docs[index]['name']);
                    deleteTask(snapshot.data?.docs[index].id);
                  },
                  onLongPress: () {
                    Navigator.pushNamed(context, TaskList.id);
                  },
                  title: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<void> deleteTask(doc) async {
    return _firebaseFirestore
        .collection('tasks')
        .doc(doc)
        .delete()
        .then((value) => print('deleted'))
        .onError((error, stackTrace) => print(error));

    /*
                                      
                                  Future<void> deleteUser() {
                                    return users
                                      .doc('ABC123')
                                      .delete()
                                      .then((value) => print("User Deleted"))
                                      .catchError((error) => print("Failed to delete user: $error"));
                                  }
                                      */
  }
}
