import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<DropdownMenuItem<String>> items = [];
  List<String> li = ['1', '2', '3', '4'];
  String item;

  init() {
    items = li
        .map((data) => new DropdownMenuItem(
              child: new Text('Item $data'),
              value: data,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.cyan, accentColor: Colors.blueGrey),
      home: new Scaffold(
        appBar: new AppBar(
          title: new DropdownButton(
              hint: new Text('Select'),
              value: item,
              items: items,
              onChanged: (data) {
                item = data;
              }),
          actions: <Widget>[
            new PopupMenuButton(
              itemBuilder: (_) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        child: const Text('Github'), value: 'github'),
                    new PopupMenuItem<String>(
                        child: const Text('About'), value: 'about'),
                  ],
            )
          ],
        ),
        drawer: new Drawer(),
        body: new SingleChildScrollView(
            child: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text('Login'),
                new Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
                new TextField(
                  decoration: new InputDecoration(hintText: 'E-mail ID'),
                ),
                new Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
                new TextField(
                  decoration: new InputDecoration(hintText: 'Password'),
                ),
                new Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
                new RaisedButton(
                  onPressed: () {},
                  child: new Text('Submit'),
                )
              ],
            ),
          ),
        )),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {},
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
