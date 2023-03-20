import 'dart:math';
import 'package:reading_reparo/FeedbackScreen.dart';
import 'myStyles.dart';
import 'package:flutter/material.dart';
import 'package:reading_reparo/FeedbackScreen.dart';

class rewardScreen extends StatelessWidget {
  //const rewardScreen({Key? key}) : super(key: key);
  List<String> rewards90to100 = ['assets/rewards/90_100_1.gif','assets/rewards/90_100_2.gif','assets/rewards/90_100_3.gif','assets/rewards/90_100_4.gif'];
  List<String> rewards80to90 = ['assets/rewards/80_90_1.gif','assets/rewards/80_90_2.gif'];
  List<String> rewards60to70 = ['assets/rewards/60_70.gif', 'assets/rewards/60_70_1.gif', 'assets/rewards/60_70_2.gif'];
  List<String> reward70to80 = ['assets/rewards/70_80.gif', 'assets/rewards/70_80_1.gif', 'assets/rewards/70_80_2.gif'];
  List<String> lowerRewards = ['assets/rewards/0_40_1.gif', 'assets/rewards/40_60_2.gif'];

  late var score;
  late var words;
  late var content;
  late var langID;

  rewardScreen(score, words, content, langID){
    this.score = score;
    this.words = words;
    this.content = content;
    this.langID = langID;
  }


  giveReward(){
    Random randint = Random();
    if( score > 90){
      int i = randint.nextInt(rewards90to100.length)+0;
      return Column( children: [
        Container(
          padding: EdgeInsets.all(100.0),
          child: Text("it's a goal!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
      )
        ,Container(
        child: Center(
        child: Image.asset(rewards90to100[i], height: 300, width: 300,)
        ),
      ) ]
      );

    }
    else if (score > 80){
      int i = randint.nextInt(rewards80to90.length)+0;
      return Column( children: [
        Container(
          padding: EdgeInsets.all(100.0),
        child: Text("AH that was close", style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600
        ),),
        ),
    Container(
        child: Center ( child: Image.asset(rewards80to90[i], height: 300, width: 300,)),
      )
      ]
    );

    }
    else if(score > 70){
      int i = randint.nextInt(reward70to80.length)+0;
      return Column( children: [
        Container(
          padding: EdgeInsets.all(100.0),
          child: Text("You just missed it!", style: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w600
      ),),) ,
    Container( child:
        Center(
        child: Image.asset(reward70to80[i], height: 300, width: 300,)),
      )
    ]
    );
    }
    else if(score > 60){
      int i = randint.nextInt(rewards60to70.length)+0;
      return Column( children: [
        Container(
          padding: EdgeInsets.all(100.0),
          child: Text("You are getting better. Keep going!",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600
      ),),)  ,
        Container(
          padding: EdgeInsets.all(100.0),
          child: Center(
              child: Image.asset(rewards60to70[i], height: 300, width: 300,)),
      )
    ]
    );
    }
   else if(score > 40){
      return Column(
          children: [
            Container(
              padding: EdgeInsets.all(100.0),
              child: Text('May luck find your way!',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600
      ),),),
        Container(
          padding: EdgeInsets.all(100.0),

          child: Center(
            child: Image.asset(lowerRewards[1], height: 300, width: 300,)),
      )]
    );
   }
      else{
      return Column( children: [  Container(
        padding: EdgeInsets.all(100.0),
        child: Text("Better luck next time", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600
          ),),
    ),
        Container(
        child: Center( child: Image.asset(lowerRewards[0], height: 300, width: 300,)),
      )
    ]
    );
    }
  }



  @override
  Widget build(BuildContext context) {
    return  WillPopScope(onWillPop: () async{
      return false;
    } ,
    child:  Scaffold(
      appBar: AppBar(
        title: Text('Is it a goal?'),
      ),
      body: Container(

          decoration: BoxDecoration(

              image: DecorationImage(

                image: AssetImage('assets/appbg2.jpg'),
                fit: BoxFit.fill,
              )
          ),



          child : SingleChildScrollView( child:
    Column( children: [
        Container(child: giveReward(),
      ),
        Container(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> feedBackScreenRoute(words, content, langID)));

            },
            child: Text('Analyse your score'),
          ),
        ),
      SizedBox(
        height: 25,
      ),
      Container(
        height : 50,
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              words = [];
              Navigator.pop(context);
            },
            child: Text("Retry?"),
            style: ButtonStyle(

                fixedSize: MaterialStateProperty.all(Size(50, 50))),
          ))
    ])
      )
      )
    )
    );
  }
}
