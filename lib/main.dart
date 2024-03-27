import 'package:api/model/RegisterResponsd.dart';
import 'package:api/model/UserRespond.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 18, 160, 182),
      ),
      home: RegisterScreen(),
    );
  }
}
