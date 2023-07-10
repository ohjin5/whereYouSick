import 'package:flutter/material.dart';
import 'package:project/todo/calendar.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "어디! 아퍼?",
      home: Calendar(),
    );
  }
}
