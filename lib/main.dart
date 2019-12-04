import 'package:cobacobi/dashboard.dart';
import 'package:cobacobi/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDos in Flutter',
      initialRoute: '/dashboard',
      routes: {
        "/": (context) => LoginPage(),
        "/dashboard": (context) => ToDoScreen()
      },
    );
  }
}