import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_reparo/getuserData.dart';
import 'firebasefun.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  //doc ids
  List<String> docIDs = [];

  //get docIDs
  Future getDocID() async{
    await FirebaseFirestore.instance.collection('users').get().then(
            (snapshot) => snapshot.docs.forEach((document){
             docIDs.add(document.reference.id);
    },),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Teacher Section', style: TextStyle(fontSize: 16),
        ),
        actions: [
          GestureDetector(
            onTap: ()  {
              SignOut();
    },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.logout),
            ),

          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Expanded(
                child: FutureBuilder(
                    future: getDocID(),
                    builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(title: GetUserData(documentId: docIDs[index]),
                            tileColor: Colors.grey[300],
                          ),
                        );
                  },
                  );

                },
                ),
            ),

          ],
        ),
      ),

    );
  }

  }



