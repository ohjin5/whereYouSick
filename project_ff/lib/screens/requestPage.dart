// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'dart:convert'; //이거 추가
import 'package:http/http.dart' as http; //이거 추가
import 'package:intl/intl.dart';
import 'package:project/screens/autoLogin.dart';

void main() {
  runApp(MyApp());
}

List<String> requestItems = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: requestPage('요청 사항'),
    );
  }
}

class requestPage extends StatefulWidget {
  requestPage(this.title);

  final String title;

  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<requestPage> {
  static String _url = 'http://localhost:3000/request';
  Uri uri = Uri.parse(_url); // 이거 추가
  final List<String> _texts = [
    "거즈",
    "환자복 교환",
    "침대보 교환",
    "화장실 보조",
    "물주쎄용",
    "진통제",
    "기저귀 교환"
  ];
  int count = 1;
  late List<bool> _isChecked; // 체크된값.
  late List<String> _checkedTime;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
    // ignore: deprecated_member_use
    _checkedTime = [];
  }

  String otherReq = '';
  @override
  Widget build(BuildContext context) {
    double deviceSize = MediaQuery.of(context).size.width;
    final inputController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text('요청 사항을 선택해주세요.'),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 5,
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
            Flexible(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    width: (deviceSize / 1.5),
                    child: SizedBox(
                      child: TextField(
                        controller: inputController,
                        onSubmitted: (value) {
                          //서버로 보내서 return select * from patient where name = value
                          otherReq = value.toString();
                          _checkedTime.add(otherReq);
                        },
                        onChanged: (value) {
                          if (value != '') otherReq = value.toString();
                        },
                        decoration: InputDecoration(
                            labelText: "그 외 요구 사항 (작성 후 확인 버튼을 눌러주세요.)"),
                        autofocus: true,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        _checkedTime.add(otherReq);
                        _okDialog(context, otherReq);
                      },
                      child: (Text('확인')))
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: ElevatedButton(
                child: Text('요청 사항 전송'),
                onPressed: () async {
                  String checkString = '';
                  String requests = '';
                  for (int i = 0; i < _checkedTime.length; i++) {
                    if (_checkedTime[i] != null) {
                      checkString = _checkedTime[i];
                      if (i == 0) requests = checkString;
                      if (i > 0) requests += ', ' + checkString;
                    }
                  }
                  print(_checkedTime);
                  if (_checkedTime.length == 0)
                    _showDialog_null(context, '\n 요청사항을 선택해주세요!');
                  else {
                    _showDialog(context, '\n 요청사항을 전달했습니다!');

                    DateTime now = new DateTime.now();
                    String inTime = now.toString();
                    var mtoken = '';
                    var token = giveUser();
                    mtoken = token.replaceFirst('generatedtoken', '');
                    print(mtoken);
                    Map data = {
                      "token": mtoken,
                      "requests": requests,
                      "requesttime": inTime
                    };
                    print(data);
                    String body = json.encode(data);
                    print(body);
                    http.Response response = await http.post(uri,
                        headers: {"Content-Type": "application/json"},
                        body: body);
                    print(response.body);
                    //체크된 값을 db로 보내서 인서트 한다.
                  }
                },
              ),
            )
          ],
        ));
  }

  void _okDialog(BuildContext context, String text) {
    // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('입력한 내용은 $text 입니다.'),
            content: Text('하단 전송 버튼을 눌러 전송을 완료해주세요.'),
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            actions: <Widget>[
              ElevatedButton(
                  child: Text('확인'), onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }

  void _showDialog(BuildContext context, String text) {
    // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('신청 완료!'),
            content: Text('$text'),
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            actions: <Widget>[
              ElevatedButton(
                  child: Text('확인'), onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }

  void _showDialog_null(BuildContext context, String text) {
    // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('오류 발생!'),
            content: Text('$text'),
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            actions: <Widget>[
              ElevatedButton(
                  child: Text('확인'), onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }
}
