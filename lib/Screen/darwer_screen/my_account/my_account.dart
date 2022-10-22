import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/darwer_screen/my_account/widget/social_buttons.dart';
import 'package:tasks_with_firebase/constants/constant.dart';
import 'package:tasks_with_firebase/widgets/drawer_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children:[ Card(
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
                        'Name',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Job Since joinied data (2022....)',
                        style: TextStyle(
                            fontSize: 18,
                            color: Constants.darkBlue,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Divider(thickness: 1,),
                    SizedBox(height: 20,),
                    Text(
                      'Contact Info',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.purple,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Email:',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Phone Number:',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        socialButtons( color: Colors.green, function: (){}, icon: Icons.whatsapp_outlined),
                        socialButtons( color: Colors.orange, function: (){}, icon: Icons.message_outlined),
                        socialButtons( color: Colors.purple, function: (){}, icon: Icons.call_outlined),
                      ],
                    ),
                    SizedBox(height: 35,),
                    Divider(thickness: 1,
                     ),
                    SizedBox(height: 15,),
                    Center(
                      child: TextButton.icon(onPressed:(){} ,icon:Icon( Icons.logout_outlined,size: 32,),
                        label:Text('Log out',style: TextStyle(
                          fontSize: 28,
                        ),)
            ),
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
                        color: Theme.of(context)
                            .scaffoldBackgroundColor),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          // imageUrl == null
                          //     ?
                        'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png'
                              // : imageUrl!,
                        ),
                        fit: BoxFit.fill)),
              )
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
