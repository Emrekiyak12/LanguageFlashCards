import 'package:flutter/material.dart';
import 'home_page.dart';
import 'my_decks.dart';
import '../ques_ans_file.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB6FAD6),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Image.asset(
                'lib/screens/images/logo.jpeg',
                height: 290,
                width: 300,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01), // 10% of screen height
              Text(
                'Start Learning Now!',
                style: TextStyle(
                  fontFamily:'Montserrat',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color:Colors.blue,
                ),
              ),
              SizedBox(height: 55),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () async {
                    type="Lesson";
                    openLevels= await levelsGet("Lesson");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameMenu()),
                    );
                  },
                  child: Text(
                    'Lessons',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox( width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                ),
                onPressed: () async {
                  type="Vocabulary";
                  openLevels= await levelsGet("Vocabulary");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameMenu()),
                  );
                },
                child: Text(
                  'Vocabulary',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ),
              SizedBox(height: 20),
              SizedBox( width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () async {
                    type="Exam";
                    openLevels= await levelsGet("Exam");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameMenu()),
                    );
                  },
                  child: Text(
                    'Exams',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
            SizedBox( width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                    await generate2();
                    if (len!=0){
                    isCrossPressed=List.filled(len, false);
                    isCheckPressed=List.filled(len, false);
                    num_correct=0;
                    num_incorrect=0;
                    isLevel=false;
                    y=true;
                    x=true;
                    levelnum="";
                    type="Wrong Answers";
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                    else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You do not have any starred questions yet.'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.yellow,
                      ),

                    );

                  }
                },
                child: Text(
                  'Wrong Answers',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}