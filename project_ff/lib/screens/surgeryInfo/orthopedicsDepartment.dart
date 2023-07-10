import 'package:flutter/material.dart';
import 'package:project/screens/videoPlay.dart';
//정형외과

class OrthopedicsDepartment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('정형외과 수술')),
      body: ListView(
        // 1. 리스트뷰 생성하고
        children: <Widget>[
          ListTile(
            // 2. 리스트 항목 추가하면 끝!
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('골절개술'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '골절개술',
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('배성형술'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '스케일링',
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('건절개술'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '스케일링',
                      )));
            },
          ),
        ],
      ),
    );
  }
}
