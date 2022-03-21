import 'package:flutter/material.dart';
import 'package:quest_2/initiate_app/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quest',
      theme: ThemeData(
        fontFamily: 'SFPro',
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}
