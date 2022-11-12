

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/share/constants/constant.dart';

import '../Screen/darwer_screen/darwer/drawer_widget.dart';
import '../Screen/darwer_screen/darwer/widget/tasks_widgets.dart';



class TasksScreen extends StatefulWidget {


  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {



  String? tasksCategory;

  @override
  Widget build(BuildContext context) {

      Size size = MediaQuery
          .of(context)
          .size;
      return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),

          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          title: Text('Tasks'),
          actions: [IconButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(title: Text("Task category", style: TextStyle(
                color: Colors.pink, fontSize: 20,
              ),
              ),
                content: Container(
                  width: size.width * 0.9,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Constants.taskCategoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {

                              tasksCategory = Constants.taskCategoryList[index];
                              Navigator.canPop(context) ? Navigator.pop(context) : null;
                            });
                          },
                          child: Row(
                            children: [

                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.pink,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Constants.taskCategoryList[index],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                              )
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
                  TextButton(
                      onPressed: () {
                        setState(() {
                          tasksCategory = null;
                        });
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      },
                      child: Text('Cancel filter'))
                ],);
            });
          }, icon: Icon(Icons.filter_list, color: Colors.black,))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("tasks")
                .where("taskCategory", isEqualTo: tasksCategory)
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskWidget(
                          taskTitle: snapshot.data!.docs[index]['taskTitle'],
                          taskDescription: snapshot.data!.docs[index]
                          ['taskDescription'],
                          taskId: snapshot.data!.docs[index]['taskId'],
                          uploadedBy: snapshot.data!.docs[index]['uploadedBy'],
                          isDone: snapshot.data!.docs[index]['isDone'],
                        );
                      });
                } else {
                  return Center(
                    child: Text('No tasks has been uploaded'),
                  );
                }
              }
              return Center(
                child: Text('Something went wrong'),
              );

          },
        ),


      );
    }

}



