//import 'package:cobacobi/dashboard.dart';
//import 'package:cobacobi/login.dart';
import 'package:cobacobi/pages.dart';
import 'package:cobacobi/router.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';

main() {
  //   final FirebaseApp app = await FirebaseApp.configure(
  //   name: 'test',
  //   options: const FirebaseOptions(
  //     googleAppID: '1:928426933593:android:6984188d60f9f636b26048',
  //     gcmSenderID: '928426933593',
  //     apiKey: 'AIzaSyB3SioBGTa8vlu9hMHPwA-yY8VM_2H518k',
  //     projectID: 'todo-app-83a1d',
  //   ),
  // );
  //final Firestore firestore = Firestore(app: app);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDos with Firestore',
      initialRoute: Pages.Splash,
      // routes: {
      //   "/": (context) => LoginPage(),
      //   "/dashboard": (context) => ToDoScreen()
      // },
      onGenerateRoute: Router().getRoute,
    );
  }
}