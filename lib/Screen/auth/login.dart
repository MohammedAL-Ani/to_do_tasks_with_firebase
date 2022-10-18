import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/auth/forget_password.dart';
import 'package:tasks_with_firebase/Screen/auth/sign.dart';
import 'package:tasks_with_firebase/share/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var textEmailAdress = TextEditingController();

  bool isShowText = true;

  var textPassword = TextEditingController();
  FocusNode _passFocusNode = FocusNode();
  late TextEditingController _emailTextController;
  late TextEditingController _passTextController;

  var _loginFormKey = GlobalKey<FormState>();

  bool isPassword = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void submitFormOnLogin() {
    final isValid = _loginFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print("Form valid");
    } else {
      print("Form not valid");
    }
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
                          controller: textEmailAdress,
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
                          controller: textPassword,
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
