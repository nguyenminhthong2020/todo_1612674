// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:provider/src/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';
import 'package:todo_1612674/models/todo-item-dto.dart';
import 'package:todo_1612674/providers/todo-provider.dart';

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
    //initializeDateFormatting("vi");
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
              //margin: EdgeInsets.only(left: 15, right: 15, top: 10),
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
                          //focusColor: Colors.white,
                          // icon: Icon(
                          //   Icons.phone,
                          //   color: Colors.white,
                          //   size: 32,
                          // ),
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
                        //keyboardType: TextInputType.phone,
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
                            //focusColor: Colors.white,
                            // icon: Icon(
                            //   Icons.phone,
                            //   color: Colors.white,
                            //   size: 32,
                            // ),
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
                          //keyboardType: TextInputType.phone,
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
                    // SizedBox(
                    //   height: 5,
                    // ),
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
                            // print(val);
                            //return null;
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
                    // SizedBox(
                    //   height: 5,
                    // ),
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
                            // print(val);
                          },
                          validator: (val) {
                            // print(val);
                            //return null;
                          },
                          onSaved: (val) {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      // decoration: ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final bool isValid =
                                  formKey.currentState!.validate();
                              if (isValid) {
                                formKey.currentState?.save();
                                // final message =
                                //     "${_title}, ${_description}, ${_date}, ${_time}";
                                // print(message);

                                int lastId = context.read<TodoProvider>().lastId;
                                TodoItemModel newItem = TodoItemModel(
                                    lastId + 1,
                                    _title,
                                    _description,
                                    _date,
                                    _time,
                                    false);
                                context.read<TodoProvider>().add(newItem);

                                fToast.showToast(
                                  child: toast,
                                  gravity: ToastGravity.CENTER,
                                  toastDuration: Duration(seconds: 2)
                                );
                                // Fluttertoast.showToast(
                                //     msg: "Item successfully added !",
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.TOP,
                                //     timeInSecForIosWeb: 2,

                                //     backgroundColor: Colors.green[300],
                                //     textColor: Colors.white,
                                //     fontSize: 20.0);
                                //print("add nè");
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
