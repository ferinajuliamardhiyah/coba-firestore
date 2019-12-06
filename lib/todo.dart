import 'package:dio/dio.dart';

class Todo {
  int id;
  String name;
  String address;
  bool favorite = false;
  String imageurl;

  Todo(this.name);
  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        favorite = json['favorite'],
        imageurl = json['image_url'];

  static getTodos() async {
    var result =
        await Dio().get('https://address-book-exp-api.herokuapp.com/users');
    List<Todo> todos = (result.data['data'] as List)
        .map((test) => Todo.fromJson(test))
        .toList();
    return todos;
  }

  static postTodo(data) async {
    var response = await Dio()
        .post('https://address-book-exp-api.herokuapp.com/users', data: await data);
    return response;
  }

  static editTodo(data, id) async {
    var response = await Dio().patch(
        'https://address-book-exp-api.herokuapp.com/users/$id',
        data: data);
    return response;
  }

  static removeTodo(id) async {
    var response = await Dio()
        .delete('https://address-book-exp-api.herokuapp.com/users/$id');
    return response;
  }
}
