import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/auth/login.dart';
import 'package:tasks_with_firebase/share/components/components.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _textFullName = TextEditingController();

  var _textEmailAdress = TextEditingController();

  var _textPassword = TextEditingController();

  var _textPostionCompany = TextEditingController();

  final _formKeySign = GlobalKey<FormState>();

  bool _isPassword = true;

  FocusNode _focusFullName = FocusNode();

  FocusNode _focusEmailAdress = FocusNode();

  FocusNode _focusPassword = FocusNode();

  FocusNode _focusPostionCompany = FocusNode();

  void dispose() {
    _textFullName.dispose();
    _textEmailAdress.dispose();
    _textPassword.dispose();

    _textPostionCompany.dispose();

    _focusFullName.dispose();

    _focusEmailAdress.dispose();

    _focusPassword.dispose();

    _focusPostionCompany.dispose();
  }

  void submitFormOnSign() {
    final isValid = _formKeySign.currentState!.validate();
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
        title: Text("SignUp"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeySign,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Register',
                style: TextStyle(color: Colors.indigo, fontSize: 40.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                  controller: _textFullName,
                  type: TextInputType.name,
                  foucs: _focusFullName,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_focusEmailAdress),
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'full name must not be empty';
                    }

                    return null;
                  },
                  label: 'Full Name',
                  prefix: Icons.person),
              SizedBox(
                height: 15.0,
              ),
              defaultFormField(
                  controller: _textEmailAdress,
                  foucs: _focusEmailAdress,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_focusPassword),
                  type: TextInputType.emailAddress,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'email must not be empty';
                    }

                    return null;
                  },
                  label: 'Email Adress',
                  prefix: Icons.email),
              SizedBox(
                height: 15.0,
              ),
              defaultFormField(
                controller: _textPassword,
                foucs: _focusPassword,
                next: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_focusPostionCompany),
                label: 'Password',
                prefix: Icons.lock,
                suffix: _isPassword ? Icons.visibility : Icons.visibility_off,
                isPassword: _isPassword,
                suffixPressed: () {
                  setState(() {
                    _isPassword = !_isPassword;
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
              SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                  controller: _textPostionCompany,
                  foucs: _focusPostionCompany,
                  next: TextInputAction.done,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Postion must be not empty';
                    }

                    return null;
                  },
                  label: ' Postion on Company ',
                  prefix: Icons.rate_review),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(5.0)),
                width: double.infinity,
                child: MaterialButton(
                  onPressed: submitFormOnSign,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
