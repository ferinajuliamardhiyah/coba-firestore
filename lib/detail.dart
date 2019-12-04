import 'package:cobacobi/todo.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  
  final Todo todo;

  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${todo.name}'),
        ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text('${todo.id}'),
            Text('${todo.address}'),
          ],
        )
      ),
    );
  }
}