import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks_with_firebase/Screen/auth/login.dart';
import 'package:tasks_with_firebase/share/components/components.dart';

import '../../constants/constant.dart';

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

  File? imageFile;

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
    Size size = MediaQuery.of(context).size;
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
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: defaultFormField(
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
                  ),
                  Flexible(child: Stack(
                  children: [
                  Padding(
                  padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width * 0.24,
            height: size.width * 0.24,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageFile == null
                  ? Image.network(
                'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                fit: BoxFit.fill,
              )
                  : Image.file(
                imageFile!,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: _showImageDialog,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                border: Border.all(
                    width: 2, color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  imageFile == null
                      ? Icons.add_a_photo
                      : Icons.edit_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        ],
      ),
    )
    ],
    ),



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
                  GestureDetector(
                    onTap: () => showJobsDialog(size),
                child: defaultFormField(
                  style:  TextStyle(color: Colors.black),
                    enbale: false,
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
              ),
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
  void _pickImageWithCamera() async {

      var pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);

      _cropImage(pickedFile!.path);
    // } catch (error) {
    //   // GlobalMethods.showErrorDialog(error: '$error', context: context);
    // }
      setState(() {
        imageFile = File(pickedFile!.path);
      });



    Navigator.pop(context);
  }

  void _pickImageWithGallery() async {

      var pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);

      _cropImage(pickedFile!.path);
    // } catch (error) {
    //   // GlobalMethods.showErrorDialog(error: '$error', context: context);
    // }

      setState(() {
        imageFile = File(pickedFile!.path);
      });

    Navigator.pop(context);
  }

  Future _cropImage(filePath) async {
    CroppedFile? mcropImage = await ImageCropper().cropImage(
        sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (mcropImage != null) {
      setState(() {
        imageFile =File(mcropImage.path);

      });
    }
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _pickImageWithCamera,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.indigo,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _pickImageWithGallery,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.indigo,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void showJobsDialog(size) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Jobs',
              style: TextStyle(color: Colors.indigo, fontSize: 20),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Constants.jobsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(

                      onTap: () {
                        setState(() {
                          _textPostionCompany.text = Constants.jobsList[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.indigo,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Constants.jobsList[index],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Close'),
              ),
              TextButton(onPressed: () {}, child: Text('Cancel filter'))
            ],
          );
        });
  }

}


