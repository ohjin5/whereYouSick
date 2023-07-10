import 'package:flutter/material.dart';
import 'package:project/screens/showrulespage.dart';

class ListviewPage extends StatefulWidget {
  const ListviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _ListviewPageState createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  @override
  Widget build(BuildContext context) {
    List<TextButton> buttonList = [
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => showrulespage('지침약 안내', '5')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '지침약 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => showrulespage('시간 안내', '8')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '시간 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  showrulespage('편의 시설 안내', '7')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '편의시설 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  showrulespage('낙상 및 욕창 예방 안내', '2')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '낙상/욕창 예방 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  showrulespage('면회 시간 안내', '6')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '면회시간 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  showrulespage('외출 및 퇴원 안내', '1')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '외출 및 퇴원 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  showrulespage('불만 및 고충처리 안내', '3')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '불만 및 고충처리 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => showrulespage('손씻기 안내', '4')));
        },
        icon: Icon(Icons.info_outline_rounded, size: 20.0),
        label: Text(
          '손씻기 안내',
          style: TextStyle(fontSize: 20.0),
        ),
        style: TextButton.styleFrom(primary: Colors.black),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('입원 생활 안내'),
      ),
      body: ListView.separated(
          scrollDirection:
              Axis.vertical, //vertical : 수직으로 나열 / horizontal : 수평으로 나열
          separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.black,
              ), //separatorBuilder : item과 item 사이에 그려질 위젯 (개수는 itemCount -1 이 된다)
          itemCount: 8, //리스트의 개수
          itemBuilder: (BuildContext context, int index) {
            //리스트의 반목문 항목 형성
            return Container(
              height: 70,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonList[index],
                ],
              ),
            );
          }),
    );
  }
}
