import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/Theme/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static const String logo =
      'https://seeklogo.com/images/A/angular-logo-B76B1CDE98-seeklogo.com.png';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController controllerEmail = new TextEditingController();
  final TextEditingController controllerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new SingleChildScrollView(child: RegisterUI(context)),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  RegisterNew() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (Validate) {
      auth
          .createUserWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text)
          .then((user) {
            showInSnackBar('Register Successfully !');
                Navigator.popAndPushNamed(context, 'Home');
      }).catchError(
        (onError) => showInSnackBar('Something went Wrong !'),
      );
    }
  }

  bool get Validate {
    String email = controllerEmail.text;
    String password = controllerPassword.text;
    if (email.length != 0 || password.length != 0) {
      return true;
    } else {
      showInSnackBar('Email and Password Field are Required !');
      return false;
    }
  }

  final FocusNode myFocusNode = new FocusNode();

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget RegisterUI(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Container(
      decoration: new BoxDecoration(
        gradient: AppTheme.gradient,
      ),
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
      height: screenSize.height,
      child: new Column(
        children: <Widget>[
          new Padding(
            child: new Center(
              child: new Image.network(
                logo,
                height: 120.0,
                width: 120.0,
              ),
            ),
            padding: new EdgeInsets.only(top: 70.0, bottom: 40.0),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
          new Card(
            elevation: 8.0,
            child: new Container(
              padding: new EdgeInsets.all(15.0),
              child: new Column(
                children: <Widget>[
                  new Text(
                    'Register',
                    style:
                        new TextStyle(fontSize: 40.0, color: Color(0xFF3366AA)),
                  ),
                  new TextField(
                    controller: controllerEmail,
                    maxLines: 1,
                    maxLength: 32,
                    onSubmitted: (String) =>
                        FocusScope.of(context).requestFocus(myFocusNode),
                    decoration: new InputDecoration(hintText: 'E-mail ID'),
                  ),
                  new TextField(
                    controller: controllerPassword,
                    maxLines: 1,
                    maxLength: 32,
                    focusNode: myFocusNode,
                    obscureText: true,
                    decoration: new InputDecoration(hintText: 'Password'),
                  ),
                  new FlatButton(
                    color: Color(0xFF3366AA),
                    onPressed: () => RegisterNew(),
                    child: new Text(
                      'Register',
                      style: new TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 16.0)),
          new Text('Already Registered'),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text('Click here to Login'),
          ),
        ],
      ),
    );
  }
}
