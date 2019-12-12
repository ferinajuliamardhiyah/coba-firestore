import 'package:cobacobi/todo.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  
  final String description;
  final String title;

  DetailScreen({Key key, @required this.description, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title')
        ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$description'),
          ],
        )
      ),
    );
  }
}