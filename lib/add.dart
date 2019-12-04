import 'package:flutter/material.dart';

class AddList extends StatelessWidget {
  final handleTodo;

  AddList(this.handleTodo);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Add List')
      ),
      body: Container(
        child: TextField(
          decoration: InputDecoration(
            helperText: 'Tuliskan Tugas Baru'
          ),
          onSubmitted: (val) {
            handleTodo(val);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
  
}