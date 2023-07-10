import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/autoLogin.dart';
import 'package:project/screens/bob_screen.dart';
import 'package:project/screens/certificationCheckPage.dart';
import 'package:project/screens/list_screen.dart';
import 'package:project/screens/noticePage.dart';
import 'package:project/screens/requestPage.dart';
import 'package:project/screens/rule_screen.dart';
import 'package:project/screens/surgeryListPage.dart';
import 'package:http/http.dart' as http;
import 'package:project/screens/voice.dart';

bool ttsonoff = false;

class homePage extends StatelessWidget {
  FlutterTts flutterTts = FlutterTts();
  static String _url = 'http://localhost:3000/call';
  Uri uri = Uri.parse(_url);
  final String title;
  homePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<InkWell> buttonList = [
      InkWell(
        onTap: () {
          if (ttsonoff) flutterTts.speak("요청 사항입니다");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => requestPage('요청 사항')));
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/request.png'),
            ),
          ),
        ),
      ),
      //여기 아이콘 바꾸기
      InkWell(
        onTap: () {
          if (ttsonoff) flutterTts.speak("음성 인식 요청입니다.");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SpeechScreen()));
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mic.png'),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          if (ttsonoff) flutterTts.speak('증명서 신청입니다');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CertificationCheckPage(
                    title: 'Choose Your Certifications',
                  )));
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/certi.png'),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          if (ttsonoff) flutterTts.speak('의료 정보입니다.');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => surgeryList())); //수술 영상 재생 페이지
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/info.png'),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          if (ttsonoff) flutterTts.speak('입원 생활 안내입니다.');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ListviewPage()));
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/life.png'),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          if (ttsonoff) flutterTts.speak('식사 신청 및 식단 정보입니다.');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => BobScreen()));
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/food.png'),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          if (ttsonoff) flutterTts.speak('일정 확인 및 등록입니다.');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ListScreen()));
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/day.png'),
            ),
          ),
        ),
      ),
      //여기 아이콘 바꾸기
      InkWell(
        onTap: () {
          if (!ttsonoff) flutterTts.speak('음성 안내를 시작합니다.');
          if (ttsonoff) flutterTts.speak('음성 안내를 종료합니다.');
          ttsonoff = !(ttsonoff);
        }, // Handle your callback.
        splashColor: Colors.blue.withOpacity(0.8),
        child: Ink(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onoff.png'),
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              // Create a grid with 2 columns in portrait mode, or 3 columns in
              // landscape mode.
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(8, (index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonList[index],
                      const Padding(padding: EdgeInsets.all(20)),
                    ],
                  ),
                );
              }),
            );
          },
        )),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Container(
              height: 165,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              //모서리를 둥글게
                              borderRadius: BorderRadius.circular(20)),
                          onPrimary: Colors.white, //글자색
                          backgroundColor: Color.fromARGB(185, 13, 8, 142),
                          minimumSize: Size(90, 65), //width, height
                          //child 정렬 - 아래의 Text('$test')
                          alignment: Alignment.centerLeft,
                          textStyle: const TextStyle(fontSize: 29)),
                      child: Center(
                          child: Text(
                        '공지 사항',
                        style: TextStyle(fontFamily: 'aggro'),
                      )),
                      onPressed: () async {
                        if (ttsonoff) flutterTts.speak('병원 공지 사항입니다.');
                        http.Response res =
                            await http.get(Uri.parse(noticeurl));
                        var parsed = jsonDecode(res.body);
                        print(parsed.length);
                        print(parsed);
                        Get.to(() => NoticePage(), arguments: parsed);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              //모서리를 둥글게
                              borderRadius: BorderRadius.circular(20)),
                          onPrimary: Color.fromARGB(255, 255, 255, 255), //글자색
                          backgroundColor: Color.fromARGB(200, 43, 255, 0),
                          minimumSize: Size(90, 65), //width, height
                          //child 정렬 - 아래의 Text('$test')
                          alignment: Alignment.centerLeft,
                          textStyle: const TextStyle(fontSize: 29)),
                      child: Center(
                          child: Text(
                        '간호사 호출',
                        style: TextStyle(fontFamily: 'aggro'),
                      )),
                      onPressed: () async {
                        if (ttsonoff)
                          flutterTts.speak('간호사를 호출했습니다. 잠시만 기다려주십시오.');
                        _showDialog(context, '간호사를 호출했습니다! \n잠시만 기다려주십시오.');
                        DateTime now = new DateTime.now();
                        String inTime = now.toString();
                        var mtoken = '';
                        var token = giveUser();
                        mtoken = token.replaceFirst('generatedtoken', '');
                        print(mtoken);
                        // _checkedTime = []; 식으로 출력됨
                        // certifacates = '_checkedTime[0], _checkTime[1]'; 이런 식으로 저장 필요

                        Map data = {"token": mtoken, "requesttime": inTime};
                        print(data);
                        String body = json.encode(data);
                        print(body);
                        http.Response response = await http.post(uri,
                            headers: {"Content-Type": "application/json"},
                            body: body);
                        print(response.body);
                      },
                    ),
                  ])),
        ));
  }

  // API에 있는 showDialog 함수와 이름이 같아서 밑줄(_) 접두사(private 함수)
  void _showDialog(BuildContext context, String text) {
    // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('호출 완료!'),
            content: Text('$text'),
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            // actions: <Widget>[
            //     FlatButton(child: Text('확인'), onPressed: () => Navigator.pop(context)),
            // ],
          );
        });
  }
}
