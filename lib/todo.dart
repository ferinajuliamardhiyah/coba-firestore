import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

class Todo {
  // var id;
  String title;
  String description;
  bool status;
  //String imageurl;

  Todo(this.title, this.description, this.status);

  Todo.fromJSON(Map<String,dynamic> response)
      : title = response['title'],
        description = response['description'],
        status = response['status'];

  static getTodos() async {
    final FirebaseApp app = await FirebaseApp.configure(
    name: 'Todo-App',
    options: const FirebaseOptions(
      googleAppID: '1:928426933593:android:6984188d60f9f636b26048',
      gcmSenderID: '928426933593',
      apiKey: 'AIzaSyB3SioBGTa8vlu9hMHPwA-yY8VM_2H518k',
      projectID: 'todo-app-83a1d',
    ),
  );
  final Firestore firestore = Firestore(app: app);
  return firestore;
  }

  // static postTodo(data) async {
    
    
  //   };

  // static editTodo(data, id) async {
  //   var response = await
  //   return response;
  // }

  // static removeTodo(id) async {
    
  //   return response;
  // }
}
