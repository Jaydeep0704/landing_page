import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://www.example.com/your-video-url.mp4',
    )..initialize().then((_) {
      setState(() {
        // Video is initialized and ready to be played.
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Center(
        child: VisibilityDetector(
          key: const Key('video-visibility-key'),
          onVisibilityChanged: (visibilityInfo) {
            setState(() {
              _isVisible = visibilityInfo.visibleFraction > 0.0;
              if (_isVisible) {
                _controller.play();
              } else {
                _controller.pause();
              }
            });
          },
          child: AspectRatio(
            aspectRatio: 16 / 9, // Adjust to your video's aspect ratio
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
