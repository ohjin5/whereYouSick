import 'package:flutter/material.dart';
import 'package:project/screens/videoPlay.dart';
//치과

class DentistryDepartment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('치과 수술')),
      body: ListView(
        // 1. 리스트뷰 생성하고
        children: <Widget>[
          ListTile(
            // 2. 리스트 항목 추가하면 끝!
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('교정'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '교정',
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('스케일링'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '스케일링',
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('발치'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '발치',
                      )));
            },
          ),
        ],
      ),
    );
  }
}
