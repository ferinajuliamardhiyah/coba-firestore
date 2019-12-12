import 'package:cobacobi/add.dart';
import 'package:cobacobi/camera.dart';
import 'package:cobacobi/dashboard.dart';
import 'package:cobacobi/detail.dart';
import 'package:cobacobi/edit.dart';
import 'package:cobacobi/home.dart';
import 'package:cobacobi/login.dart';
import 'package:cobacobi/pages.dart';
import 'package:cobacobi/profile.dart';
import 'package:cobacobi/splash_screen.dart';
import 'package:flutter/material.dart';

class Router {
  Route<dynamic> getRoute(settings) {
    Map<String, dynamic> arguments = settings.arguments;

    switch (settings.name) {
      case Pages.Splash:
       return _buildRoute(settings, SplashScreen());
      case Pages.Login:
       return _buildRoute(settings, LoginPage());
      case Pages.Home:
       return _buildRoute(settings, HomeScreen());
      case Pages.Profile:
       return _buildRoute(settings, ProfileScreen());
      case Pages.Dashboard:
       return _buildRoute(settings, ToDoScreen());
      case Pages.Add:
       return _buildRoute(settings, AddList(arguments['handleTodo']));
      case Pages.Edit:
       return _buildRoute(settings, EditList(
         title: arguments['title'],
         index: arguments['index'],
         editTodo: arguments['editTodo'],
         documentID : arguments['documentID']
       ));
      case Pages.Detail:
       return _buildRoute(settings, DetailScreen(description: arguments ['description'], title: arguments['title'],));
      // case Pages.Camera:
      //  return _buildRoute(settings, TakePictureScreen(camera: arguments['camera']));
      default:
      return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }
}