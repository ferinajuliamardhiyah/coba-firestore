import 'package:cobacobi/add.dart';
import 'package:cobacobi/detail.dart';
import 'package:cobacobi/edit.dart';
import 'package:cobacobi/todo.dart';
import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<Todo> todos;
  bool allCheck = false;
  bool loading = true;

  void getTodos() async {
    var response = await Todo.getTodos();
    setState(() {
      todos = response;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  handleTodo(todo) {
    Todo.postTodo({'name': todo, 'favorite': false});
    getTodos();
  }

  editTodos(Todo todo, index) {
    Todo.editTodo({"name": todo.name}, todo.id);
  }

  checkList(val, index) {
    setState(() {
      todos[index].favorite = val;
    });
    Todo.editTodo({'favorite': val}, todos[index].id);
  }

  checkListAll(val) {
    setState(() {
      for (var i in todos) {
        i.favorite = val;
        Todo.editTodo({'favorite': val}, i.id);
      }
      allCheck = val;
    });
  }

  deleteAll() {
    setState(() {
      for (var i in todos) {
        if (i.favorite) {
          Todo.removeTodo(i.id);
          getTodos();
        }
      }
      allCheck=false;
    });
  }

  int jumlahChecked() {
    int jumlah = 0;
    setState(() {
      for (var item in todos) {
        if (item.favorite) {
          jumlah++;
        }
      }
    });
    return jumlah;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('To Do List'),
        ),
        body: Column(children: <Widget>[
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BuildButtonComponent(
                  Colors.green, Icons.check, 'Done', jumlahChecked()),
              BuildButtonComponent(Colors.orange, Icons.calendar_today, 'Todo',
                  todos.length - jumlahChecked()),
              BuildButtonComponent(
                  Colors.blue, Icons.person_outline, 'Total', todos.length)
            ],
          )),
          Container(
              child: todos.length == 0
                  ? Text('No Data(s) Yet. Please Add New One',
                      style: TextStyle(fontSize: 20))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Check All'),
                                Checkbox(
                                  value: allCheck,
                                  onChanged: (bool val) {
                                    checkListAll(val);
                                  },
                                ),
                              ],
                            ),
                          ),
                          RaisedButton.icon(
                              color: Colors.white,
                              icon: Icon(Icons.delete, color: Colors.red),
                              label: Text('Delete All Checked',
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                deleteAll();
                              })
                        ])),
          Expanded(
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: ValueKey(todos[index]),
                      onDismissed: (direction) {
                        Todo.removeTodo(todos[index].id);
                        todos.removeAt(index);
                        getTodos();
                      },
                      child: Card(
                          child: ListTile(
                        leading: Checkbox(
                          value: todos[index].favorite,
                          onChanged: (bool newValue) {
                            todos[index].favorite = newValue;
                            checkList(newValue, index);
                            if (todos[index].favorite == false) {
                              allCheck = false;
                            }
                            var jum = 0;
                            for (var i = 0; i < todos.length; i++) {
                              if (todos[i].favorite == true) {
                                jum++;
                              }
                            }
                            if (jum == todos.length) {
                              allCheck = true;
                            }
                          },
                        ),
                        title: todos[index].favorite == false
                            ? Text(todos[index].name)
                            : Text(todos[index].name,
                                style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough)),
                        onLongPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditList(
                                      todos: todos[index],
                                      index: index,
                                      editTodo: editTodos)));
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(todo: todos[index])));
                        },
                      )));
                }),
          )
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddList(handleTodo),
                  ));
            },
            child: Icon(Icons.add)));
  }
}

class BuildButtonComponent extends StatelessWidget {
  final icon;
  final color;
  final label;
  final int jumlah;
  BuildButtonComponent(this.color, this.icon, this.label, this.jumlah);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
            child: Column(
      children: <Widget>[
        Text(label,
            style: TextStyle(
              fontSize: 40,
              color: color,
            )),
        Icon(icon, color: color, size: 60),
        Text(jumlah.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
      ],
    )));
  }
}
