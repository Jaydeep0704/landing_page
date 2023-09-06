import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';

void main() {
  // runApp(const MyApp());
  runApp(MyApp2());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final videoUrl = 'https://grobiz.app/GrobizEcommerceSuperAdmin/images/Web/VN20230404_171559.mp4';

  late VideoPlayerController videoPlayerController;

  Future<VideoPlayerController?> initializeVideoPlayer() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await controller.initialize();
    return controller;
  }

  bool loaded = false;
  bool play = false;

  @override
  void initState() {
    // TODO: implement initState
    loaded = false;
    play = false;
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((value) {
            loaded = true;
            play = true;
            videoPlayerController.setLooping(true);
            videoPlayerController.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Video Player'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              width: 800,
              child: loaded == false
                  ? const CircularProgressIndicator()
                  : VideoPlayer(videoPlayerController),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (play == true) {
                      play = false;
                      videoPlayerController.pause();
                    } else if (play == false) {
                      play = true;
                      videoPlayerController.play();
                    }
                  });
                },
                child: Text(play == true ? "pause" : "play")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    // videoPlayerController.seekTo(position);
                    print("videoPlayerController.position");
                  });
                },
                child: Text( "position"))
          ],
        ),
        // child: FutureBuilder<VideoPlayerController?>(
        //   future: initializeVideoPlayer(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       // Display a loading indicator while the video is loading.
        //       return const CircularProgressIndicator();
        //     } else if (snapshot.hasError) {
        //       // Handle any errors that occurred during loading.
        //       return const Text('Error loading video');
        //     } else if (snapshot.hasData) {
        //       // Show the video player when it's ready.
        //       final controller = snapshot.data!;
        //       final chewieController = ChewieController(
        //         videoPlayerController: controller,
        //         aspectRatio: 16 / 9,
        //         autoInitialize: true,
        //         autoPlay: true,
        //         looping: false,
        //       );
        //       return Chewie(controller: chewieController);
        //     } else {
        //       return const Text('Unknown error');
        //     }
        //   },
        // ),
      ),
    );
  }
}


///





class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoPlayerScreen2(),
    );
  }
}

class VideoPlayerScreen2 extends StatefulWidget {
  @override
  _VideoPlayerScreen2State createState() => _VideoPlayerScreen2State();
}

class _VideoPlayerScreen2State extends State<VideoPlayerScreen2> {
  late VideoPlayerController _controller;
  late AudioPlayer _audioPlayer;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://grobiz.app/GrobizEcommerceSuperAdmin/images/Web/VN20230404_171559.mp4',
    )..initialize().then((_) {
      _controller.setLooping(true);
      setState(() {});
    });

    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _seek(Duration duration) {
    _controller.seekTo(duration);
  }

  void _previous() {
    // Implement your previous logic here
    // You can use _seek to jump to the previous video segment
  }

  void _forward() {
    // Implement your forward logic here
    // You can use _seek to jump to the next video segment
  }

  void _setVolume(double volume) {
    print("volume  $volume");
    _volume = volume;
    _audioPlayer.setVolume(volume);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player Controls'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              height: 600,
              width: 800,
              child: VideoPlayer(_controller),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: _playPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: _previous,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: _forward,
                ),
              ],
            ),
            Slider(
              value: _volume,
              onChanged: _setVolume,
              min: 0,
              max: 10,
              divisions: 10,
              label: 'Volume: $_volume',
            ),
            Slider(
              value: _controller.value.position.inSeconds.toDouble(),
              onChanged: (double value) {
                _seek(Duration(seconds: value.toInt()));
              },
              min: 0.0,
              max: _controller.value.duration.inSeconds.toDouble(),
              divisions: _controller.value.duration.inSeconds,
              label:
              '${_controller.value.position.inSeconds}/${_controller.value.duration.inSeconds}',
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
