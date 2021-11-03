import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/todo.dart';

class TodoWritePage extends StatefulWidget {
  TodoWritePage({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

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
            onPressed: () {
              // todo: 페이지 저장시 사용
            },
            child: Text("저장", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
