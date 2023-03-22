import 'package:flutter/material.dart';
import 'package:flashcards_app/screens/login_page.dart';

class ScorePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int incorrectAnswers;

  ScorePage({required this.correctAnswers, required this.totalQuestions,required this.incorrectAnswers});

  double get percentage => (correctAnswers / totalQuestions) * 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correct Answers: $correctAnswers',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Incorrect Answers: $incorrectAnswers',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Percentage: ${percentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Return Home'),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}