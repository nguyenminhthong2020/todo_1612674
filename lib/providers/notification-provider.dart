// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_import, file_names

import 'dart:collection';
import 'dart:convert'; //json

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo-item-dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationService _notificationService = NotificationService();
  void add(int id, String body, DateTime dateTime) {
    var scheduledDate = dateTime.subtract(
        Duration(minutes: 10),
      );
    _notificationService.myScheduleNotification(id, "Upcoming task",body, scheduledDate);
    notifyListeners();
  }

  void remove(int id){
    _notificationService.cancelNotification(id);
  }
}
