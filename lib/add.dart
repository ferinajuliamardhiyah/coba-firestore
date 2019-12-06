import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cobacobi/pages.dart';
import 'package:flutter/material.dart';

class AddList extends StatefulWidget {
  final handleTodo;

  AddList(this.handleTodo);

  AddListState createState() => AddListState(handleTodo);
}

class AddListState extends State<AddList> {
  final handleTodo;

  AddListState(this.handleTodo);

  CameraDescription firstCamera;
  String path;

  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCamera();
  }

  getCamera() async {
    final cameras = await availableCameras();
    setState(() {
      firstCamera = cameras.first;
    });
  }

  navigateAndGetPhoto() async {
    final result = await Navigator.pushNamed(context, Pages.Camera,
        arguments: {'camera': firstCamera});
    setState(() {
      path = result;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add List')),
        body: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(helperText: 'Tuliskan Tugas Baru'),
                // onSubmitted: (val) {
                //   handleTodo(val);
                //   Navigator.pop(context);
                // },
              ),
            ),
            Container(
              child: path != null
              ? Image.file(File(path))
              : IconButton(
                icon: Icon(Icons.camera_enhance),
                onPressed: navigateAndGetPhoto,
              )
            ),
            RaisedButton(
              onPressed: (){
                handleTodo(descriptionController.text, path);
                Navigator.pop(context);
              },
              child: Text('Add Todo User'),
            )
          ]
        ));
  }
}
