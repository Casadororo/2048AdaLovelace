import 'package:adalovelace/adalovelace/screens/whapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAda extends StatelessWidget {
  const MainAda({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: Whapper(),
    );
  }
}