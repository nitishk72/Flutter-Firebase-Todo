import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  DateTime date = new DateTime.now();
  TimeOfDay time = new TimeOfDay.now();
  TextEditingController work = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  DatabaseReference ref;
  FirebaseUser user;

  Future<Null> datep() async {
    final DateTime pick = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2022),
    );
    if (pick != null) {
      date = pick;
      print(pick.toString());
      setState(() {});
    }
  }

  Future<Null> timep() async {
    final TimeOfDay pick = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (pick != null) {
      time = pick;
      print(pick.toString());
      setState(() {});
    }
  }

  @override
  void initState() {
    initInstance();
  }

  void initInstance() async {
    ref = new FirebaseDatabase().reference();
    user = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Card(
          child: new ListView(
            padding: new EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 15.0,
            ),
            children: <Widget>[
              new Center(
                child: new Text(
                  'Add Some work',
                  style: new TextStyle(fontSize: 28.0),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new TextField(
                controller: work,
                decoration: new InputDecoration(hintText: 'Enter Work Name'),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new TextField(
                controller: desc,
                decoration: new InputDecoration(hintText: 'Enter Description'),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: new FlatButton(
                    onPressed: datep,
                    child: new Text("${date.day.toString()}/${date.month
                            .toString()}/${date
                            .year
                            .toString()}"),
                  )),
                  new Expanded(
                      child: new FlatButton(
                    onPressed: timep,
                    child: new Text("${time.hour}:${time.minute}"),
                  ))
                ],
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new RaisedButton(
                onPressed: saveToFirebase,
                child: new Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }


  void saveToFirebase() {
    Object data = {
      'name': work.text,
      'desc': desc.text,
      'date': '${date.day}/${date.month}/${date.year}',
      'time': '${time.hour}:${time.minute}',
      'status':'1'
    };
    work.clear();
    desc.clear();
    ref.child('/to-do/${user.uid}').push().set(data);
  }
}
