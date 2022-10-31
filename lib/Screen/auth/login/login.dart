import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/auth/forget_password/forget_password.dart';
import 'package:tasks_with_firebase/Screen/auth/sign_in%20/sign.dart';
import 'package:tasks_with_firebase/share/components/components.dart';
import 'package:tasks_with_firebase/task_screen/tasks.dart';

import '../../../share/error_dialog/error_dialog_handling.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  bool isShowText = true;

  bool _isLoading = false ;


  FocusNode _passFocusNode = FocusNode();
   TextEditingController _emailTextController= TextEditingController();
   TextEditingController _passTextController = TextEditingController();

  var _loginFormKey = GlobalKey<FormState>();

  bool isPassword = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void submitFormOnLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethods.showErrorDialog(
            error: error.toString(), context: context);
      }
    } else {
      print('Form not valid');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Login',
                style: TextStyle(color: Colors.indigo, fontSize: 40.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultFormField(
                          controller: _emailTextController,
                          label: 'Email',
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'email must not be empty';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: _passTextController,
                          onEditingComplete: submitFormOnLogin,
                          foucs: _passFocusNode,
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          isPassword: isPassword,
                          suffixPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password must be not empty';
                            } else if (value.length < 7) {
                              return 'password is too short';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPaswordScreen(),
                        ),
                      );
                    },
                    child: Text("forget the password?"),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                color: Colors.indigo,
                child: MaterialButton(
                  onPressed: submitFormOnLogin,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Register Now',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
