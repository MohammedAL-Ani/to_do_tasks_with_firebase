import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/auth/login/login.dart';
import 'package:tasks_with_firebase/share/components/components.dart';

class ForgetPaswordScreen extends StatefulWidget {
  @override
  State<ForgetPaswordScreen> createState() => _ForgetPaswordScreen();
}

class _ForgetPaswordScreen extends State<ForgetPaswordScreen> {
  late TextEditingController _forgetPassTextController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _forgetPassTextController.dispose();
    super.dispose();
  }

  void forgetPasswordFTC() {
    print('_forgetPassTextController.text ${_forgetPassTextController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Forget Password',
                style: TextStyle(color: Colors.indigo, fontSize: 40.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Adress",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: _forgetPassTextController,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.indigo,
                      child: MaterialButton(
                        onPressed: forgetPasswordFTC,
                        child: Text(
                          'Rest Now',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
