import "package:flutter/material.dart";
import 'package:reading_reparo/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SecondScreen.dart';

import 'myColors.dart';


import 'package:animated_text_kit/animated_text_kit.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  final Shader linearGradient = LinearGradient(colors: <Color>[
    Color.fromARGB(255, 42, 69, 225),
    Color.fromARGB(255, 119, 72, 212)
  ]).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  checkUser(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print('User is signed in!');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SecondRoute()));
      }
    });
  }



  // void startQuiz() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  // }

  // void _showAlertDialog(context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.white,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //           content: Text("Would you like to test your reading skills?"),
  //           actions: [
  //             MaterialButton(
  //               onPressed: () {
  //                 startQuiz();
  //               },
  //               child: Text("Yes!"),
  //             ),
  //             MaterialButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                     context,
  //                     (MaterialPageRoute(
  //                         builder: ((context) => SecondRoute()))));
  //               },
  //               child: Text("Maybe later"),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[100],
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Reading Reparo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Wrap(
        children: [
          Center(
              child: Container(
                  width: 250,
                  height: 250,
                  child: Image.asset(
                    'assets/logo/logo.png',
                    fit: BoxFit.fill,
                  ))),
          Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(103, 100, 91, 472),
                  child: Center(
                      child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Reading Reparo",
                        textStyle: TextStyle(
                            fontSize: 36,
                            foreground: Paint()..shader = linearGradient,
                            fontFamily: "Jeju-Gothic",
                            fontWeight: FontWeight.bold),
                      ),
                      TyperAnimatedText("Let's Repair Our Reading",
                          textStyle: TextStyle(
                              fontSize: 36,
                              foreground: Paint()..shader = linearGradient,
                              fontFamily: "Jeju-Gothic",
                              fontWeight: FontWeight.bold)),
                    ],
                    repeatForever: true,
                  ))),
            ],
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
          child: ElevatedButton(
            onPressed: () {
              checkUser();

            },
            child: Text("Let's Start"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                fixedSize: MaterialStateProperty.all(const Size(244, 48))),
          ),
          padding: EdgeInsets.only(right: 66, bottom: 50),
        )
      ],
    );
  }
}
