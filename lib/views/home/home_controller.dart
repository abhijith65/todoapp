import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/textstyle.dart';
import '../../database/database.dart';

class HomeController extends ChangeNotifier{
HomeController(){
  readTask();
}
String _selectedValue = "all";

String get selectedValue => _selectedValue;

void setSelectedValue(String value) {
  _selectedValue = value;
  notifyListeners();
}
final titleController = TextEditingController();
final contentController = TextEditingController();
final levelController = TextEditingController();
String level='high';
String done='false';
List<Map<String, dynamic>> tasklist = [];
List<Map<String, dynamic>> taskFromdb = [];
  Future<void> readTask() async {
  taskFromdb = await SQLHelper.readNote();
     tasklist = taskFromdb;
    notifyListeners();
  }

void createNote(BuildContext context) async {
  String title = titleController.text;
  String content = contentController.text;
  String levels=levelController.text;
  print('create note before db');
  int id = await SQLHelper.createNote(title, content,levels,done );
  readTask();
  print('create note after db');// update the list instantly
  if (id != null) {
    print('success');
    // showSuccessSnackBar(context);
  } else {
    print('error by me');
    // showErrorSnackBar(context);
  }
}

Future<void> updateNote(int id,
    String utitle, String ucontent,level,done) async{
  print('done is $done');
  await SQLHelper.update(id,utitle,ucontent,level,done);
  readTask();
}

Future<void> deleteIt(int id) async{
  print('deletenote pressed');
  await SQLHelper.deleteNote(id);
  print('deletenote pressed after');
  readTask();
}

  showSheet(int? id, BuildContext context) {
    if (id != null) {
      final existingTask = tasklist.firstWhere((element) => element['id'] == id);
      titleController.text   = existingTask['title'];
      contentController.text = existingTask['content'];
    }
    showDialog(context: context, builder: (context){
      return Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,),
          //  bottom: MediaQuery.of(context).viewInsets.bottom + 120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      hintText: "Title", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                child: TextField(
                  maxLines: 3,
                  controller: contentController,
                  decoration: const InputDecoration(
                      hintText: "Content", border: OutlineInputBorder()),
                ),
              ),
              Wrap(
                  children: [
                    Text('priority level: ',style: MyTextThemes.bodyTextStyle,),
                    Container(
                      color: Colors.blueGrey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          controller: levelController,
                          decoration: InputDecoration(
                            hintText: 'high , medium or low',
                            border: InputBorder.none,filled: true
                          ),
                        )
                      ),
                    ),
                  ]
              ),
              MaterialButton(
                  color: MyColors.basicColor,
                  shape: const StadiumBorder(),
                  onPressed: () {
                    print('button press');

                    if(id == null) {
                      createNote(context);
                    }
                    if(id != null){
                      updateNote(id,titleController.text,
                          contentController.text,levelController.text,done);
                    }
                    levelController.clear();
                    titleController.clear();
                    contentController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(id == null
                      ? "Create Note"
                      : "Update Note"))
            ],
          ),
        ),
      );
    });
  }
// Filter todos by category
void filterBylevel(String e) {
  _selectedValue = e;
  if (e == 'all') {
    readTask();
  } else {
    tasklist = taskFromdb.where((todo) => todo['level'] == e).toList();
    notifyListeners();
  }
}

}