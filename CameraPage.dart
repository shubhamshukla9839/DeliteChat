// ignore_for_file: file_names, unused_import, prefer_const_constructors, missing_return

import 'dart:io';
import 'package:first_app/pages/VideoPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import '../Screens/Homescreen.dart';

File videopath;
int hasvideo = 0;

class CameraPage extends StatefulWidget {
  const CameraPage({Key key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File _image;
  File _imageGallery;
  File _pickVideo;
  VideoPlayerController videoPlayerController;

  final imagePicker = ImagePicker();
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  //final imagePicker = ImagePicker();
  Future getImageFromGallery() async {
    final imageg = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageGallery = File(imageg.path);
    });
  }

  _pickVideoFromCamera() async {
    File video = await ImagePicker.pickVideo(
            source: ImageSource.camera, maxDuration: Duration(seconds: 20))
        .then((File recordedVideo) {
      if (recordedVideo != null && recordedVideo.path != null) {
        _pickVideo = recordedVideo;
        videopath = _pickVideo;
        // videoPath=recordedVideo.path;
        videoPlayerController = VideoPlayerController.file(recordedVideo)
          ..initialize().then((_) {
            setState(() {});
            videoPlayerController.play();
            videoPlayerController.setVolume(0.0);
          });
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 60),
            child: Center(
              child: _image == null
                  ? CircularProgressIndicator()
                  : Image.file(_image),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.flash_off,
                            color: Colors.white, size: 28),
                      ),
                      InkWell(
                        onTap: () {
                          getImage();
                        },
                        onLongPress: () {
                          hasvideo = 1;
                          _pickVideoFromCamera();
                        },
                        child: Icon(Icons.panorama_fish_eye,
                            color: Colors.white, size: 70),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.flip_camera_ios,
                            color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "   Hold for video , tap for photo ",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  hasvideo == 1
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VideoPage()),
                            );
                          },
                          icon: Icon(Icons.video_call,
                              color: Colors.white, size: 28),
                        )
                      : Text("No video")
                ],
              ),
            ),
          ),
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt),
      ),*/
    );
  }
}
