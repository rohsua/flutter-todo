import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/todo.dart';

class TodoWritePage extends StatefulWidget {
  final Todo todo;

  TodoWritePage({Key? key, required this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoWritePageState();
  }
}

class _TodoWritePageState extends State<TodoWritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "저장",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
