//import 'package:cobacobi/dashboard.dart';
//import 'package:cobacobi/login.dart';
import 'package:cobacobi/pages.dart';
import 'package:cobacobi/router.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDos in Flutter',
      initialRoute: Pages.Splash,
      // routes: {
      //   "/": (context) => LoginPage(),
      //   "/dashboard": (context) => ToDoScreen()
      // },
      onGenerateRoute: Router().getRoute,
    );
  }
}