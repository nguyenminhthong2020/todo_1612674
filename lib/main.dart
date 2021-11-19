// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './widgets/Main/Home/home.dart';
import './widgets/Main/All/all.dart';
import './widgets/Main/Today/today.dart';
import './widgets/Main/Upcoming/upcoming.dart';
import './widgets/Main/Add/add.dart';
import './widgets/Main/Notification/notification.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//import 'package:provider/provider.dart';
import './service/notification_service.dart';
import './providers/todo-provider.dart';
import './providers/notification-provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localstorage/localstorage.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   runApp(
    // ChangeNotifierProvider(
    //   create: (context) => TodoProvider(),
    //   child: MyApp(),
    // ),
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => TodoProvider()),
      ChangeNotifierProvider(create: (context) => NotificationProvider())
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
        Notifications.routeName: (ctx) => Notifications(),
      },
    );
  }
}
