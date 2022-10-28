import 'package:flutter/material.dart';

Widget socialButtons({required Color color,required IconData icon ,required Function function}){
  return  CircleAvatar(
    radius: 23,
    backgroundColor: color,
    child: CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(icon,color: color,),
        onPressed: (){function();},
      ),
    ),
  );
}