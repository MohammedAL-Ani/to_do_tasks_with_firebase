import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/auth/login/login.dart';
import 'package:tasks_with_firebase/Screen/auth/sign_in%20/sign.dart';
import 'package:tasks_with_firebase/task_screen/tasks.dart';

import 'Screen/auth/sign_in /select_photo_options/screens/set_photo_screen.dart';
import 'Screen/user_state.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _appInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(
                    'App is loading',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(
                    'An error has been occured',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter WorkOs Arabic',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFFEDE7DC),
              primarySwatch: Colors.blue,
            ),
            home: UserState(),
          );
        });
  }
}
