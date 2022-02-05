import 'package:flutter/material.dart';
import 'package:wordbot/components/VocabListWidget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFddf3f5),
      body: ListView(
        children: [VocabListWidget()],
      ),
    );
  }
}
