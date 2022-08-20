


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';



final docUser  = FirebaseFirestore.instance.collection('users').doc();


Future addDetails(String name,double score, int reward) async {
  await docUser.set({
    'Name': name,
    'Score': score,
    'Reward': reward,
  });
}


Future updateFields(double score, int reward) async{

  FirebaseFirestore.instance.collection('users').doc(docUser.id).update({'Score': score, 'Reward': reward });

}





//checkuser



// sign Out
Future SignOut() async {
  await FirebaseAuth.instance.signOut();
}



Future FetchReward() async{
  int num = 0;
  final CollectionReference ref = FirebaseFirestore.instance.collection('users');

  try{
    await ref.doc(docUser.id).get().then((DocumentSnapshot){
    num =   DocumentSnapshot.get('Reward');

    });
    return num;
  } catch (e) {
    print(e.toString());
    return null;
  }
}






