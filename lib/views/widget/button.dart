import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/textstyle.dart';

class LevelButton extends StatelessWidget {
   LevelButton(this.name);
   final String? name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      child: Card(
        color:MyColors.lvlcolor['$name']?.withValues(alpha: .5),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(name??'',style: MyTextThemes.levelTextStyle,),
          ),
        ),
      ),
    );
  }
}
