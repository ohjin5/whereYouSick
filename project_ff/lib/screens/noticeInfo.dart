import 'package:flutter/material.dart';

String n = 'title';
String t = 'content';

class noticeInfo extends StatefulWidget {
  String title;
  String notice;
  noticeInfo({Key? key, required this.notice, required this.title})
      : super(key: key) {
    n = notice;
    t = title;
  }
  @override
  _noticeInfoState createState() => _noticeInfoState();
}

class _noticeInfoState extends State<noticeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              n,
              style: TextStyle(fontFamily: 'aggro', fontSize: 32),
            )
            //ElevatedButton(onPressed: (){}, child: Text)
          ],
        ),
      ),
    );
  }
}
