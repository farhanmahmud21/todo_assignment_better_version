import 'package:flutter/material.dart';
import 'package:to_do_final/mainScreen.dart';

void main() {
  runApp(const TaskManagement());
}

class TaskManagement extends StatelessWidget {
  const TaskManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.limeAccent,
          primarySwatch: Colors.amber,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 177, 188, 20))),
      home: const Main_Screen(),
    );
  }
}
