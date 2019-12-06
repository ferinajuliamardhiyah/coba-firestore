import 'dart:async';
import 'package:cobacobi/pages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  getToken() async {
    
    return Timer(Duration(seconds: 1), () async {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        return Navigator.pushReplacementNamed(context, Pages.Home);
      }

      return Navigator.pushReplacementNamed(context, Pages.Login);
    });
  }


  @override
  void initState() {
    super.initState();
    getToken();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}