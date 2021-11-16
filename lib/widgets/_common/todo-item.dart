// ignore_for_file: unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
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
                scale: 1.2,
                child: Checkbox(
                    checkColor: Colors.greenAccent,
                    value: this.isDone,
                    onChanged: (bool? val) {
                      if (val != null) {
                        print("select ${this.id}");
                      }
                    }),
              ),
              //  Checkbox(
              //    checkColor: Colors.greenAccent,
              //    value: this.isDone, onChanged: (bool? val){
              //     if (val != null) {
              //       print("select ${this.id}");
              //    }
              //  }),
              SizedBox(width: 1,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    this.description,
                  ),
                  Text(
                    "${this.date}   ${this.time}",
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    print("delete ${this.id}");
                  },
                  child: Icon(
                    Icons.delete,
                    size: 35,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
