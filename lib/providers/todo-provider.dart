// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_import, file_names

import 'dart:collection';
import 'dart:convert'; //json

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo-item-dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoItemModel> _todos = [
    // TodoItemModel(0, "Số 0", "descrip 0", "2021-11-17", "21:50", true),
    // TodoItemModel(1, "Số 1", "descrip 1", "2021-11-17", "21:50", false),
    // TodoItemModel(2, "Số 2", "descrip 2", "2021-11-17", "22:10", false),
    // TodoItemModel(3, "ahihi", "1 với 1 là 5", "2021-11-18", "09:10", true),
    //  TodoItemModel(4, "hi", "với", "2021-11-19", "22:18", false),
    // TodoItemModel(5, "5 Nè", "descrip5", "2021-11-18", "21:50", true),
    // TodoItemModel(6, "6 Đây", "descrip 6 với", "2021-11-19", "21:50", false),
    // TodoItemModel(7, "title7", "descrip 7", "2021-11-19", "22:10", false),
    // TodoItemModel(8, "Học bài", "1 với 1", "2021-11-21", "22:10", true),
    // TodoItemModel(9, "hi", "là", "2021-01-12", "22:10", false),
  ];
  // final int _counter = 0;

  // int get counter => _counter;

  void saveSharedPreferences() async {
    final prefso = await SharedPreferences.getInstance();
    String jsonTodos = jsonEncode(_todos);
    prefso.setString("_todos", jsonTodos);
  }

  void getSharedPreferences() {
    // // final SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
    //  final prefs = await SharedPreferences.getInstance();
    // //prefs.remove("_todos");
    // String jsonTodos = jsonEncode(_todos);
    // String storeTodos = prefs.getString("_todos") ?? jsonTodos;
    // List<dynamic> parsedListJson = jsonDecode(storeTodos);
    // List<TodoItemModel> itemsList = List<TodoItemModel>.from(
    //     parsedListJson.map((i) => TodoItemModel.fromJson(i)));
    // _todos = itemsList;
    SharedPreferences.getInstance().then((prefs){
      String jsonTodos = jsonEncode(_todos);
      String storeTodos = prefs.getString("_todos") ?? jsonTodos;
      List<dynamic> parsedListJson = jsonDecode(storeTodos);
      List<TodoItemModel> itemsList = List<TodoItemModel>.from(
          parsedListJson.map((i) => TodoItemModel.fromJson(i)));
      _todos = itemsList;
    });
  }
  
  List<TodoItemModel> get todos {
     getSharedPreferences();
     return _todos;
  } 
  int get lastId => _todos.isNotEmpty ? _todos[_todos.length - 1].id : 0;

  void add(TodoItemModel todo) {
    _todos.add(todo);
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
