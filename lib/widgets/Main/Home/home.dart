// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import '../All/all.dart';
import '../Today/today.dart';
import '../Upcoming/upcoming.dart';
import '../Add/add.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.home,
          size: 35,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Icon(Icons.notifications),
          )
        ],
        titleSpacing: 0,
        title: const Text(
          'Todo App',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Add.routeName);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
          height: 193,
          decoration: BoxDecoration(
            color: Colors.white,

          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(All.routeName);
                },
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.all_inbox),
                            SizedBox(width: 10,),
                            Text("All", style: TextStyle(fontSize: 18, color: Colors.black),),
                          ],
                        ),
                        Icon(Icons.arrow_right)
                      ],
                    ),
                  ),
                ),
              ),
              //Container(height: 1, color: Colors.grey[400],),
              OutlinedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(Today.routeName);
                },
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.today),
                            SizedBox(width: 10,),
                            Text("Today", style: TextStyle(fontSize: 18, color: Colors.black),),
                          ],
                        ),
                        Icon(Icons.arrow_right)
                      ],
                    ),
                  ),
                ),
              ),
              //Container(height: 1, color: Colors.grey[400],),
              OutlinedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(Upcoming.routeName);
                },
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule),
                            SizedBox(width: 10,),
                            Text("Upcoming", style: TextStyle(fontSize: 18, color: Colors.black),),
                          ],
                        ),
                        Icon(Icons.arrow_right)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
