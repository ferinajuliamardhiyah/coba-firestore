import 'dart:async';
import 'package:cobacobi/dashboard.dart';
import 'package:cobacobi/pages.dart';
import 'package:cobacobi/profile.dart';
import 'package:cobacobi/todo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetChoices = <Widget>[
    ToDoScreen(),
    ProfileScreen(),
    ProfileScreen()
  ];


  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<FormData> photo({path, name}) async {
    return FormData.fromMap({
      "photo": await MultipartFile.fromFile(path, filename: "user-photo"),
      "name": name,
      "favorite": false,
    });
  }

  handleTodo(todo, path) {
    Todo.postTodo(photo(name: todo, path: path));
  }

  // editTodos(Todo todo, index) {
  //   Todo.editTodo({"name": todo.name}, todo.id);
  // }

  // checkList(val, index) {
  //   setState(() {
  //     todos[index].favorite = val;
  //   });
  //   Todo.editTodo({'favorite': val}, todos[index].id);
  // }

  // checkListAll(val) {
  //   setState(() {
  //     for (var i in todos) {
  //       i.favorite = val;
  //       Todo.editTodo({'favorite': val}, i.id);
  //     }
  //     allCheck = val;
  //   });
  // }

  // deleteAll() {
  //   setState(() {
  //     for (var i in todos) {
  //       if (i.favorite) {
  //         Todo.removeTodo(i.id);
  //         getTodos();
  //       }
  //     }
  //     allCheck = false;
  //   });
  // }

  // int jumlahChecked() {
  //   int jumlah = 0;
  //   setState(() {
  //     for (var item in todos) {
  //       if (item.favorite) {
  //         jumlah++;
  //       }
  //     }
  //   });
  //   return jumlah;
  // }

  @override
  Widget build(BuildContext context) {
    Container _buttonNav(int index, IconData ikon) =>
     Container(
       decoration: BoxDecoration(shape: BoxShape.circle, 
        color: _selectedIndex == index
        ? Colors.red
        : Colors.white),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: IconButton(
          color: _selectedIndex == index
          ? Colors.white
          : Colors.blue,
          icon: Icon(ikon),
          iconSize: _selectedIndex == index
          ? 30.0
          : 25.0,
          onPressed: () {
            _onItemTap(index);
          },
        ),
     );
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Center(
        child: _widgetChoices.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buttonNav(0, Icons.today),
            _buttonNav(1, Icons.person),
            _buttonNav(2, Icons.people)
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
                context,
                // MaterialPageRoute(
                //   builder: (context) => AddList(handleTodo),
                // )
                Pages.Add,
                arguments: {'handleTodo': handleTodo});
          },
          child: Icon(Icons.add))
    );
  }
}