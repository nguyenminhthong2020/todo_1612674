// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_import, file_names

import 'dart:collection';
import 'dart:convert'; //json

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo-item-dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoItemModel> _todos = [
  ];
  
  void initTodos(List<TodoItemModel> list){
     _todos = list;
  }
  //LocalStorage storage = new LocalStorage('todo_app');

  void saveSharedPreferences() async {
    final prefso = await SharedPreferences.getInstance();
    String jsonTodos = jsonEncode(_todos);
    prefso.setString("_todos", jsonTodos);

    // String jsonTodos = jsonEncode(_todos);
    // storage.setItem("_todos", jsonTodos);
  }

  void getSharedPreferences() {
    SharedPreferences.getInstance().then((prefs){
      String jsonTodos = jsonEncode(_todos);
      String storeTodos = prefs.getString("_todos") ?? jsonTodos;
      List<dynamic> parsedListJson = jsonDecode(storeTodos);
      List<TodoItemModel> itemsList = List<TodoItemModel>.from(
          parsedListJson.map((i) => TodoItemModel.fromJson(i)));
      _todos = itemsList;
    });

    // String jsonTodos = jsonEncode(_todos);
    // String storeTodos = storage.getItem("_todos") ?? jsonTodos;
    //   List<dynamic> parsedListJson = jsonDecode(storeTodos);
    //   List<TodoItemModel> itemsList = List<TodoItemModel>.from(
    //       parsedListJson.map((i) => TodoItemModel.fromJson(i)));
    //   _todos = itemsList;
  }
  
  List<TodoItemModel> get todos {
     //getSharedPreferences();
     return _todos;
  } 
  //int get lastId => _todos.isNotEmpty ? _todos[_todos.length - 1].id : 0;
  //int get lastId => _todos.isNotEmpty ? _todos[0].id : 0;

  void add(TodoItemModel todo) {
    _todos.add(todo);
    _todos.sort((x, y) => "${y.date}${y.time}".compareTo("${x.date}${x.time}"));
    saveSharedPreferences();
    notifyListeners();
  }

  void toggleDone(int id) {
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index].isDone = !_todos[index].isDone;
    saveSharedPreferences();
    notifyListeners();
  }

  void remove(int id) {
    _todos.removeWhere((element) => element.id == id);
    saveSharedPreferences();
    notifyListeners();
  }
}
