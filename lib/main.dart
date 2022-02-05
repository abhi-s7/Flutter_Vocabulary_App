import 'package:flutter/material.dart';
import 'package:wordbot/screen/HomeScreen.dart';
import 'package:wordbot/screen/LearnWordCategoryScreen.dart';
import 'package:wordbot/screen/LearnWordsScreen.dart';
import 'package:wordbot/screen/ReviseWordsCategoryScreen.dart';
import 'package:wordbot/screen/ReviseWordsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LearnWordCategoryScreen.id: (context) => LearnWordCategoryScreen(),
        LearnWordsScreen.id: (context) => LearnWordsScreen(),
        ReviseWordsCategoryScreen.id: (context) => ReviseWordsCategoryScreen(),
        ReviseWordsScreen.id: (context) => ReviseWordsScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
