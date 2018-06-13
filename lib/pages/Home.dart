import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/model/list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<String>> items = [];
  List<ListItem> li = [];
  List<String> AllKeys = [];
  String item;

  @override
  void initState() {
    loadData();
  }

  FirebaseUser user;
  DatabaseReference ref;

  void loadData() async {
    items = [];
    user = await FirebaseAuth.instance.currentUser();
    ref = FirebaseDatabase.instance.reference();
    ref.child('to-do/${user.uid}').onValue.listen((evt) {
      li = [];
      AllKeys = [];
      if (evt.snapshot.value == null) {
        showInSnackBar('No Wiork to Show');
        return;
      }
      DataSnapshot data = evt.snapshot;
      var keys = data.value.keys;
      var todo = data.value;
      for (var key in keys) {
        li.add(new ListItem(
            title: '${todo[key]['name'] ?? 'NO Title'}',
            date: '${todo[key]['date']}',
            time: '${todo[key]['time']}'));
        print(key.toString());
        AllKeys.add(key);
      }
      setState(() {});
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text('TODO App'),
        actions: <Widget>[
          new PopupMenuButton(
            itemBuilder: (_) => <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                    child: const Text('Github'),
                    value: 'github',
                  ),
                  new PopupMenuItem<String>(
                      child: const Text('About'), value: 'about'),
                  new PopupMenuItem<String>(
                      child: const Text('Logout'), value: 'logout'),
                ],
            onSelected: (val) {
              switch (val) {
                case 'logout':
                  FirebaseAuth.instance
                      .signOut()
                      .then((data) => Navigator.pop(context));
              }
            },
          )
        ],
      ),
      body: new Center(
        child: li.length == 0
            ? new Text(
                'No work to Do',
                style: Theme.of(context).textTheme.headline,
              )
            : showUI(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/Add'),
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget showUI() {
    return new ListView.builder(
      itemCount: li.length,
      itemBuilder: (_, index) {
        return new Dismissible(
          key: ObjectKey(li[index]),
          child: new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 4.0),
            child: li[index],
          ),
          onDismissed: (direction) {
            print('${index}');
            print('Keys ${AllKeys[index].toString()}');
            setState(() {
              li.removeAt(index);
            });
            ref.child('to-do/${user.uid}/${AllKeys[index]}').remove();
            AllKeys.removeAt(index);
          },
          background: new Container(
            color: Colors.red,
          ),
          secondaryBackground: new Container(
            color: Colors.red,
          ),
        );
      },
    );
  }
}
