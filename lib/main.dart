import 'package:flutter/material.dart';
import 'package:segundoparcial/Screens/LoginPage.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
