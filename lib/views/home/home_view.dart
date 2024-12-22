import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
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

            title: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Todo App",
                style: MyTextThemes.textHeading,
              ),
            ),
            //bottom: TabBar(tabs: [Container()]),
            actions: [
              Wrap(
                children: [
                  Text('sort-', style: MyTextThemes.bodyTextStyle,),
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
            onPressed: () => home_controller.showSheet(null, context),
            // while creating a note id wil be null
            child: const Icon(
              Icons.note_alt_outlined,
            ),
          ),
          body: home_controller.tasklist.isEmpty
              ? const Center(child: Text('you have no tasks'))
              : ListView.builder(
              itemCount: home_controller.tasklist.length,
              itemBuilder: (context, index) {
                final task = home_controller.tasklist[index];
                return GlossyContainer(
                  borderRadius: BorderRadius.circular(15),
                  margin: const EdgeInsets.all(8.0),
                  height: 90,
                  width: double.infinity,
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    leading: IconButton(
                        onPressed: () {
                          debugPrint('deleteit pressed');
                          home_controller.deleteIt(task['id']);
                        },
                        icon: const Icon(Icons.remove_circle_outline)),
                    title: Text(
                      task['title'], style: MyTextThemes.bodyTextStyle,),
                    subtitle: Row(children: [
                      Text('priority '),
                      LevelButton(task['level'])
                    ]),
                    trailing: IconButton(onPressed: () {
                      var g;
                      task['done'] == 'false' ? g = 'true' : g = 'false';

                      home_controller.updateNote(
                          task['id'], task['title'], task['content'],
                          task['level'], g);
                    },
                        icon: task['done'] == 'false' ? Icon(
                            Icons.circle_outlined) : Icon(
                            Icons.task_alt)),
                    onTap: () {
                      home_controller.showSheet(task['id'], context);
                    },

                  ),
                );
              })
      ),
    );
  }
}