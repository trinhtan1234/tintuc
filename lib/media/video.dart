import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TinTucVideo extends StatefulWidget {
  const TinTucVideo({Key? key}) : super(key: key);

  @override
  State<TinTucVideo> createState() => _TinTucVideoState();
}

class _TinTucVideoState extends State<TinTucVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    getVideoUrl();
  }

  Future<void> getVideoUrl() async {
    Reference videoRef = FirebaseStorage.instance.ref('video/a.mp4');
    final videoUrl = await videoRef.getDownloadURL();

    _controller = VideoPlayerController.networkUrl(videoUrl as Uri);
    _initializeVideoPlayerFuture = _controller.initialize();

    setState(() {
      _initializeVideoPlayerFuture = _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeVideoPlayerFuture != null) {
      return FutureBuilder<void>(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
