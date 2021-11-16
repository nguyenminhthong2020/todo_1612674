// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import '../../../models/todo-item-dto.dart';
import '../../_common/todo-item.dart';

class Today extends StatefulWidget {
  const Today({Key? key}) : super(key: key);
  static const routeName = '/today-screen';

  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final formKey = GlobalKey<FormState>();
  final _todos = <TodoItemModel>[
    TodoItemModel(0, "title0", "descrip0", "2021-11-16", "21:50", true),
    TodoItemModel(1, "title1", "descrip1", "2021-11-16", "21:50", false),
    TodoItemModel(2, "title2", "descrip2", "2021-11-16", "22:10", false),
    TodoItemModel(3, "title3", "descrip3", "2021-11-17", "21:50", true),
    TodoItemModel(4, "title4", "descrip4", "2021-11-17", "21:50", false),
    TodoItemModel(5, "title5", "descrip5", "2021-11-18", "22:10", false),
  ];
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    Widget _buildTodoAllList() {
      String _searchQueryLower = _searchQuery.toLowerCase();
      String _date = (new DateTime.now()).toString().substring(0, 10);
      //print(_date);
      List<Widget> listTodo = [];
      for (var todo in _todos) {
        if (todo.title.contains(_searchQueryLower) ||
            todo.description.contains(_searchQueryLower)) {
          if (_date == todo.date) {
            listTodo.add(TodoItem(
              id: todo.id,
              title: todo.title,
              description: todo.description,
              date: todo.date,
              time: todo.time,
              isDone: todo.isDone,
            ));
          }
        }
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: listTodo,
      );
    }

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Form(
              key: formKey,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      width: 200,
                      height: 45,
                      child: Expanded(
                          child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        initialValue: _searchQuery,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          return null;
                        },
                        onChanged: (value) => setState(() {
                          if (value != null) {
                            _searchQuery = value;
                          }
                        }),
                        onSaved: (value) => setState(() {
                          if (value != null) {
                            _searchQuery = value;
                          }
                        }),
                      )),
                    ),
                  ],
                ),
              ),
            )
          ],
          titleSpacing: 0,
          title: const Text(
            'Today',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          toolbarHeight: 60,
          backgroundColor: Colors.purple,
        ),
        backgroundColor: Colors.grey[400],
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 15, right: 15),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [_buildTodoAllList()],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
