import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/views/home/home_controller.dart';
import 'package:todo_app/views/widget/button.dart';

import '../../constants/colors.dart';
import '../../constants/textstyle.dart';



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final home_controller = Provider.of<HomeController>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
         backgroundColor: MyColors.basicColor,

          title: Text(
            "Todo App",
            style: MyTextThemes.textHeading,
          ),
          actions: [
            Wrap(
              children: [
                Text('sort-',style: MyTextThemes.bodyTextStyle,),
                Consumer<HomeController>(
                  builder: (context, homecontroller, child) {
                    return DropdownButton<String>(
                      value: homecontroller.selectedValue,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          homecontroller.setSelectedValue(newValue);
                          home_controller.filterBylevel(newValue);
                        }
                      },
                      items: <String>['all', 'high', 'medium', 'low']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  },
                ),

              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.basicColor,
          onPressed: () => home_controller.showSheet(null,context), // while creating a note id wil be null
          child: const Icon(
            Icons.note_alt_outlined,
          ),
        ),
        body: home_controller.tasklist.isEmpty
            ? const Center(child: Text('you have no tasks'))
            :ListView.builder(
          itemCount: home_controller.tasklist.length,
            itemBuilder: (context,index){
              final task = home_controller.tasklist[index];
              return ListTile(
                leading:  IconButton(
                                        onPressed: () {
                                          print('deleteit pressed');
                                          home_controller.deleteIt(task['id']);
                                        },
                                        icon: const Icon(Icons.delete)) ,
                title:  Text(task['title'],style: MyTextThemes.bodyTextStyle,) ,
                subtitle: Wrap(children: [
                  Text('priority level: '),
                  LevelButton(task['level'])
                ]),
                trailing: IconButton(onPressed: (){
                  var g;
                  task['done']=='false'?g='true':g='false';

                  home_controller.updateNote(task['id'], task['title'], task['content'], task['level'],g);


                }, icon:task['done']=='false'? Icon(Icons.check_box_outline_blank):Icon(Icons.check_box)),
                onTap: (){
                  home_controller.showSheet(task['id'], context);
                },

              );
        })
      ),
    );
  }

  // final titleController = TextEditingController();
  // final contentController = TextEditingController();
  //
  // showSheet(int? id, BuildContext context) {
  //   if (id != null) {
  //     final existingTask = taskFromDb.firstWhere((element) => element['id'] == id);
  //     titleController.text   = existingTask['title'];
  //     contentController.text = existingTask['content'];
  //   }
  //   showDialog(context: context, builder: (context){
  //     return Card(
  //       child: Padding(
  //                   padding: EdgeInsets.only(
  //                       top: 15,
  //                       left: 15,
  //                       right: 15,),
  //                     //  bottom: MediaQuery.of(context).viewInsets.bottom + 120),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.all(10.0),
  //                         child: TextField(
  //                           controller: titleController,
  //                           decoration: const InputDecoration(
  //                               hintText: "Title", border: OutlineInputBorder()),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding:
  //                         const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
  //                         child: TextField(
  //                           maxLines: 3,
  //                           controller: contentController,
  //                           decoration: const InputDecoration(
  //                               hintText: "Content", border: OutlineInputBorder()),
  //                         ),
  //                       ),
  //                       Wrap(
  //                         children: [
  //                           Text('priority level: ',style: MyTextThemes.bodyTextStyle,),
  //                           Container(
  //                             color: Colors.blueGrey.shade200,
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(2.0),
  //                               child: PopupMenuButton(
  //                               initialValue: level,
  //                               onSelected: (e){
  //                                // setState(() {
  //                                //   level=e;
  //                                // });
  //                               },
  //                                 itemBuilder: (context){
  //                                   return [
  //                                   PopupMenuItem(
  //                                     value:'high' ,
  //                                     child: Text('high'),),
  //                                   PopupMenuItem(
  //                                   value:'medium' ,
  //                                   child: Text('medium'),),
  //                                   PopupMenuItem(
  //                                   value:'low' ,
  //                                   child: Text('low'),),];
  //                                 },
  //                               child: Text(level,style: MyTextThemes.levelTextStyle,),
  //                                                         ),
  //                             ),
  //                           ),
  //                         ]
  //                       ),
  //                       MaterialButton(
  //                           color: MyColors.basicColor,
  //                           shape: const StadiumBorder(),
  //                           onPressed: () {
  //                             print('button press');
  //
  //                             if(id == null) {
  //                               createNote(context);
  //                             }
  //                             if(id != null){
  //                               updateNote(id,titleController.text,
  //                                   contentController.text,level,done);
  //                             }
  //                             titleController.clear();
  //                             contentController.clear();
  //                             Navigator.pop(context);
  //                           },
  //                           child: Text(id == null
  //                               ? "Create Note"
  //                               : "Update Note"))
  //                     ],
  //                   ),
  //                 ),
  //     );
  //   });
  // }
  //
  // void createNote(BuildContext context) async {
  //   String title = titleController.text;
  //   String content = contentController.text;
  //   print('create note before db');
  //   int id = await SQLHelper.createNote(title, content,level,done );
  //   readTask();
  //   print('create note after db');// update the list instantly
  //   if (id != null) {
  //    print('success');
  //     // showSuccessSnackBar(context);
  //   } else {
  //    print('error by me');
  //    // showErrorSnackBar(context);
  //   }
  // }
  //
  // Future<void> updateNote(int id,
  //     String utitle, String ucontent,level,done) async{
  //   print('done is $done');
  //   await SQLHelper.update(id,utitle,ucontent,level,done);
  //   readTask();
  // }
  //
  // Future<void> deleteIt(int id) async{
  //   print('deletenote pressed');
  //   await SQLHelper.deleteNote(id);
  //   print('deletenote pressed after');
  //   readTask();
  // }


}