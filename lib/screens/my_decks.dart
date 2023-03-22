import 'package:flutter/material.dart';
import 'home_page.dart';
import '../ques_ans_file.dart';

var openLevels;
int numlists=50;


class GameMenu extends StatefulWidget {
  @override
  _GameMenuState createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  int _selectedLevel=1;

  void _selectLevel(int index) {

    setState(() {
      _selectedLevel = index + 1; // update selected level
    });
  }

  void _done() async {
    isLevel=false;


    try {
      levelnum=_selectedLevel.toString();
      await generate("Sayfa"+_selectedLevel.toString());
      num_correct = 0;
      num_incorrect = 0;
      y=true;
      x=true;
    } catch(e){
      print('$e');

    }
    if(_selectedLevel-1==openLevels)
    {
      isLevel=true;
    }
      try {
        opens = await returnWrongs(type,_selectedLevel.toString());
      }
      catch(e){
        opens=List.generate(storage.length, (index) => index);
      }

    len=opens.length;
    numlist = List.generate(len, (index) => index);
    numlist.shuffle();
    isCrossPressed = List.filled(len, false);
    isCheckPressed = List.filled(len, false);
    // navigate back to the login page with the selected level
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Level'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _selectedLevel == null ? null : _done,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: numlists,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: _selectedLevel == index + 1 ? Colors.grey.shade300 : null, // highlight selected level
            child: ListTile(
              title: Text('Level ${index + 1}'),
              trailing: (openLevels <index) ? Icon(Icons.lock) : null,
              onTap: () {
                if (openLevels >= index) {
                  _selectLevel(index);
                }
              }
            ),
          );
        },
      ),
    );
  }
}

