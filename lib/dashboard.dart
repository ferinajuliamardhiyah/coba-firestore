import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cobacobi/pages.dart';
import 'package:cobacobi/todo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen();
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  Firestore todos;
  bool allCheck = false;
  bool loading = true;

  void getTodos() async {
    var response = await Todo.getTodos();
    setState(() {
      todos = response;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  // Future<FormData> photo({path, title}) async {
  //   return FormData.fromMap({
  //     "photo": await MultipartFile.fromFile(path, filetitle: "user-photo"),
  //     "title": title,
  //     "status": false,
  //   });
  // }

 editTodos(val, index, documentID) async {
    await Firestore.instance
        .collection('todos')
        .document(documentID)
        .updateData({'title': val});
    //Todo.editTodo({'status': val}, todos[index].id);
  }

  checkList(val, index, documentID) async {
    await Firestore.instance
        .collection('todos')
        .document(documentID)
        .updateData({'status': val});
    //Todo.editTodo({'status': val}, todos[index].id);
  }

  // deleteAll() {
  //   setState(() {
  //     for (var i in todos) {
  //       if (i.status) {
  //         Todo.removeTodo(i.id);
  //       }
  //     }
  //     allCheck = false;
  //     getTodos();
  //   });
  // }

  // int jumlahChecked() {
  //   int jumlah = 0;
  //   setState(() {
  //     for (var item in todos) {
  //       if (item.status) {
  //         jumlah++;
  //       }
  //     }
  //   });
  //   return jumlah;
  // }

  removeTodo(index, documentID) async {
    await Firestore.instance.collection('todos').document(documentID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: todos.collection('todos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          int jumlahChecked = 0;
          if (!snapshot.hasData) return const Text('Loading...');
          final int listCount = snapshot.data.documents.length;
          for (var i = 0; i < listCount; i++) {
            if (snapshot.data.documents[i]['status']) {
              jumlahChecked++;
            }
          }
          int rest = listCount - jumlahChecked;
          return Column(children: <Widget>[
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BuildButtonComponent(
                    Colors.green, Icons.check, 'Done', jumlahChecked),
                BuildButtonComponent(
                    Colors.orange, Icons.calendar_today, 'Todo', rest),
                BuildButtonComponent(
                    Colors.blue, Icons.person_outline, 'Total', listCount)
              ],
            )),
            Container(
              child: listCount == 0
                  ? Text('No Data(s) Yet. Please Add New One',
                      style: TextStyle(fontSize: 20))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Check All'),
                              Checkbox(
                                value: allCheck,
                                onChanged: (bool val) {
                                  allCheck = val;
                                  setState(() {
                                    for (var i = 0; i < listCount; i++) {
                                      checkList(val, i, snapshot.data.documents[i].documentID);
                                    }
                                    allCheck = val;
                                  });
                                },
                              ),
                            ],
                          ),
                          RaisedButton.icon(
                              color: Colors.white,
                              icon: Icon(Icons.delete, color: Colors.red),
                              label: Text('Delete All Checked',
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                setState(() {
                                  for (var i = 0; i < listCount; i++) {
                                    if (snapshot.data.documents[i]['status']) {
                                      removeTodo(
                                          i,
                                          snapshot
                                              .data.documents[i].documentID);
                                    }
                                  }
                                  allCheck = false;
                                });
                              })
                        ]),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: listCount,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot document =
                          snapshot.data.documents[index];
                      var title = document['title'];
                      var status = document['status'];
                      return Dismissible(
                          key: ValueKey(document),
                          onDismissed: (direction) {
                            removeTodo(index, document.documentID);
                          },
                          child: Card(
                              child: ListTile(
                                  trailing: Checkbox(
                                    value: status,
                                    onChanged: (bool newValue) {
                                      checkList(
                                          newValue, index, document.documentID);
                                      // if (status = false) {
                                      //   allCheck = false;
                                      // }
                                      // var jum = 0;
                                      // for (var i = 0; i < listCount; i++) {
                                      //   if (status = true) {
                                      //     jum++;
                                      //   }
                                      // }
                                      // if (jum == listCount) {
                                      //   allCheck = true;
                                      // }
                                    },
                                  ),
                                  title: status == false
                                      ? Text(title)
                                      : Text(title,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                  onLongPress: () {
                                    Navigator.pushNamed(
                                        context,
                                        // MaterialPageRoute(
                                        //     builder: (context) => EditList(
                                        //         todos: todos[index],
                                        //         index: index,
                                        //         editTodo: editTodos))
                                        Pages.Edit,
                                        arguments: {
                                          'title': title,
                                          'index': index,
                                          'editTodo': editTodos,
                                          'documentID': document.documentID
                                        });
                                  },
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        // MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         DetailScreen(todo: todos[index]))
                                        Pages.Detail,
                                        arguments: {
                                          'description':
                                              document['description'],
                                          'title': title
                                        });
                                  })));
                    }))
          ]);
        });
  }

  // bottomNavigationBar: BottomAppBar(
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: <Widget>[
  //       IconButton(icon: Icon(Icons.today) , onPressed: (){}),
  //       IconButton(icon: Icon(Icons.people), onPressed: (){})
  //     ],
  //   ),
  //   shape: CircularNotchedRectangle(),
  //   color: Colors.white,
  // ),
  // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  // floatingActionButton: FloatingActionButton(
  //     onPressed: () {
  //       Navigator.pushtitled(
  //           context,
  //           // MaterialPageRoute(
  //           //   builder: (context) => AddList(handleTodo),
  //           // )
  //           Pages.Add,
  //           arguments: {'handleTodo': handleTodo});
  //     },
  //     child: Icon(Icons.add))
}

class BuildButtonComponent extends StatelessWidget {
  final icon;
  final color;
  final label;
  final int jumlah;
  BuildButtonComponent(this.color, this.icon, this.label, this.jumlah);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
            child: Column(
      children: <Widget>[
        Text(label,
            style: TextStyle(
              fontSize: 40,
              color: color,
            )),
        Icon(icon, color: color, size: 60),
        Text(jumlah.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
      ],
    )));
  }
}
