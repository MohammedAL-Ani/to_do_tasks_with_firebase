import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../my_account/my_account.dart';

class AllWorkersWidget extends StatefulWidget {
  final String userID;
  final String userName;
  final String userEmail;
  final String positionInCompany;
  final String phoneNumber;
  final String userImageUrl;

  const AllWorkersWidget(
      {required this.userID,
        required this.userName,
        required this.userEmail,
        required this.positionInCompany,
        required this.phoneNumber,
        required this.userImageUrl});
  @override
  _AllWorkersWidgetState createState() => _AllWorkersWidgetState();
}

class _AllWorkersWidgetState extends State<AllWorkersWidget> {

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading? const Center(child: CircularProgressIndicator()):
      Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProfileScreen(
                      userID: widget.userID,
                    ),
              ),
            );
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          leading:  Container(
            width: size.width * 0.26,
            height: size.width * 0.26,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 5,
                    color: Theme.of(context).scaffoldBackgroundColor),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                     widget. userImageUrl == null
                          ? 'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png'
                          : widget. userImageUrl!,
                    ),
                    fit: BoxFit.fill)),
          ),
          title: Text(
            widget.userName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.bold,color: Colors.black),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.linear_scale,
                color: Colors.pink.shade800,
              ),
              Text(
                '${widget.positionInCompany}/${widget.phoneNumber}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.mail_outline_outlined,
              size: 30,
              color: Colors.pink[800],
            ),
            onPressed:_mailTo,
          )),
    );
  }
  Future<void> _mailTo() async {
    Uri gmailUrl = Uri.parse("mailto://${widget.userEmail}");
    await canLaunchUrl(gmailUrl)
        ? await launchUrl(gmailUrl)
        : print('could_not_launch_this_app');
  }
}




