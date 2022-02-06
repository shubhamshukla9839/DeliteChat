// ignore_for_file: file_names, unused_import, prefer_const_constructors, missing_return

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import './CameraPage.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key key, this.pickVideo}) : super(key: key);
  final File pickVideo;

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  VideoPlayerController vpc;

  void initState() {
    super.initState();
    vpc = VideoPlayerController.file(videopath)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    vpc.play();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: vpc.value.isInitialized
              ? AspectRatio(
                  aspectRatio: vpc.value.aspectRatio,
                  child: VideoPlayer(vpc),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              vpc.value.isPlaying ? vpc.pause() : vpc.play();
              if (vpc.value.position == vpc.value.duration) {
                hasvideo = 0;
                Navigator.pop(context);
              }
            });
          },
          child: Icon(
            vpc.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    vpc.dispose();
  }
}
