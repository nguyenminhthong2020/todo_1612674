// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_1612674/providers/todo-provider.dart';
import '../../../models/todo-item-dto.dart';
import '../../_common/todo-item.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);
  static const routeName = '/all-screen';

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  final formKey = GlobalKey<FormState>();
  String _searchQuery = "";
  bool _isNull = false;
  List<TodoItemModel> _todos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    SharedPreferences.getInstance().then((prefs) {
      String storeTodos = prefs.getString("_todos") ?? "[]";
      List<dynamic> parsedListJson = jsonDecode(storeTodos);
      List<TodoItemModel> itemsList = List<TodoItemModel>.from(
          parsedListJson.map((i) => TodoItemModel.fromJson(i)));
      setState(() {
        _todos = itemsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildTodoAllList() {
      String _searchQueryLower = _searchQuery.toLowerCase();
      List<Widget> listTodo = [];
      List<TodoItemModel> _todos1 = context.watch<TodoProvider>().todos;
      if(_todos1.isEmpty){
        _todos1 = _todos;
      }
      
      for (var todo in _todos1) {
          final str_title = todo.title.toLowerCase();
          final str_des = todo.description.toLowerCase();
          if (str_title.contains(_searchQueryLower) ||
              str_des.contains(_searchQueryLower)) {
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
            'All',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          toolbarHeight: 60,
          backgroundColor: Colors.purple,
        ),
        backgroundColor: Colors.grey[300],
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
