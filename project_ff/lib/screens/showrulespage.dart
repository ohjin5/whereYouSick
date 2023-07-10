import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showrulespage extends StatelessWidget {
  showrulespage(this.title, this.num);
  final String title;
  final String num;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontFamily: 'aggro'),
        ),
      ),
      body: Center(
        child: Image.asset('assets/images/${num}.png'),
      ),
    );
  }
}
