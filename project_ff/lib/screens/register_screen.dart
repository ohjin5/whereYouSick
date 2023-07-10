import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:project/main.dart';
import 'package:project/screens/autoLogin.dart';
import 'package:project/screens/homePage.dart';
import 'package:project/screens/requestPage.dart';
import 'package:http/http.dart' as http; //이거 추가
import 'package:project/screens/autoLogin.dart';
import 'dart:convert'; //이거 추가
import 'package:intl/intl.dart';

class genderCheck extends StatefulWidget {
  const genderCheck({Key? key}) : super(key: key);

  @override
  _genderCheck createState() => _genderCheck();
}

class _genderCheck extends State<genderCheck> {
  String? checkListValue1;
  List<String?> checkListValue2 = [];
  List<String> checkList1 = ["남성", "여성"];

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('남성'),
        Checkbox(
          onChanged: (bool? check) {
            setState(() => this.checkListValue1 = '남성');
            patientInfor[1] = this.checkListValue1!;
            checkList[1] = true;
            print(this.checkListValue1);
          },
          value: this.checkListValue1 == '남성' ? true : false,
        ),
        SizedBox(width: 40),
        Text('여성'),
        Checkbox(
          onChanged: (bool? check) {
            setState(() => this.checkListValue1 = '여성');
            patientInfor[1] = this.checkListValue1!;
            checkList[1] = true;
            print(this.checkListValue1);
          },
          value: this.checkListValue1 == '여성' ? true : false,
        ),
      ])
    ]);
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환자 등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Text("아래의 칸을 모두 작성해주세요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'aggro',
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            CustomForm(),
          ],
        ),
      ),
    );
  }
}

late String token = '';
final List<bool> checkList =
    List<bool>.generate(requiredInfor.length, (int index) => false);
late List<String> patientInfor = ['', '', '', '', '', '', ''];
List<String> requiredInfor = [
  '성명',
  '성별',
  '생년월일 ex)20221109',
  '전화번호',
  '주소',
  '입원 사유',
  '퇴원일 ex)20221109'
];

class CustomForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(checkList);
    return Form(
      // 글로벌 key를 Form 태그에 연결하여 Form의 상태를 관리
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(requiredInfor[0], 0),
          SizedBox(height: 30),
          CustomTextFormField(requiredInfor[1], 1),
          SizedBox(height: 30),
          DateTextFormField(requiredInfor[2], 2),
          SizedBox(height: 30),
          PhoneTextFormField(requiredInfor[3], 3),
          SizedBox(height: 30),
          CustomTextFormField(requiredInfor[4], 4),
          SizedBox(height: 30),
          CustomTextFormField(requiredInfor[5], 5),
          SizedBox(height: 30),
          DateTextFormField(requiredInfor[6], 6),
          SizedBox(height: 30),
          RegisterButton(_formKey),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final String title;
  const Logo(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String text;
  final int num;

  const CustomTextFormField(this.text, this.num);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: 5),
        if (num == 1)
          genderCheck()
        else
          TextFormField(
            validator: (value) => value!.isEmpty ? "필수입력" : null,
            decoration: InputDecoration(hintText: " $text을/를 입력해주십시오."),
            onChanged: (value) {
              if (value == '')
                checkList[num] = false;
              else {
                checkList[num] = true;
                patientInfor[num] = value;
                print(value);
              }
            },
            onSaved: (newValue) {
              if (newValue == '')
                checkList[num] = false;
              else {
                checkList[num] = true;
                print(newValue);
              }
            },
          ),
      ],
    );
  }
}

