import 'package:flashcards_app/all_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.text}){
    flutterTts.setLanguage("en-US");
  }

  final String text;

  final FlutterTts flutterTts = FlutterTts();



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 7,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  flutterTts.speak(text);
                  flutterTts.setPitch(0.82);
                  flutterTts.setVolume(1.0);
                  flutterTts.setSpeechRate(0.3);

                },
              ),
              SizedBox(height: 10),
              Text(text, style: cardTextStyle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}