import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';

class LevelButton extends StatelessWidget {
   LevelButton(this.name);
   String? name;
  @override
  Widget build(BuildContext context) {
    return Card(
      color:MyColors.lvlcolor['$name'],
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(name??''),
      ),
    );
  }
}
