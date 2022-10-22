import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/auth/login.dart';
import 'package:tasks_with_firebase/Screen/auth/sign.dart';
import 'package:tasks_with_firebase/Screen/tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
