import 'package:adalovelace/adalovelace/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.height * 0.60;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: width,
            alignment: Alignment.center,
            child: Text("11340",style: TextStyle(fontSize: 40,color: Colors.pink[200]),),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GoogleSignInButton(onPressed: () {
                  AuthService().singInGoogle();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
