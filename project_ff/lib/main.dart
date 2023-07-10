import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:project/screens/bob_screen.dart';
import 'package:project/screens/certificationCheckPage.dart';
import 'package:project/screens/first_screen.dart';
import 'package:project/screens/list_screen.dart';
import 'package:project/screens/noticePage.dart';
import 'package:project/screens/requestPage.dart';
import 'package:project/screens/rule_screen.dart';
import 'package:project/screens/surgeryListPage.dart';

void main() {
  GetPage(name: '/adminweb', page: () => FirstScreen());
  runApp(const MyApp());
}

FlutterTts flutterTts = FlutterTts();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '어디! 아퍼?',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'aggro'),
      home: FirstScreen(),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;
  OrientationList({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<InkWell> buttonList = [
      InkWell(
        onTap: () {
          flutterTts.speak("요청 사항입니다");
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
      InkWell(
        onTap: () {
          flutterTts.speak("음성 안내 설정입니다.");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => requestPage('요청 사항')));
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
          flutterTts.speak("증명서 신청입니다");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CertificationCheckPage(
                    title: '필요한 서류를 선택하세요.',
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
          flutterTts.speak("수술 영상입니다");
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
          flutterTts.speak("입원 시 안내 사항입니다");
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
          flutterTts.speak("식사 요청입니다");
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
          flutterTts.speak("일정 관리입니다");
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
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(title)),
        body: Center(child: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              // Create a grid with 2 columns in portrait mode, or 3 columns in
              // landscape mode.
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(6, (index) {
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
                          textStyle: const TextStyle(
                              fontFamily: 'aggro', fontSize: 29)),
                      child: Center(
                          child: Text('공지 사항',
                              style: TextStyle(
                                fontFamily: 'aggro',
                              ))),
                      onPressed: () {
                        flutterTts.speak("공지 사항입니다");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => NoticePage()));
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
                          textStyle: const TextStyle(
                              fontFamily: 'aggro', fontSize: 29)),
                      child: Center(
                          child: Text('간호사 호출',
                              style: TextStyle(
                                fontFamily: 'aggro',
                              ))),
                      onPressed: () {
                        flutterTts.speak('간호사를 호출했습니다.');
                        _showDialog(context, '간호사를 호출했습니다! \n잠시만 기다려주십시오.');
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
