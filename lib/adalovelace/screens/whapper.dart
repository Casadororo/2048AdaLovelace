import 'package:adalovelace/adalovelace/screens/home.dart';
import 'package:adalovelace/adalovelace/screens/mainAda.dart';
import 'package:adalovelace/adalovelace/screens/login.dart';
import 'package:adalovelace/adalovelace/services/db.dart';
import 'package:adalovelace/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Whapper extends StatefulWidget {
  Whapper({Key key}) : super(key: key);

  @override
  _WhapperState createState() => _WhapperState();
}

class _WhapperState extends State<Whapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    print(user.toString());
    if (user == null) {
      return Login();
    } else {
      return StreamProvider<List<Chats>>.value(
         value: DbService().streamChats(user), child: Home());
    }
  }
}
