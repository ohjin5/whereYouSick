import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screens/noticeInfo.dart';
import 'dart:convert'; //이거 추가
import 'package:http/http.dart' as http; //이거 추가

var res;
var Mytitle;
var Mycontent;
int a = 0;
String noticeurl = 'http://localhost:3000/getnotice';

class NoticePage extends StatefulWidget {
  NoticePage({Key? key}) : super(key: key);
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  var parsed = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지 사항'),
      ),
      body: ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.black,
              ),
          itemCount: parsed.length, //리스트의 개수
          itemBuilder: (BuildContext context, int index) {
            //리스트의 반목문 항목 형성
            return Container(
              height: 70,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => noticeInfo(
                              title: '${parsed[index]['title']}',
                              notice: '${parsed[index]['content']}')));
                    },
                    icon: Icon(Icons.circle_outlined, size: 20.0),
                    label: Text(
                      '${parsed[index]['title']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    style: TextButton.styleFrom(primary: Colors.black),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
