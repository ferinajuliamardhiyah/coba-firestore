import 'package:cobacobi/pages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//utk bikin class yang extends StatelessWidget bisa langsung ketik 's' terus pake arrow ke atas pilih flutter stateful widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen();

  logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    Navigator.pushReplacementNamed(context, Pages.Login);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            logout(context);
          },
          child: new Icon(
            Icons.close,
            color: Colors.red,
            size: 80.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Text('LOGOUT',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
