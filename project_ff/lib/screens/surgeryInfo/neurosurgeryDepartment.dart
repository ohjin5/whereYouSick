import 'package:flutter/material.dart';
import 'package:project/screens/videoPlay.dart';
//신경외과

class NeurosurgeryDepartment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('신경외과 수술')),
      body: ListView(
        // 1. 리스트뷰 생성하고
        children: <Widget>[
          ListTile(
            // 2. 리스트 항목 추가하면 끝!
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('척추 내시경수술'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '스케일링',
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('신경 섬유종 수술'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '신경 섬유종 수술',
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('두개저 수술'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlayerScreen(
                        department: '두개저 수술',
                      )));
            },
          ),
        ],
      ),
    );
  }
}
