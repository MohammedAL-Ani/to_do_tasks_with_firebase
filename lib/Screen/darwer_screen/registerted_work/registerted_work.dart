

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks_with_firebase/Screen/darwer_screen/registerted_work/widget/all_work_widget.dart';

import '../darwer/drawer_widget.dart';

class AllWorkersScreen extends StatelessWidget {

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'All worker',
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(snapshot.data!.docs[index]['id'] == _auth.currentUser!.uid){
                      return Container(height:0);
                    }
                    return AllWorkersWidget(
                      userID: snapshot.data!.docs[index]['id'],
                      userName: snapshot.data!.docs[index]['name'],
                      userEmail: snapshot.data!.docs[index]['email'],
                      positionInCompany: snapshot.data!.docs[index]
                      ['positionInCompany'],
                      phoneNumber: snapshot.data!.docs[index]['phoneNumber'],
                      userImageUrl: snapshot.data!.docs[index]['userImageUrl'],
                    );
                  });
            } else {
              return Center(
                child: Text('No user found'),
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