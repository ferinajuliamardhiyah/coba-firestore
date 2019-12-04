import 'package:cobacobi/todo.dart';
import 'package:flutter/material.dart';

class EditList extends StatelessWidget {
  final Todo todos;
  final index;
  final editTodo;

  EditList({Key key, @required this.todos, this.index, this.editTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit List')),
      body: Container(
          child: TextFormField(
        initialValue: todos.name,
        onFieldSubmitted: (val) {
          Todo tu = Todo(val);
          editTodo(tu, index);
          Navigator.pop(context);
        },
      )),
    );
  }
}
