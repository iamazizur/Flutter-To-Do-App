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

class TaskList extends StatefulWidget {
  static const String id = 'TaskList';

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(color: Colors.amber),
            ),
            ListGenerator()
          ],
        ),
      ),
    );
  }
}

class ListGenerator extends StatelessWidget {
  // final String id;
  // const ListGenerator({required this.id});

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore
            .collection('collection')
            .doc('1pMoJRiW4jlyVPrMJhuu')
            .collection('tasks')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data?.docs.length);
            final lists = snapshot.data?.docs;
            for (var item in lists!) {
              print(item['task']);
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data!.docs[index]['task'],
                    style: TextStyle(fontSize: 40),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
