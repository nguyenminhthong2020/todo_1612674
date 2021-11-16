// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({Key? key}) : super(key: key);
  static const routeName = '/upcoming-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Icon(Icons.notifications),
          )
        ],
        titleSpacing: 0,
        title: const Text(
          'Upcoming',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add nè");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.grey[400],
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.all_inbox),
                        SizedBox(width: 10,),
                        Text("Upcoming", style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.today),
                        SizedBox(width: 10,),
                        Text("Today", style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        SizedBox(width: 10,),
                        Text("Upcoming", style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
