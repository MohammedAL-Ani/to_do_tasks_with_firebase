
import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/constants/constant.dart';

import '../Screen/darwer_screen/add_task/add_task.dart';
import '../Screen/darwer_screen/my_account/my_account.dart';
import '../Screen/darwer_screen/registerted_work/registerted_work.dart';
import '../Screen/tasks.dart';

class DrawerWidget extends StatelessWidget {

Constants _constants=Constants();
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
          children:[
             DrawerHeader(
                decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 0, 100) ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(

                        child: Image.network(
                            'https://images.assetsdelivery.com/compings_v2/logoking33/logoking332011/logoking33201100531.jpg',
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                          ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Flexible(child: Text("SH This Life")),
                  ],
                )
                ),
            SizedBox(
              height: 30,
            ),
            _listTiles(
                label: 'All tasks',
                fct: () {
                  _navigateToTaskScreen(context);
                },
                icon: Icons.task_outlined),
            _listTiles(
                label: 'My account',
                fct: () {
                  _navigateToProfileScreen(context);
                },
                icon: Icons.settings_outlined),
            _listTiles(
                label: 'Registered workes',
                fct: () {
                  _navigateToAllWorkerScreen(context);
                },
                icon: Icons.workspaces_outline),
            _listTiles(
                label: 'Add task',
                fct: () {
                  _navigateToAddTaskScreen(context);
                },
                icon: Icons.add_task_outlined),
            Divider(
              thickness: 1,
            ),
            _listTiles(
                label: 'Logout',
                fct: () {
                  _logout(context);
                },
                icon: Icons.logout_outlined),
          ],

       ),
    );
  }

void _navigateToProfileScreen(context) {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final User? user = _auth.currentUser;
  // final uid = user!.uid;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => ProfileScreen(
        // userID: uid,
      ),
    ),
  );
}

void _navigateToAllWorkerScreen(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => AllWorkersScreen(),
    ),
  );
}

void _navigateToAddTaskScreen(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => AddTaskScreen(),
    ),
  );
}

void _navigateToTaskScreen(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => TasksScreen(),
    ),
  );
}
void _logout(context) {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/exit.png',

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sign out'),
              ),
            ],
          ),
          content: Text(
            'Do you wanna Sign out',
            style: TextStyle(
                color: Constants.darkBlue,
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text('Cancel'),
            ),
            TextButton(
                onPressed: () async {
                  // await _auth.signOut();
                  // Navigator.canPop(context) ? Navigator.pop(context) : null;
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: ()=>
                  //     // builder: (ctx) => UserState(),
                  //   ),
                  // );
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      });
}


  Widget _listTiles(
      {required String label, required Function fct, required IconData icon}) {
    return ListTile(
      onTap: () {
        fct();
      },
      leading: Icon(
        icon,
        color: Constants.darkBlue,
      ),
      title: Text(
        label,
        style: TextStyle(
            color: Constants.darkBlue,
            fontSize: 20,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
