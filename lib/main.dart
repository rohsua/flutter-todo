import 'package:flutter/material.dart';
import 'package:todo/write.dart';

import 'data/todo.dart';
import 'data/util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [
    Todo(
        title: "패스트캠퍼스 강의듣기1",
        memo: "앱개발 입문강의 듣기",
        color: Colors.redAccent.value,
        done: 0,
        category: "공부",
        date: 20211103),
    Todo(
        title: "패스트캠퍼스 강의듣기2",
        memo: "앱개발 입문강의 듣기",
        color: Colors.blue.value,
        done: 1,
        category: "공부",
        date: 20211103)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            // todo: 화면 이동
            Todo todo = await Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => TodoWritePage(
                      todo: Todo(
                          title: "",
                          color: 0,
                          memo: "",
                          category: "",
                          done: 0,
                          date: Utils.getFormatTime(DateTime.now())),
                    )));
            setState(() {
              todos.add(todo);
            });
          },
        ),
        body: ListView.builder(
            itemBuilder: (ctx, idx) {
              if (idx == 0) {
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Text("오늘하루",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)));
              } else if (idx == 1) {
                List<Todo> undone = todos.where((t) {
                  return t.done == 0;
                }).toList();

                return Container(
                    child: Column(
                  children: List.generate(undone.length, (_idx) {
                    Todo t = undone[_idx];

                    return InkWell(
                        onTap: () {
                          setState(() {
                            if (t.done == 0) {
                              t.done = 1;
                            } else if (t.done == 1) {
                              t.done = 0;
                            }
                          });
                        },
                        onLongPress: () async {
                          Todo todo = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => TodoWritePage(todo: t)));
                          setState(() {});
                        },
                        child: TodoCardWidget(t: t));
                  }),
                ));
              } else if (idx == 2) {
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Text("완료된 하루",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)));
              } else if (idx == 3) {
                List<Todo> done = todos.where((t) {
                  return t.done == 1;
                }).toList();

                return Container(
                    child: Column(
                  children: List.generate(done.length, (_idx) {
                    Todo t = done[_idx];
                    return InkWell(
                        onTap: () {
                          setState(() {
                            if (t.done == 0) {
                              t.done = 1;
                            } else if (t.done == 1) {
                              t.done = 0;
                            }
                          });
                        },
                        onLongPress: () async {
                          Todo todo = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => TodoWritePage(todo: t)));
                          setState(() {});
                        },
                        child: TodoCardWidget(t: t));
                  }),
                ));
              }
              return Container();
            },
            itemCount: 4),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.today_outlined), label: "오늘"),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined), label: "기록"),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더보기")
          ],
        ));
  }
}

class TodoCardWidget extends StatelessWidget {
  final Todo t;

  TodoCardWidget({Key? key, required this.t}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(t.color), borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(t.done == 0 ? "미완료" : "완료",
                    style: TextStyle(fontSize: 18, color: Colors.white))
              ],
            ),
            Container(height: 8),
            Text(t.memo, style: TextStyle(fontSize: 18, color: Colors.white))
          ],
        ));
  }
}
