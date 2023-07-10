import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/homePage.dart';
import 'package:project/screens/showrulespage.dart';
import 'dart:convert'; //이거 추가
import 'package:http/http.dart' as http; //이거 추가
import 'package:project/screens/autoLogin.dart';

class BobScreen extends StatefulWidget {
  const BobScreen({Key? key}) : super(key: key);

  @override
  State<BobScreen> createState() => _BobScreenState();
}

String selected = '';

class _BobScreenState extends State<BobScreen> {
  static String _url = 'http://localhost:3000/meal';
  Uri uri = Uri.parse(_url); // 이거 추가
  String result = '';
  bool isBasic = true;
  bool isSpecial = false;
  bool isNofood = false;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isBasic, isSpecial, isNofood];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              '식사 신청 및 식단 정보',
              style: TextStyle(
                fontFamily: 'aggro',
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('일반식',
                            style:
                                TextStyle(fontFamily: 'aggro', fontSize: 18))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('특식',
                            style:
                                TextStyle(fontFamily: 'aggro', fontSize: 18))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('금식',
                            style:
                                TextStyle(fontFamily: 'aggro', fontSize: 18))),
                  ],
                  isSelected: isSelected,
                  onPressed: toggleSelect,
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Container(
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  showrulespage('식단표', 'menu')));
                        },
                        icon: Icon(Icons.event_note),
                        label: Text(
                          '식단표 확인',
                          style: TextStyle(fontSize: 20.0, fontFamily: 'aggro'),
                        ),
                        style: TextButton.styleFrom(primary: Colors.black),
                      )
                    ])),
          )),
    );
  }

  void toggleSelect(value) {
    if (value == 0) {
      isBasic = true;
      isSpecial = false;
      isNofood = false;
      AlertDialog;
      void _showDialog(BuildContext context, String text) {
        // 경고창을 보여주는 가장 흔한 방법.
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text('식단 선택 완료!'),
                content: Text('$text'),
                // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
                actions: <Widget>[
                  TextButton(
                      child: Text('확인'),
                      onPressed: () async {
                        Navigator.pop(context);
                        selected = '일반식';
                        DateTime now = new DateTime.now();
                        String inTime = now.toString();
                        var mtoken = '';
                        var token = giveUser();
                        mtoken = token.replaceFirst('generatedtoken', '');
                        print(mtoken);
                        Map data = {
                          "token": mtoken,
                          "meal": selected,
                          "requesttime": inTime
                        };
                        print(data);
                        String body = json.encode(data);
                        print(body);
                        http.Response response = await http.post(uri,
                            headers: {"Content-Type": "application/json"},
                            body: body);
                        print(response.body);
                      }),
                  TextButton(
                      child: Text('취소'),
                      onPressed: () => Navigator.pop(context)),
                ],
              );
            });
      }

      _showDialog(context, '일반식을 선택하셨습니다. \n(맞다면 확인 아니라면 취소를 눌러주세요.)');
    }
    if (value == 1) {
      isBasic = false;
      isSpecial = true;
      isNofood = false;
      AlertDialog;
      void _showDialog(BuildContext context, String text) {
        // 경고창을 보여주는 가장 흔한 방법.
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text('식단 선택 완료!'),
                content: Text('$text'),
                actions: <Widget>[
                  TextButton(
                      child: Text('확인'),
                      onPressed: () async {
                        Navigator.pop(context);
                        selected = '특식';
                        DateTime now = new DateTime.now();
                        String inTime = now.toString();
                        var mtoken = '';
                        var token = giveUser();
                        mtoken = token.replaceFirst('generatedtoken', '');
                        print(mtoken);
                        Map data = {
                          "token": mtoken,
                          "meal": selected,
                          "requesttime": inTime
                        };
                        print(data);
                        String body = json.encode(data);
                        print(body);
                        http.Response response = await http.post(uri,
                            headers: {"Content-Type": "application/json"},
                            body: body);
                        print(response.body);
                      }),
                  TextButton(
                      child: Text('취소'),
                      onPressed: () => Navigator.pop(context)),
                ],
                // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
                // actions: <Widget>[
                //     FlatButton(child: Text('확인'), onPressed: () => Navigator.pop(context)),
                // ],
              );
            });
      }

      _showDialog(context, '특식을 선택하셨습니다. \n(맞다면 확인 아니라면 취소를 눌러주세요.)');
    }
    if (value == 2) {
      isBasic = false;
      isSpecial = false;
      isNofood = true;
      AlertDialog;
      void _showDialog(BuildContext context, String text) {
        // 경고창을 보여주는 가장 흔한 방법.
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text('식단 선택 완료!'),
                content: Text('$text'),
                actions: <Widget>[
                  TextButton(
                      child: Text('확인'),
                      onPressed: () async {
                        Navigator.pop(context);
                        selected = '금식';
                        DateTime now = new DateTime.now();
                        String inTime = now.toString();
                        var mtoken = '';
                        var token = giveUser();
                        mtoken = token.replaceFirst('generatedtoken', '');
                        print(mtoken);
                        Map data = {
                          "token": mtoken,
                          "meal": selected,
                          "requesttime": inTime
                        };
                        print(data);
                        String body = json.encode(data);
                        print(body);
                        http.Response response = await http.post(uri,
                            headers: {"Content-Type": "application/json"},
                            body: body);
                        print(response.body);
                      }),
                  TextButton(
                      child: Text('취소'),
                      onPressed: () => Navigator.pop(context)),
                ],
                // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
                // actions: <Widget>[
                //     FlatButton(child: Text('확인'), onPressed: () => Navigator.pop(context)),
                // ],
              );
            });
      }

      _showDialog(context, '금식을 선택하셨습니다. \n(맞다면 확인 아니라면 취소를 눌러주세요.)');
    }

    setState(() {
      isSelected = [isBasic, isSpecial, isNofood];
    });
  }
}
