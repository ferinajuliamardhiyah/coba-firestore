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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('id: ${todo.id}',textAlign: TextAlign.start),
            Text('address: ${todo.address}'),
          ],
        )
      ),
    );
  }
}