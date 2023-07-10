import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert'; // JSON Encode, Decode를 위한 패키지
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/screens/register_screen.dart'; // flutter_secure_storage 패키지
import 'package:encrypt/encrypt.dart' as en;
import 'homePage.dart';

String changeTosecure(String value) {
  final key = en.Key.fromSecureRandom(16);
  final iv = en.IV.fromSecureRandom(16);
  final encrypter = en.Encrypter(en.AES(key));
  final encrypted = encrypter.encrypt(value, iv: iv).base16;
  final result = encrypter.encrypt(value, iv: iv).base16;
  print(result);
  return result;
}

dynamic storedInfo = '';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final storage =
      new FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();
    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');
    storedInfo = userInfo;
    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo == null) {
      Get.to(() => RegisterScreen());
    } else {
      print('userInfo $storedInfo');

      print('token ${makeToken(userInfo).toKen}');
      Get.to(() => homePage(title: '원하시는 기능을 선택하세요.'));
    }
  }

  loginAction(accountName, password) async {
    // 직렬화를 이용하여 데이터를 입출력하기 위해 model.dart에 Login 정의 참고
    var val = jsonEncode(Login('$accountName', '$password'));

    await storage.write(
      key: 'login',
      value: val,
    );
    print('접속 성공!');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('로그인 중입니다.')),
        body: Center(
          child: Text('잠시만 기다려주세요!'),
        ));
  }
}

class makeToken {
  final String toKen;
  makeToken(this.toKen);
  Map<String, dynamic> toJson() => {'token': token};
}

class Login {
  final String generatedToken;
  final String name;
  Login(this.generatedToken, this.name);

  Map<String, dynamic> toJson() =>
      {'generatedToken': generatedToken, 'name': name};
}

class showInfo {
  void _showInfo() {
    print(storedInfo);
  }
}

String giveUser() {
  return storedInfo;
}
