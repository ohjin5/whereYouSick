import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ext_video_player/ext_video_player.dart';

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '수술 영상',
      home: VideoPlayerScreen(
        department: '',
      ),
    );
  }
}

String adress = 'null';

class VideoPlayerScreen extends StatefulWidget {
  String department;
  VideoPlayerScreen({Key? key, required this.department}) : super(key: key) {
    adress = department;
  }

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // VideoPlayerController를 저장하기 위한 변수를 만듭니다. VideoPlayerController는
    // asset, 파일, 인터넷 등의 영상들을 제어하기 위해 다양한 생성자를 제공합니다.
    //치과
    if (adress == '교정') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=vhWnOLD0BGY',
      ); //o
    } else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      ); // o
    } else if (adress == '발치') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=UxE8aXqYkyc',
      ); //o
      //산부인과
    } else if (adress == '자궁 근종 수술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=u6p0VS4Bp48',
      ); // o
    } else if (adress == '요실금 수술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=xISjS-b4Lwk',
      ); // o
    } else if (adress == '자궁 적출술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=u4PP_TbiDto',
      ); // o
      //내과
    } else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      ); // x
    } else if (adress == '대장 용종 절제술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=tkyFfN-IKHk&feature=youtu.be',
      ); // x
    } else if (adress == '대장 내시경 수술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=PUOzB5rdcmU',
      ); // o
    }
    //신경외과
    else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      ); // x
    } else if (adress == '신경 섬유종 수술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=G74Zoa1Y2JM',
      ); // x
    } else if (adress == '두개저 수술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=PSOX1j3nfQk',
      ); // o
      //외과
    } else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      ); //
    } else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      ); //
    } else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      );
      //정형외과
    } else if (adress == '골절개술') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=p0qvY9RjU9g',
      );
    } else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      );
    } else if (adress == '스케일링') {
      _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=56s9puhqPf8',
      );
    }

    // 컨트롤러를 초기화하고 추후 사용하기 위해 Future를 변수에 할당합니다.
    _initializeVideoPlayerFuture = _controller.initialize();

    // 비디오를 반복 재생하기 위해 컨트롤러를 사용합니다.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // 자원을 반환하기 위해 VideoPlayerController를 dispose 시키세요.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('수술 영상'),
      ),
      // VideoPlayerController가 초기화를 진행하는 동안 로딩 스피너를 보여주기 위해
      // FutureBuilder를 사용합니다.
      body: Center(
          child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
            // VideoPlayer의 종횡비를 제한하세요.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // 영상을 보여주기 위해 VideoPlayer 위젯을 사용합니다.
              child: VideoPlayer(_controller),
            );
          } else {
            // 만약 VideoPlayerController가 여전히 초기화 중이라면,
            // 로딩 스피너를 보여줍니다.
            return Center(child: CircularProgressIndicator());
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
          // 보여집니다.
          setState(() {
            // 영상이 재생 중이라면, 일시 중지 시킵니다.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // 만약 영상이 일시 중지 상태였다면, 재생합니다.
              _controller.play();
            }
          });
        },
        // 플레이어의 상태에 따라 올바른 아이콘을 보여줍니다.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // 이 마지막 콤마는 build 메서드에 자동 서식이 잘 적용될 수 있도록 도와줍니다.
    );
  }
}
