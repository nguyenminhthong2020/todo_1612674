// ignore_for_file: prefer_const_constructors, unused_import

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_1612674/models/todo-item-dto.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import '../widgets/Main/Notification/notification.dart';
import '../widgets/Main/Home/home.dart';
// import 'package:todo_1612674/';

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

    //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
  
  Future<void> init(context) async {

    //Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialization Settings for iOS 
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
      // if (payload != null) {
      //   print('the id of the user you get the msg from is : $payload');
        // await Navigator.pushNamed(
        //   context,
        //   '/chatScreen',
        //   arguments: payload,
        // );
        await Navigator.of(context).pushNamed(Notifications.routeName);
      //}
    }
    );
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }



  Future selectNotification(String payload) async {
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );

    // https://github.com/nimblehq/flutter-showcases/blob/1b5d8bb06bd4c1e6bd8ef43d647e0a052df727e7/packages/deeplink_and_push_notification/lib/core/router/navigation_manager.dart
    // https://github.com/Simon1PL/Inzynierka/blob/6e0e6078c9db2686d4fc22672e59ad21e0926ab2/lib/main.dart
    // https://github.com/teamprodev/flutter_RestoBox_DeliveryBoy_1_30/blob/28d44d2b2c7ef10e44763bbf048ac21d2578d854/lib/services/firebase.service.dart
    // https://github.com/AlessandroArezzo/subscribe_together/blob/836f1fd8c1f16bd8e8d41e29060ddad0fe7b00db/lib/Service/NotificationService.dart
    // https://github.com/WSIB-Innovation/wsib-notifs/blob/4f48c0751dc6e166a884e27012c2953252ea65af/lib/services/notification_service.dart
    // https://github.com/VCoklat/Arungirasa-mobile/blob/beaa47bd2b454ce5d1ff7bbee06836f13227d640/lib/service/notification_service.dart
    // https://github.com/martru118/alarmdar/blob/57e52136935c026f147a04e7b41973c21b96b35f/lib/util/notifications.dart
    // https://github.com/DrozdAllan/FlutterTutorials/blob/11a92bd435570d0597f88f106af75ae4bcf5716a/lib/services/notification_service.dart
    // https://github.com/RaviPenikelapati/Creww-App/blob/d7c0ba0ae163379aff026535df97478028764042/lib/services/notification_service.dart
    
  }

  Future<void> mySelectNotification(String? payload) async {
  // BuildContext context = Home().build(context);
  //navigatorKey
  //await Navigator.push(context, MaterialPageRoute(builder: (_) => Notifications()));
  }

  static const AndroidNotificationDetails _androidNotificationDetails = AndroidNotificationDetails(
    'channel ID',
    'channel name',
    channelDescription: 'your channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static const IOSNotificationDetails _iosNotificationDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    badgeNumber: 0,
  );

  static const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iosNotificationDetails,
  );

  Future<void> showNotification(TodoItemModel todo) async {
    String title = '"${todo.title}" at ${todo.time}';
    await flutterLocalNotificationsPlugin.show(todo.id, title, todo.description, platformChannelSpecifics,
        payload: 'Notification Payload');
  }
  Future showNotification1({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      flutterLocalNotificationsPlugin.show(id, title, body, await NotificationDetails(),
          payload: payload);


  Future<void> scheduleNotification(TodoItemModel todo) async {
    // if (!todo.hasNotification) {
    //   return;
    // }
    String title = '${todo.title} at ${todo.time}';
    
    //tz.TZDateTime scheduledDate = tz.TZDateTime.from(todo.scheduledNotificationAt, tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        todo.id, title, todo.description, scheduledDate, platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> myScheduleNotification(int id, String title, String body, DateTime scheduledDate) async{
       //print("hàm future myScheduleNotification nè");
       await flutterLocalNotificationsPlugin.zonedSchedule(
       id, title, body, 
       tz.TZDateTime.from(scheduledDate, tz.local),
       platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      //  notificationDetails, 
      //  uiLocalNotificationDateInterpretation: uiLocalNotificationDateInterpretation, 
      //  androidAllowWhileIdle: androidAllowWhileIdle
       );
  }

  Future showScheduledNotifications({
    int id = 0,
    String? title,
    String? body,
    // String? payload,
    required DateTime scheduledDate,
  }) async =>
      flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await NotificationDetails(),
        payload: "Don't miss it!",
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  Future<void> cancelNotifications(List<int> ids) async {
    List<Future> futures = [];
    for (var i = 0; i < ids.length; i++) {
      futures.add(flutterLocalNotificationsPlugin.cancel(ids[i]));
    }
    await Future.wait(futures);
  }

  void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
  void cancelNotification(int id) => flutterLocalNotificationsPlugin.cancel(id);
}