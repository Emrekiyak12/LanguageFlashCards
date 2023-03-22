import 'screens/home_page.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';


const _credentials= r'''
Use your own credentials here to access gsheets api. 
''';
const _credentials1= r'''
{
Use your own credentials here to access gsheets api. 
}
''';
const _credentials2= r'''
{
Use your own credentials here to access gsheets api. 
}
''';
var rell;
var gsheets;
var ss;
var ss1;
var ss2;
const _spreadsheetId = ['1JdZDvuKpeUIo_Ut731aDVL4dMhNDQt-YsXplmEfYJXA','1c-oPG_YJrvkhQmlYfBLXNUDkxsOjFgZ0H3iuRBJao1M','1JrFYVixQnUzmYzm_F5paYOkKY8_oEJdCaXjf21cx66c'];
Future<Map> get_data(String name)async {
  var sheet;
  if (type=="Lesson"){
    sheet = ss.worksheetByTitle(name);
  }
  else if (type=="Vocabulary"){
    sheet = ss1.worksheetByTitle(name);
  }
  else {
    sheet = ss2.worksheetByTitle(name);
  }
  rell = await sheet!.values.allColumns();
  var myMap= {};
  for (int i = 0; i < rell[1].length; i++) {
    myMap[rell[0][i]] = rell[1][i];
  }
  return myMap;
}

Future<int> get_lists() async {
  gsheets= GSheets(_credentials);
  ss = await gsheets.spreadsheet(_spreadsheetId[0]);
  gsheets= GSheets(_credentials1);
  ss1 = await gsheets.spreadsheet(_spreadsheetId[1]);
  gsheets= GSheets(_credentials2);
  ss2 = await gsheets.spreadsheet(_spreadsheetId[2]);
  return 0;
}

Future<void> saveData(String tr, String eng) async {
  final starred = await SharedPreferences.getInstance();
  await starred.setString(tr, eng);
}

Future<void> deleteData(String name) async {
  final starred = await SharedPreferences.getInstance();
  await starred.remove(name);

}
Future<bool> hasKey(String name) async{
  final starred = await SharedPreferences.getInstance();
  return starred.containsKey(name);
}

void cle()async{
  final starred = await SharedPreferences.getInstance();
  await starred.clear();
}

favs() async {
  final  SharedPreferences starred = await SharedPreferences.getInstance();
  final Map<String, dynamic> allValues = {};
  var keys= starred.getKeys();
  for (String key in keys) {
    allValues[key] = starred.get(key);
  }
  allValues.remove("Lesson");
  allValues.remove("Vocabulary");
  allValues.remove("Exam");
  for (int i = 0; i <= starred.getInt("Lesson")!+1; i++) {
    allValues.remove("LWrong"+i.toString());

  }
  for (int i = 0; i <= starred.getInt("Vocabulary")!+1; i++) {
    allValues.remove("VWrong"+i.toString());

  }
  for (int i = 1; i <= starred.getInt("Exam")!+1; i++) {
    allValues.remove("EWrong"+i.toString());

  }
  return allValues;
}

levels(String name) async {
  final  SharedPreferences currentLevel = await SharedPreferences.getInstance();
  try {
    int num= currentLevel.getInt(name)!;
    await currentLevel.setInt(name,num+1);
    print(currentLevel.getInt(name));
  }
  catch(e){
    print("$e");
  }
}
levelsGet(String name) async {
  try {
    final SharedPreferences currentLevel = await SharedPreferences.getInstance();
    int num = currentLevel.getInt(name)!;
    return num;
  }
  catch(e){
    final SharedPreferences currentLevel = await SharedPreferences.getInstance();
    await currentLevel.setInt("Lesson",0);
    await currentLevel.setInt("Vocabulary",0);
    await currentLevel.setInt("Exam",0);
    return currentLevel.getInt(name)!;
  }
}
returnWrongs(String x,String y)async{
  final SharedPreferences currentLevel = await SharedPreferences.getInstance();
  var a= currentLevel.getString(x[0]+"Wrong"+y);
  var List1=a!.split("/");
  return List1.map((str) => int.parse(str)).toList();


}
add() async {
  final  SharedPreferences currentLevel = await SharedPreferences.getInstance();
  await currentLevel.setInt("Lesson",0);
  await currentLevel.setInt("Vocabulary",0);
  await currentLevel.setInt("Exam",0);
}
reset(String type) async {
  final  SharedPreferences currentLevel = await SharedPreferences.getInstance();
  currentLevel.remove(type[0]+"Wrong"+levelnum);
}

Future<void> saveIncorrect(String type) async {
  List<int> x=[];
  final starred = await SharedPreferences.getInstance();
  for (int i = 0; i < len; i++){
    if(!isCheckPressed[i]){
      starred.setString(storage.keys.toList()[opens[numlist[i]]],storage.values.toList()[opens[numlist[i]]]);
      x.add(opens[numlist[i]]);

    }
  }
  x.sort();
  String a=x.join("/");
  if (type[0]!="W") {
    await starred.setString(type[0]+"Wrong"+levelnum,a);
  }
}
