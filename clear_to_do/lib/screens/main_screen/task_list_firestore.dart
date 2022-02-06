// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, no_logic_in_create_state, todo, recursive_getters
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
  final String parentId;

  const TaskList({Key? key, required this.parentId}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState(parentId);
}

class _TaskListState extends State<TaskList> {
  _TaskListState(this.parentId);

  // Object? get parentId => parentId;
  String parentId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(parentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  print(parentId);
                },
                child: Text('click to print parent id'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(color: Colors.amber),
            ),
            ListGenerator(
              parentId: parentId,
            )
          ],
        ),
      ),
    );
  }
}

class ListGenerator extends StatelessWidget {
  final String parentId;
  ListGenerator({required this.parentId});

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: TasklListStreams(
        id: parentId,
        firebaseFirestore: firebaseFirestore,
      ),
    );
  }
}

class TasklListStreams extends StatelessWidget {
  const TasklListStreams({
    Key? key,
    required this.firebaseFirestore,
    required this.id,
  }) : super(key: key);

  final FirebaseFirestore firebaseFirestore;
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseFirestore
          .collection('collection')
          .doc(id)
          .collection('tasks')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data?.docs.length);

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
    );
  }
}
