// ignore_for_file: unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:todo_1612674/providers/notification-provider.dart';
import 'package:todo_1612674/providers/todo-provider.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.isDone})
      : super(key: key);
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 3, right: 5, bottom: 5, top: 10),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                    shape: CircleBorder(),
                    checkColor: Colors.greenAccent,
                    value: this.isDone,
                    onChanged: (bool? val) {
                      if (val != null) {
                        context.read<TodoProvider>().toggleDone(this.id);
                      }
                    }),
              ),
              SizedBox(
                width: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                    width: 250,
                    child: Flexible(child: Text(this.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue[700]))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 250,
                    //color: Colors.yellow,
                    child: Flexible(child: Text(this.description)),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    "${this.date}   ${this.time}",
                    style: TextStyle(),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    context.read<NotificationProvider>().remove(this.id);
                    context.read<TodoProvider>().remove(this.id);
                  },
                  child: Icon(
                    Icons.delete,
                    size: 35,
                    color: Colors.red,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
