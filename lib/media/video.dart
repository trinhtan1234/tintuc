import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  late bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/tintuc-a0ba2.appspot.com/o/video%2Fa.mp4?alt=media&token=94e8e2d1-edda-4db6-8dfd-30c18c76b795',
    );
    _controller.setLooping(true);

    _controller.initialize().then((_) {
      setState(() {
        _isPlaying = true;
      });
    });

    _controller.addListener(() {
      if (!_controller.value.isPlaying) {
        setState(() {
          _isPlaying = false;
        });
      }
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (!_controller.value.isPlaying)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isPlaying = true;
                  _controller.play();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          if (_controller.value.isPlaying)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (_isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    _isPlaying = !_isPlaying;
                  });
                },
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.green,
                  size: 30.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
