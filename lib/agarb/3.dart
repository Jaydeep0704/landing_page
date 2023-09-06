import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayerController();
  }

  void _initializeVideoPlayerController() {
    _videoPlayerController = VideoPlayerController.network(
      'https://grobiz.app/GrobizEcommerceSuperAdmin/images/Web/VN20230404_171559.mp4',
    )..initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: 16 / 9, // You can adjust the aspect ratio
          autoPlay: true,
          looping: true, // Set to true if you want the video to loop
        );
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _toggleFullScreen() {
    if (_isFullScreen) {
      _chewieController.exitFullScreen();
    } else {
      _chewieController.enterFullScreen();
    }
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player with Chewie'),
      ),
      body: _chewieController != null && _chewieController.videoPlayerController.value.isInitialized
          ? Chewie(
        controller: _chewieController,
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFullScreen,
        child: Icon(_isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
      ),
    );
  }
}
