import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:project/main.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert'; //이거 추가
import 'package:project/screens/autoLogin.dart';
import 'package:http/http.dart' as http; //이거 추가

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

bool endTime = false;

class _SpeechScreenState extends State<SpeechScreen> {
  static String _url = 'http://localhost:3000/request';

  Uri uri = Uri.parse(_url);
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '왼쪽 아래의 버튼을 눌러 녹음 및 확인하세요.';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    flutterTts.speak(_text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
            style: TextStyle(
              fontFamily: 'aggro',
              fontSize: 24.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextHighlight(
              text: _text,
              words: _highlights,
              textStyle: const TextStyle(
                fontFamily: 'aggro',
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) async {
            switch (index) {
              case 0:
                if (endTime == false) {
                  _listen();
                  endTime = true;
                } else if (endTime == true) {
                  flutterTts.speak('녹음된 내용입니다. $_text');
                  flutterTts.speak('오른쪽 아래의 버튼을 눌러 전송을 완료하세요.');
                  endTime = false;
                }
                break;

              case 1:
                print(_text);
                flutterTts.speak('요청 사항을 전송합니다.');
                DateTime now = new DateTime.now();
                String inTime = now.toString();
                var mtoken = '';
                var token = giveUser();
                mtoken = token.replaceFirst('generatedtoken', '');
                print(mtoken);
                print(inTime);
                Map data = {
                  "token": mtoken,
                  "requests": _text,
                  "requesttime": inTime
                };
                print(data);
                String body = json.encode(data);
                print(body);
                http.Response response = await http.post(uri,
                    headers: {"Content-Type": "application/json"}, body: body);
                print(response);
                break;
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.mic), label: '녹음 및 확인'),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: '전송'),
          ],
        ));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
