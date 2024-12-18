

 import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/views/home/home_controller.dart';

import 'package:todo_app/views/home/home_view.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: false),
      home: Home(),
    );
  }
}
