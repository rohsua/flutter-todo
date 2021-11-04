import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/database.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  int colorIndex = 0;
  int categoryIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.todo.title;
    memoController.text = widget.todo.memo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  widget.todo.title = nameController.text;
                  widget.todo.memo = memoController.text;

                  await dbHelper.insertTodo(widget.todo);
                  Navigator.of(context).pop(widget.todo);
                },
                child: Text(
                  "저장",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: ListView.builder(
          itemBuilder: (ctx, idx) {
            if (idx == 0) {
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text("제목", style: TextStyle(fontSize: 20)));
            } else if (idx == 1) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: nameController,
                  ));
            } else if (idx == 2) {
              return InkWell(
                  onTap: () {
                    List<Color> colors = [
                      Color(0xFF00d3f4),
                      Color(0xFFa794fa),
                      Color(0xFFfb91d1),
                      Color(0xFFfb8a94),
                      Color(0xFFfebd9a),
                      Color(0xFF51e29d),
                      Color(0xFFFFFFFF)
                    ];

                    widget.todo.color = colors[colorIndex].value;
                    colorIndex++;
                    setState(() {
                      colorIndex = colorIndex % colors.length;
                    });
                  },
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "색상",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                              width: 20,
                              height: 20,
                              color: Color(widget.todo.color))
                        ],
                      )));
            } else if (idx == 3) {
              return InkWell(
                onTap: () {
                  List<String> category = ["공부", "운동", "게임"];
                  widget.todo.category = category[categoryIndex];
                  categoryIndex++;
                  setState(() {
                    categoryIndex = categoryIndex % category.length;
                  });
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "카테고리",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(widget.todo.category)
                      ],
                    )),
              );
            } else if (idx == 4) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    "메모",
                    style: TextStyle(fontSize: 20),
                  ));
            } else if (idx == 5) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  child: TextField(
                    controller: memoController,
                    maxLines: 10,
                    minLines: 10,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ));
            }
            return Container();
          },
          itemCount: 6,
        ));
  }
}
