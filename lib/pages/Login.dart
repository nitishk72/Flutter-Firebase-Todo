import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/Theme/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const String logo =
      'https://seeklogo.com/images/A/angular-logo-B76B1CDE98-seeklogo.com.png';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController controllerEmail = new TextEditingController();
  final TextEditingController controllerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new SingleChildScrollView(child: LoginUI(context)),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  LoginVerify() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (Validate) {
      auth
          .signInWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text)
          .then((user) {
        showInSnackBar('Login Success');
        Navigator.popAndPushNamed(context, '/Home');
      }).catchError(
        (onError) => showInSnackBar(onError.toString()),
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

  void checkLogin() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) if (!user.isAnonymous) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Home');
      }
    });
  }

  @override
  void initState() {
    checkLogin();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
  }

  Widget LoginUI(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Container(
      decoration: new BoxDecoration(
        gradient: AppTheme.gradient,
      ),
      height: screenSize.height,
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
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
                    'Login',
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
                  new Row(
                    children: <Widget>[
                      new FlatButton(
                        onPressed: () {},
                        child: new Text(
                          'Forgot Password',
                          style: Theme.of(context).textTheme.body1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      new Expanded(
                        child: new Card(
                          child: new RaisedButton(
                            color: Color(0xFF3366FF),
                            textColor: Colors.white,
                            onPressed: () => LoginVerify(),
                            child: new Text(
                              'Login',
                              style: new TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 40.0)),
          new Text(
            'If you are new here then',
            style: new TextStyle(color: Colors.white),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
          new FlatButton(
            color: Color(0xFF3366AA),
            onPressed: () => Navigator.of(context).pushNamed("/Register"),
            child: new Text(
              'Click here to Register',
              style: new TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
