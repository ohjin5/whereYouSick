import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screens/autoLogin.dart';
import 'package:project/screens/register_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('      순천향대학교 천안병원')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('어디! 아퍼?',
                style: TextStyle(
                  fontFamily: 'aggro',
                  fontWeight: FontWeight.bold,
                  fontSize: 57,
                  color: Color.fromARGB(255, 0, 229, 255),
                )),
            Text('\n\n당신의 스마트한 입원 생활을 도와드립니다.\n\n',
                style: TextStyle(
                  fontFamily: 'aggro',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 15, 124, 179),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontFamily: 'aggro'),
                primary: Color.fromARGB(255, 15, 124, 179), // background
                onPrimary: Color.fromARGB(255, 255, 255, 255), // foreground
              ),
              onPressed: () {
                // 자동 로그인 가능시 Get.to(() => homePage());
                //자동 로그인 실패 시
                print(showInfo());
                Get.to(() => LoginPage());
              },
              child: Text('시작하기'),
            ),
            SizedBox(height: 60),
            Text('Made by 박광범, 권오진, 김용범, 김인경',
                style: TextStyle(
                  fontFamily: 'aggro',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 101, 105, 91),
                )),
          ],
        ),
      ),
    );
  }
}
