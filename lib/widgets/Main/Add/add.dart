// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';
import 'package:todo_1612674/models/todo-item-dto.dart';
import 'package:todo_1612674/providers/notification-provider.dart';
import 'package:todo_1612674/providers/todo-provider.dart';
import '../../../service/notification_service.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);
  static const routeName = '/add-screen';

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _date = (new DateTime.now()).toString().substring(0, 10);
  String _time = DateFormat('Hm').format(new DateTime.now()).toString();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.green[700],
    ),
    child: Text(
      "Item successfully added !",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add an item',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.blue,
          ],
        )),
        child: Form(
          key: formKey,
          child: ListView(scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "   Title: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Expanded(
                          child: TextFormField(
                        initialValue: _title,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          } else
                            return null;
                        },
                        onSaved: (value) => setState(() {
                          if (value != null) {
                            _title = value;
                          }
                        }),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "   Description: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Expanded(
                          child: Container(
                        child: TextFormField(
                          initialValue: _description,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Required";
                            } else
                              return null;
                          },
                          onSaved: (value) => setState(() {
                            if (value != null) {
                              _description = value;
                            }
                          }),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "   Date: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Expanded(
                        child: DateTimePicker(
                          initialValue: (new DateTime.now())
                              .toString()
                              .substring(0, 10), //'1998-10-27',
                          dateMask: 'yyyy-MM-dd',
                          firstDate: DateTime(1920),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Date',
                          onChanged: (val) {
                            _date = val.toString();
                          },
                          validator: (val) {
                          },
                          onSaved: (val) {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "   Time: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          initialValue:
                              DateFormat('Hm').format(new DateTime.now()),
                          dateMask: 'hh:mm',
                          timeLabelText: "Time",
                          use24HourFormat: true,
                          locale: Locale('en', 'US'),
                          onChanged: (val) {
                            _time = val.toString();
                          },
                          validator: (val) {
                          },
                          onSaved: (val) {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final bool isValid =
                                  formKey.currentState!.validate();
                              if (isValid) {
                                formKey.currentState?.save();

                                fToast.showToast(
                                    child: toast,
                                    gravity: ToastGravity.CENTER,
                                    toastDuration: Duration(seconds: 2));

                                int lastId =
                                    context.read<TodoProvider>().lastId;
                                TodoItemModel newItem = TodoItemModel(
                                    lastId + 1,
                                    _title,
                                    _description,
                                    _date,
                                    _time,
                                    false);

                                int year =
                                    int.parse(newItem.date.substring(0, 4));
                                int month =
                                    int.parse(newItem.date.substring(5, 7));
                                int day =
                                    int.parse(newItem.date.substring(8, 10));
                                int hour = int.parse(
                                    newItem.time.substring(0, 2)); //15:20
                                int minute =
                                    int.parse(newItem.time.substring(3, 5));
                                DateTime dateTime = new DateTime(
                                    year, month, day, hour, minute);

                                context
                                    .read<NotificationProvider>()
                                    .add(newItem.id, newItem.title, dateTime);
                                context.read<TodoProvider>().add(newItem);
                              }
                            },
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 45),
                              primary: Colors.purple,
                              textStyle: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
