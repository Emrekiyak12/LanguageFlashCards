import 'package:flutter/material.dart';
import 'package:flashcards_app/screens/login_page.dart';
import 'package:flashcards_app/screens/my_decks.dart';
import 'ques_ans_file.dart';

void main()async{
  await get_lists();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flashcards App',
        home: LoginPage());
  }
}
