import 'package:flutter/material.dart';
import 'package:project/screens/surgeryInfo/dentistry.dart';
import 'package:project/screens/surgeryInfo/gynecologistDepartment.dart';
import 'package:project/screens/surgeryInfo/neurosurgeryDepartment.dart';
import 'package:project/screens/surgeryInfo/orthopedicsDepartment.dart';
import 'package:project/screens/surgeryInfo/surgeryDepartment.dart';
import 'package:project/screens/videoPlay.dart';

import 'surgeryInfo/internalDepartment.dart';

class surgeryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('부서별 수술 종류')),
      body: ListView(
        // 1. 리스트뷰 생성하고
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('치과'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DentistryDepartment()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('산부인과'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => GynecologistDepartment()));
            },
          ),
          ListTile(
            // 2. 리스트 항목 추가하면 끝!
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('외과'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SurgeryDepartment()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('내과'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => InternalDepartment()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('정형외과'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OrthopedicsDepartment()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_queue_rounded),
            title: Text('신경외과'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NeurosurgeryDepartment()));
            },
          ),
        ],
      ),
    );
  }
}
