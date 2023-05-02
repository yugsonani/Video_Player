import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
}

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController controller;
  late ChewieController c;

  loadVideo() async {
    controller = VideoPlayerController.asset(Global.url);
    await controller.initialize();
    setState(() {});
    c = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        allowFullScreen: true,
        fullScreenByDefault: true,
        looping: true);
  }

  @override
  void initState() {
    loadVideo();
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
    c.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(0 / 360),
          child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Chewie(controller: c)),
        ),
      ),
    );
  }
}
