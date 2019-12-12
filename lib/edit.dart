import 'package:cobacobi/todo.dart';
import 'package:flutter/material.dart';

class EditList extends StatelessWidget {
  final String title;
  final index;
  final editTodo;
  final documentID;

  EditList({Key key, @required this.title, this.index, this.editTodo, this.documentID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit List')),
      body: Container(
          child: TextFormField(
        initialValue: title,
        onFieldSubmitted: (val) {
          editTodo(val, index, documentID);
          Navigator.pop(context);
        },
      )),
    );
  }
}
