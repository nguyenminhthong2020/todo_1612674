// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_1612674/providers/todo-provider.dart';
import '../../../models/todo-item-dto.dart';
import '../../_common/todo-item.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  static const routeName = '/notifications-screen';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
      if (_todos1.isEmpty) {
        _todos1 = _todos;
      }

      DateTime dtNow = new DateTime.now();
      DateTime dtNow10 = dtNow.add(Duration(minutes: 10)); //2021-11-18 11:50
      String str_dtNow = dtNow10.toString().substring(0, 16);
    
      var listNotification =
          _todos1.where((x) => "${x.date} ${x.time}".compareTo(str_dtNow) <= 0);

      for (var todo in listNotification) {
        final str_title = todo.title.toLowerCase();
        final str_des = todo.description.toLowerCase();
        if (str_title.contains(_searchQueryLower) ||
            str_des.contains(_searchQueryLower)) {
          listTodo.add(Container(
            padding:
                const EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 10),
            margin: const EdgeInsets.only(left: 1, right: 2, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                border: Border.all(color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 270,
                      child: Flexible(
                          child: Text(todo.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blue[700]))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 270,
                      child: Flexible(child: Text(todo.description)),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      "        ${todo.date}   ${todo.time}",
                      style: TextStyle(),
                    )
                  ],
                )
              ],
            ),
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
          titleSpacing: 0,
          title: const Text(
            'Notifications',
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
