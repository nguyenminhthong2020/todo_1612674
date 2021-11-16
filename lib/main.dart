// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import './widgets/Main/Home/home.dart';
import './widgets/Main/All/all.dart';
import './widgets/Main/Today/today.dart';
import './widgets/Main/Upcoming/upcoming.dart';
import './widgets/Main/Add/add.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo_1612674',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), 
        Locale('vi', ''), 
      ],
      home: Home(),
      routes: {
        Home.routeName: (ctx) => Home(),
        All.routeName: (ctx) => All(),
        Today.routeName: (ctx) => Today(),
        Upcoming.routeName: (ctx) => Upcoming(),
        Add.routeName: (ctx) => Add(),
      },
    );
  }
}
