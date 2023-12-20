import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:video_player/video_player.dart';

class TinTucVideo extends StatefulWidget {
  const TinTucVideo({super.key});

  @override
  State<TinTucVideo> createState() => _TinTucVideoState();
}

class _TinTucVideoState extends State<TinTucVideo> {
  late VideoPlayerController _controller;
  late bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/apptintuc-db349.appspot.com/o/video%2Fa.mp4?alt=media&token=b8970dfb-d527-4df0-ad2f-2c9f3bfa3623',
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

  Future<void> _uploadVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null) {
        var file = result.files.first;

        var storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('video/${DateTime.now().millisecondsSinceEpoch}.mp4');

        await storageRef.putData(file.bytes!);

        var downloadURL = await storageRef.getDownloadURL();

        // Now you can use the downloadURL to play the uploaded video
        print('Video uploaded. Download URL: $downloadURL');
      } else {
        // User canceled the file picker
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
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
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: ElevatedButton(
              onPressed: _uploadVideo,
              child: const Text('Upload Video'),
            ),
          ),
        ],
      ),
    );
  }
}
