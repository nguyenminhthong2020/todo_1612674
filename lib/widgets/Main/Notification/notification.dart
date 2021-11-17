// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({ Key? key }) : super(key: key);
  static const routeName = '/notifications-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        //     child: Icon(Icons.notifications),
        //   )
        // ],
        titleSpacing: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.purple,
      ),
      body: Text("Notifications"),
    );
  }
}