class DateTextFormField extends StatelessWidget {
  final String text;
  final int num;
  const DateTextFormField(this.text, this.num);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: 5),
        if (num == 2)
          TextFormField(
            maxLength: 8,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.datetime,
            validator: (value) => value!.isEmpty ? "필수입력" : null,
            decoration: InputDecoration(hintText: " 생년월일을 입력해주십시오."),
            onChanged: (value) {
              if (value == '')
                checkList[num] = false;
              else {
                checkList[num] = true;
                patientInfor[num] = value;
                print(value);
              }
            },
            onSaved: (newValue) {
              if (newValue == '')
                checkList[num] = false;
              else {
                checkList[num] = true;
                print(newValue);
              }
            },
          )
        else if (num == 6)
          TextFormField(
            maxLength: 8,
            keyboardType: TextInputType.datetime,
            validator: (value) => value!.isEmpty ? "필수입력" : null,
            decoration: InputDecoration(hintText: "퇴원일을 입력해주십시오."),
            onChanged: (value) {
              if (value == '')
                checkList[num] = false;
              else {
                checkList[num] = true;
                patientInfor[num] = value;
                print(value);
              }
            },
            onSaved: (newValue) {
              if (newValue == '')
                checkList[num] = false;
              else {
                checkList[num] = true;
                print(newValue);
              }
            },
          )
      ],
    );
  }
}

class PhoneTextFormField extends StatelessWidget {
  final String text;
  final int num;
  const PhoneTextFormField(this.text, this.num);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: 5),
        TextFormField(
          maxLength: 11,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.phone,
          validator: (value) {
            value!.isEmpty ? "필수입력" : null;
            if (value.length != 11) {
              return '휴대폰 번호를 정확히 입력해주십시오.';
            }
          },
          decoration: InputDecoration(hintText: "휴대폰 번호를 입력해주십시오."),
          onChanged: (value) {
            if (value == '')
              checkList[num] = false;
            else {
              checkList[num] = true;
              patientInfor[num] = value;
              print(value);
            }
          },
          onSaved: (newValue) {
            if (newValue == '')
              checkList[num] = false;
            else {
              checkList[num] = true;
              //print(patientInfor);
              print(newValue);
            }
          },
        ),
      ],
    );
  }
}

class RegisterButton extends StatelessWidget {
  static String _url = 'http://localhost:3000/register'; // 이거 추가
  Uri uri = Uri.parse(_url); // 이거 추가
  static final storage =
      new FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  final GlobalKey<FormState> formKey;
  RegisterButton(this.formKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton.icon(
        label: Text("등록 완료"),
        icon: Icon(Icons.person_add),
        onPressed: () async {
          print(checkList);
          if (checkList.contains(false) == true)
            _showDialog_null(context, '\n 빈칸을 모두 작성해주세요!');
          else if (!checkList.contains(false)) {
            print(patientInfor[0]);
            token = changeTosecure(patientInfor[0]);
            patientInfor.add(token);
            //patientInfor 서버로 전달 후 DB에 저장 필요
            // token 저장해서 자동 로그인 필요
            _showDialog(context, '\n 환자 등록이 완료되었습니다!');
            await storage.write(
                key: "login", value: "generatedtoken" + token.toString());
          }
          DateTime now = new DateTime.now();
          String inTime = DateFormat('yyyyMMdd').format(now);
          Map data = {
            "name": patientInfor[0],
            "gender": patientInfor[1],
            "birthday": patientInfor[2],
            "phone": patientInfor[3],
            "address": patientInfor[4],
            "reason": patientInfor[5],
            "patient_outdate": patientInfor[6],
            "patient_indate": inTime,
            "token": token,
          };
          print(givetoken(token));
          print(data);
          var body = json.encode(data);
          print(body);
          http.Response response = await http.post(uri,
              headers: {"Content-Type": "application/json"}, body: body);
          print(response.body);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.black38, padding: EdgeInsets.all(10)),
      ),
    );
  }

  void _showDialog(BuildContext context, String text) {
    // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('등록 완료!'),
            content: Text('$text'),
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            actions: <Widget>[
              ElevatedButton(
                  child: Text('확인'),
                  onPressed: () => Get.to(() => homePage(
                        title: '원하시는 기능을 선택하세요.',
                      )))
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
          );
        });
  }
}

class givetoken {
  final String generatedtoken;
  givetoken(this.generatedtoken);
}
