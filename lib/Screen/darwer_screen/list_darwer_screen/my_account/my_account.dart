import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/darwer_screen/list_darwer_screen/my_account/widget/social_buttons.dart';
import 'package:tasks_with_firebase/share/error_dialog/error_dialog_handling.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../share/constants/constant.dart';
import '../../../user_state.dart';
import '../../darwer/drawer_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String userID ;
  const ProfileScreen({Key? key, required this.userID,}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  String phoneNumber = "";
  String email = "";
  String name = "";
  String job = "";
  String? imageUrl;
  String joinedAt = "";
  bool _isSameUser = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getUserData();

  }

  void getUserData() async {
    _isLoading = true;
    try {
      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();

      if (userData == null) {
        return;
      } else {
        setState(() {

          email = userData.get('email');
          name = userData.get('name');
          phoneNumber = userData.get('phoneNumber');
          job = userData.get('positionInCompany');
          imageUrl = userData.get('userImageUrl');
          Timestamp joinedAtStamp = userData.get('createAt');
          var joinedDate = joinedAtStamp.toDate();
          joinedAt = '${joinedDate.year}-${joinedDate.month}-${joinedDate.day}';
        });
        User? user = _auth.currentUser;
        String _uid = user!.uid;
        setState(() {
          _isSameUser = _uid == widget.userID;
        });
      }
    } catch (error) {
      GlobalMethods.showErrorDialog(error: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator()
      )
          :
      SingleChildScrollView(
        child: Stack(
          children: [
            Card(
              margin: EdgeInsets.all(30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Text(
                        name == null ? '' : name,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        '$job Since joinied $joinedAt.',
                        style: TextStyle(
                            fontSize: 18,
                            color: Constants.darkBlue,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Contact Info',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.purple,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email:$email',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone Number:$phoneNumber',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        socialButtons(
                            color: Colors.green,
                            function: () {
                              _openWhatsapp(
                                  context: context,
                                  text: 'hello',
                                  number: phoneNumber);
                            },
                            icon: Icons.whatsapp_outlined),
                        socialButtons(
                            color: Colors.orange,
                            function: _mailTo,
                            icon: Icons.message_outlined),
                        socialButtons(
                            color: Colors.purple,
                            function: _callPhoneNumber,
                            icon: Icons.call_outlined),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    _isSameUser==false ? Container():
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _isSameUser==false ? Container():
                    Center(
                      child: TextButton.icon(
                          onPressed: _logOut,
                          icon: Icon(
                            Icons.logout_outlined,
                            size: 32,
                          ),
                          label: Text(
                            'Log out',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              // right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [



              Container(
              width: size.width * 0.26,
                  height: size.width * 0.26,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            imageUrl == null
                                ? 'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png'
                                : imageUrl!,
                          ),
                          fit: BoxFit.fill)),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }

  void _logOut() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => UserState(),
      ),
    );
  }

  Future<void> _mailTo() async {
    Uri gmailUrl = Uri.parse("mailto://$email");
    await canLaunchUrl(gmailUrl)
        ? await launchUrl(gmailUrl)
        : print('could_not_launch_this_app');
  }

  void _callPhoneNumber() async {
    final Uri phoneUrl = Uri.parse('tel://$phoneNumber');
    if (await canLaunchUrl(phoneUrl)) {
      launchUrl(phoneUrl);
    } else {
      throw "Error occured coulnd\'t open link";
    }
  }
}
