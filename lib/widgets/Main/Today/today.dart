// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:todo_1612674/providers/todo-provider.dart';
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
  String _searchQuery = "";
  bool _isNull = false;

  @override
  Widget build(BuildContext context) {
    Widget _buildTodoAllList() {
      String _searchQueryLower = _searchQuery.toLowerCase();
      List<Widget> listTodo = [];
      List<TodoItemModel> _todos = context.watch<TodoProvider>().todos;
      String _date = (new DateTime.now()).toString().substring(0, 10);

      if (_todos.isEmpty) {
        return TextButton(
            onPressed: () {
              setState(() {
                _isNull = !_isNull;
              });
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.pink,
                    ),
                    child: Text(
                      "Click to load Data",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ]));
      } else {
        for (var todo in _todos) {
          final str_title = todo.title.toLowerCase();
          final str_des = todo.description.toLowerCase();
          if (str_title.contains(_searchQueryLower) ||
              str_des.contains(_searchQueryLower)) {
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
