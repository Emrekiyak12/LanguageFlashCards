import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flashcards_app/screens/score_page.dart';
import '../all_constants.dart';
import '../ques_ans_file.dart';
import '../reusable_card.dart';
import 'dart:async';
var x=true;
var y=true;
var type="";
List<bool> isCrossPressed = [];
List<bool> isCheckPressed = [];
List<int> numlist=[];
List<int> opens=[];
int num_correct=0;
int num_incorrect=0;
var isLevel=false;
var starr=false;
var storage;
var levelnum="";
int len=0;
generate(String name) async {
  storage = await get_data(name);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndexNumber = 0;
  double _initial = 0.1;
  int _remainingTime = len * 12; // in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }
  void _updateTimer(Timer timer) {
    setState(() {
      _remainingTime--;
    });
    if (_remainingTime <= 0) {
      _timer.cancel();

      saveIncorrect(type);

      if ((len-num_correct)<=(storage.length/10.toInt())){
        reset(type);
        if(isLevel) {
          levels(type);
        }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ScorePage(correctAnswers:num_correct,totalQuestions:len,incorrectAnswers: num_incorrect)),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    String value = (_initial * 10).toStringAsFixed(0);
    String clock;
    if (_remainingTime%60<10){
      clock=((_remainingTime/60).toInt()).toString()+":0"+(_remainingTime%60).toString();
    }
    else {
      clock = ((_remainingTime / 60).toInt()).toString() + ":" +
          (_remainingTime % 60).toString();
    }
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10), // adjust the padding as needed
            child: Text(
              type + " " + levelnum,
              style: TextStyle(fontSize: 26),
            ),
          ),
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            elevation: 5,
            centerTitle: true,
            shadowColor: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            leading:               Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  clock,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                ),
              ],
            ),
            actions: [
            TextButton(
            onPressed: () {
              _timer.cancel();
              saveIncorrect(type);

              if ((len-num_correct)<=(storage.length/10.toInt())){
                reset(type);
                if(isLevel) {
                  levels(type);
                }
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ScorePage(correctAnswers:num_correct,totalQuestions:len,incorrectAnswers: num_incorrect)),
              );// Code to handle the "Done" button click.
    },
      child: Text(
        "Done",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
    ],
    ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                Text("Question $value of $len Completed", style: otherTextStyle),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    minHeight: 5,
                    value: (_currentIndexNumber+1)/len.toDouble(),
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                        width: 300,
                        height: 300,
                        child: FlipCard(
                            onFlip: () {
                              setState(() {
                                y = !y;
                              });
                            },
                            direction: FlipDirection.VERTICAL,
                            front: ReusableCard(
                                text: x ? storage.keys
                                    .toList()[opens[numlist[_currentIndexNumber]]]:storage.values
                                    .toList()[opens[numlist[_currentIndexNumber]]],),
                            back: ReusableCard(
                                text: x ? storage.values
                                    .toList()[opens[numlist[_currentIndexNumber]]]:storage.keys
                                    .toList()[opens[numlist[_currentIndexNumber]]]))),
                Text("Tap to see Answer", style: otherTextStyle),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton.icon(
                          onPressed: () {
                            showPreviousCard();
                            updateToPrev();
                          },
                          icon: Icon(FontAwesomeIcons.arrowLeft, size: 35),
                          label: Text(""),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.only(
                                  right: 20, left: 25, top: 15, bottom: 15))),
                      ElevatedButton.icon(
                          onPressed: () {
                            showNextCard();
                            updateToNext();
                          },
                          icon: Icon(FontAwesomeIcons.arrowRight, size: 35),
                          label: Text(""),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.only(
                                  right: 20, left: 25, top: 15, bottom: 15)))
                    ]),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkResponse(
                          onTap: () {
                              if (!isCrossPressed[_currentIndexNumber]) {
                                num_incorrect += 1;
                              }
                              else {
                                num_incorrect -= 1;
                              }
                              if (isCheckPressed[_currentIndexNumber]) {
                                num_correct -= 1;
                              }
                              setState(() {
                                isCheckPressed[_currentIndexNumber]=false;
                                isCrossPressed[_currentIndexNumber] =
                                !isCrossPressed[_currentIndexNumber];
                              });
                            // Do something when the red cross icon is pressed
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isCrossPressed[_currentIndexNumber] ? Colors.red : Colors.grey,
                                width: 6.5,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                              if (!isCheckPressed[_currentIndexNumber]) {
                                try{
                                  deleteData(storage.keys.toList()[opens[numlist[_currentIndexNumber]]]);
                                }
                                finally{
                                  num_correct += 1;
                                }
                              }
                              else {
                                num_correct -= 1;
                              }
                              if (isCrossPressed[_currentIndexNumber]) {
                                num_incorrect -= 1;
                              }
                              setState(() {
                                isCrossPressed[_currentIndexNumber]=false;
                                isCheckPressed[_currentIndexNumber] =
                                !isCheckPressed[_currentIndexNumber];
                              });

                            // Do something when the red cross icon is pressed
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isCheckPressed[_currentIndexNumber] ? Colors.green : Colors.grey,
                                width: 6.5,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
              ])),
        ));
  }

  void updateToNext() {
    setState(() {
      _initial = _initial + 0.1;
      if (_initial > ((len*0.1)+0.0001)) {
        _initial = 0.1;
      }
    });
  }

  void updateToPrev() {
    setState(() {
      _initial = _initial - 0.1;
      if (_initial < 0.001) {
        _initial = len*0.1;
      }
    });
  }

  void showNextCard() async {
    setState(() {
      x=y;
      _currentIndexNumber = (_currentIndexNumber + 1 < len)
          ? _currentIndexNumber + 1
          : 0;
    });
  }

  void showPreviousCard() async {
    setState(() {
      x=y;
      _currentIndexNumber = (_currentIndexNumber - 1 >= 0)
          ? _currentIndexNumber - 1
          : len - 1;
    });
  }

}

 generate2() async {
  storage=await favs();
  len= storage.length;
  numlist = List.generate(len, (index) => index);
  opens = List.generate(len, (index) => index);
  numlist.shuffle();

}