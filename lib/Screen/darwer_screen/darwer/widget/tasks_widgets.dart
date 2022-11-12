import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks_with_firebase/share/error_dialog/error_dialog_handling.dart';

import '../../../details_task_screen /details_task.dart';

class TaskWidget extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  final String taskId;
  final String uploadedBy;
  final bool isDone;

  const TaskWidget(
      {required this.taskTitle,
        required this.taskDescription,
        required this.taskId,
        required this.uploadedBy,
        required this.isDone});


  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}
FirebaseAuth _auth = FirebaseAuth.instance;

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      margin: EdgeInsets.all(16),
      child: ListTile(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetails(taskId: '', uploadedBy: '',),
            ),
          );
        },
        onLongPress: () {
          showDialog(context: context, builder: (context){
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.all(Radius.circular(15))),
              actions: [

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                    TextButton.icon(
                        onPressed: (){
                          User? user = _auth.currentUser;
                          String _uid = user!.uid;
                          if (_uid == widget.uploadedBy){
                            FirebaseFirestore.instance.collection('tasks').doc(widget.taskId).delete();
                            Navigator.pop(context);
                          }else {
                            GlobalMethods.showErrorDialog(error: 'you don\'t have access to delete this tasks', context: context);
                          }


                        }, icon:Icon(Icons.delete,color: Colors.pink,size: 24.0,),
                        label:Text("Delete",style: TextStyle(
                          color: Colors.pink,
                          fontSize: 20,
                        ),) ),
                  ],
                ),
              ],
            );
          });
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration:
              BoxDecoration(border: Border(right: BorderSide(width: 1.0))),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: widget.isDone? SvgPicture.asset(
              'assets/images/done.svg',
            ):
            SvgPicture.asset(
              'assets/images/timer.svg',
            ),
          ),
        ),
        title: Text(
          widget.taskTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.linear_scale,
              color: Colors.pink.shade800,
            ),
            Text(
              widget.taskDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.pink[800],
        ),
      ),
    );
  }
}
