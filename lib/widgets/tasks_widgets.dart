import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

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
        onTap: () {},
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
                        onPressed: (){}, icon:Icon(Icons.delete,color: Colors.pink,size: 24.0,),
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
            radius: 20, //  'assets/images/done.svg'
            child: SvgPicture.asset(
              'assets/images/timer.svg',
            ),
          ),
        ),
        title: Text(
          'Title',
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
              'Subtitle/Descrption',
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
