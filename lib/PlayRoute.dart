import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:reading_reparo/rewardScreenRoute.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PlayRoute extends StatefulWidget {
  static late String text;
  PlayRoute(){
    PlayRoute.text = 'Everybody knows the story of another experimental philosopher who had a great theory about a horse being able to live without eating, and who demonstrated it so well, that he had got his own horse down to a straw a day, and would unquestionably have rendered him a very spirited and rampacious animal on nothing at all, if he had not died,';
    PlayRoute.text = PlayRoute.text.replaceAll(RegExp('[^A-Za-z0-9]'), ' ');
  }
  @override
  State<PlayRoute> createState() => _PlayRouteState(text);
}


class _PlayRouteState extends State<PlayRoute> {

  late String text;

  _PlayRouteState(text){
    this.text = text;
  }

  stt.SpeechToText _speech = stt.SpeechToText();
  static  String spokenText = 'Tap the mic to start speaking';
  static late String _text;
  late var confidence;
  bool _isListening = false;
  bool isFinished = false;
  late String savedWords;
  late var score;


  void listen() async {
    isFinished = false;
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val to ' + 'en-IN'),
        onError: (val) => print('onError : $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onDevice: false,
          onResult: (val) => setState(() {
            spokenText = val.recognizedWords;

            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
          }),
          localeId: 'en-IN',
        );
      }
    } else {
      setState(() => {_isListening = false, isFinished = true});

      _speech.stop();
      var wrong = text.split(" ").where((element) => !spokenText.split(" ").contains(element)).toList();
      var correct = text.split(" ").length - wrong.length.toDouble();
      var score = (correct/text.split(" ").length)*100;

      
      Navigator.push(context, MaterialPageRoute(builder: (context)=> rewardScreen(score, spokenText.split(" "), PlayRoute.text.split(" "), 'en-IN')));


    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
            animate: _isListening,
            glowColor: Colors.white,
            endRadius: 40.0,
            duration: const Duration(milliseconds: 20),
            repeatPauseDuration: const Duration(milliseconds: 100),
            child: Material(
                shape: CircleBorder(),
                child: CircleAvatar( child: FloatingActionButton(
                    onPressed: (){listen(); },
                    child: isFinished == true
                        ? Icon(Icons.arrow_forward_sharp)
                        : Icon(_isListening ? Icons.mic : Icons.mic_none)),
                ))),
      body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/football-pitch.png')
            )
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                    30.0, 80.0, 30.0, 150.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.withOpacity(0.9),
                ),
                child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(
                    30.0, 30.0, 30.0, 150.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.withOpacity(0.9),
                ),
                child: Text(spokenText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
              )
            ],
          ),
        )
    );
  }
}
