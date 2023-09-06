import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

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
  late VideoPlayerController _controller;
  late AudioPlayer _audioPlayer;
  double _volume = 1.0;
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://grobiz.app/GrobizEcommerceSuperAdmin/images/Web/VN20230404_171559.mp4',
    )..initialize().then((_) {
      _controller.setLooping(true);
      _startSliderUpdate();
      _controller.play();
      setState(() {});
    });

    _audioPlayer = AudioPlayer();
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
bool playing = false;
  void _playPause() {
    if (_controller.value.isPlaying) {
      playing = false;
      _controller.pause();
    } else {
      playing = true;
      _controller.play();
    }
  }

  void _seek(double value) {
    final newPosition = Duration(seconds: value.toInt());
    _controller.seekTo(newPosition);
    setState(() {
      _sliderValue = value;
    });
  }

  void _startSliderUpdate() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted && _controller.value.isPlaying) {
        setState(() {
          _sliderValue = _controller.value.position.inSeconds.toDouble();
        });
      }
    });
  }



  void _setVolume(double volume) {
    _volume = volume;
    _audioPlayer.setVolume(volume);
    setState(() {}); // Trigger a rebuild to update the volume label
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player Controls'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // AspectRatio(
            //   aspectRatio: _controller.value.aspectRatio,
            //   child: VideoPlayer(_controller),
            // ),
            SizedBox(
              height: 600,
              width: 800,
              child: VideoPlayer(_controller),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: playing == true ?Icon(
                // _controller.value.isPlaying
                 Icons.pause
              ): Icon(
                Icons.play_arrow,
              ),
              onPressed: _playPause,
            ),
            Slider(
              value: _volume,
              onChanged: _setVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: 'Volume: $_volume',
            ),
            Slider(
              value: _sliderValue,
              onChanged: _seek,
              min: 0.0,
              max: _controller.value.duration.inSeconds.toDouble(),
              divisions: _controller.value.duration.inSeconds,
              label:
              // '${_sliderValue.toInt()}/${_controller.value.duration.inSeconds}',
              '${_formatDuration(Duration(seconds: _sliderValue.toInt()))}/${_formatDuration(_controller.value.duration)}',
            ),
          ],
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
