// ignore_for_file: prefer_collection_literals

import 'dart:convert'; //이거 추가

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //이거 추가
import 'package:intl/intl.dart';
import 'package:project/screens/autoLogin.dart';

String certificates = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CertificationCheckPage(title: '증명서 요청'),
    );
  }
}

class CertificationCheckPage extends StatefulWidget {
  CertificationCheckPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CertificationCheckPage> {
  static String _url = 'http://localhost:3000/certificates'; // 이거 추가
  Uri uri = Uri.parse(_url); // 이거 추가
  final List<String> _texts = [
    "진단서",
    "수술 확인서",
    "입원 사실 확인서",
    "초진 기록지",
    "피검사 결과지",
    "영상 검사 판독지",
    "진료비 세부 내역서",
    "진료비 영수증",
    "입퇴원 확인서",
  ];

  late List<bool> _isChecked; // 체크된값.
  late List<String> _checkedTime;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
    _checkedTime = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('필요 서류를 선택하십시오.'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _texts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: CheckboxListTile(
                      title: Text(_texts[index]),
                      value: _isChecked[index],
                      onChanged: (val) {
                        setState(
                          () {
                            _isChecked[index] = val!;
                            print(_texts[index]);
                            if (_isChecked[index] == true) {
                              _checkedTime.add(_texts[index]);
                            } else {
                              _checkedTime.remove(_texts[index]);
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('신청'),
                onPressed: () async {
                  int z = 0;
                  for (int i = 0; i < _isChecked.length; i++) {
                    if (_isChecked[i] == false) z++;
                  }
                  if (z == _texts.length)
                    _showDialog_null(context, '\n 선택하신 증명서가 없습니다.');
                  else {
                    _showDialog(context, '\n 퇴원일에 원무과에서 찾아가십시오.');
                    String checkString = 'null';
                    String certificates = '';
                    for (int i = 0; i < _checkedTime.length; i++) {
                      if (_checkedTime[i] != null) {
                        checkString = _checkedTime[i];
                        if (i == 0) certificates = checkString;
                        if (i > 0) certificates += ', ' + checkString;
                      }
                    }
                    print(certificates);
                    DateTime now = new DateTime.now();
                    String inTime = now.toString();
                    var mtoken = '';
                    var token = giveUser();
                    mtoken = token.replaceFirst('generatedtoken', '');
                    print(mtoken);
                    // _checkedTime = []; 식으로 출력됨
                    // certifacates = '_checkedTime[0], _checkTime[1]'; 이런 식으로 저장 필요

                    Map data = {
                      "token": mtoken,
                      "certificates": certificates,
                      "requesttime": inTime
                    };
                    print(data);
                    String body = json.encode(data);
                    print(body);
                    http.Response response = await http.post(uri,
                        headers: {"Content-Type": "application/json"},
                        body: body);
                    print(response.body);
                  }
                },
              ),
            )
          ],
        ));
  }

  void _showDialog(BuildContext context, String text) {
    // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('<신청 완료>'),
            content: Text('$text'),
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            // actions: <Widget>[
            //     FlatButton(child: Text('확인'), onPressed: () => Navigator.pop(context)),
            // ],
          );
        });
  }

  void _showDialog_null(BuildContext context, String text) {
    // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('<신청 오류>'),
            content: Text('$text'),
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            // actions: <Widget>[
            //     FlatButton(child: Text('확인'), onPressed: () => Navigator.pop(context)),
            // ],
          );
        });
  }
}
