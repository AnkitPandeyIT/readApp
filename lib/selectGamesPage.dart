import 'package:flutter/material.dart';

import 'firstGame.dart';
import 'flipcardgame.dart';
import 'mathMaster.dart';



class SelectGames extends StatelessWidget {
  const SelectGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Select Game")),
      ),
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            }, child: Text("Memory Booster", style: TextStyle(fontSize: 30),), ),
            SizedBox(height: 25,),
            ElevatedButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>MatheMaster()));
            }, child: Text("Cal Master Game",style: TextStyle(fontSize: 30),),),
          ],
        ),
      ),
    );
  }
}
