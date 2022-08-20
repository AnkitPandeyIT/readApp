import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GetUserData extends StatelessWidget {
  final String documentId;

  GetUserData({required this.documentId});


  @override
  Widget build(BuildContext context) {
    // get collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<
              String,
              dynamic>;
          return Text(
              '${data['Name']} ' + ',' + '  Score - ${data['Score']} ' + ',' +
                  ' Rewards - ${data['Reward']}');
        }
        return Text('loading...');
      },);
  }


}




// read curruntReward from database

