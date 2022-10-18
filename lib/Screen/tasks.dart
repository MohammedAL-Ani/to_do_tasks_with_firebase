

import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/widgets/tasks_widgets.dart';

import '../widgets/drawer_widget.dart';

class TasksScreen extends StatelessWidget {


  List<String> taskCategoryList = [
  'Business',
 'Programming',
  'Information Technology',
  'Human resources',
  'Marketing',
 'Desgin',
  'Accounting',
  ];



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.menu,
        //     color: Colors.black54,
        //   ),
        //   onPressed: () {},
        // ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Tasks'),
        actions: [IconButton(onPressed: () {
          showDialog(context: context, builder: (context) {
          return AlertDialog( title: Text("Task category",style: TextStyle(
            color: Colors.pink,fontSize: 20,
          ),
          ),
          content: Container(
            width: size.width*0.9,
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: taskCategoryList.length,
                itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [

                  Icon(
                    Icons.check_circle_outline_rounded,
                    color:Colors.pink,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      taskCategoryList[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  )
                ],
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
            TextButton(
                onPressed: () {
                  // setState(() {
                  //   taksCategory = null;
                  // });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Cancel filter'))
          ],);
          });
        }, icon: Icon(Icons.filter_list,color: Colors.black,))],
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return TaskWidget();
      }),
    );
  }
}
