import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/domain/firebase_functions/fn_profilepic/fn_profilepic.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/home/home.dart';
import 'package:video_player/video_player.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    splashtime(context);
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/splashgradient.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              height: _controller.value.size.height,
              width: _controller.value.size.width,
              child: VideoPlayer(_controller),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

splashtime(BuildContext context) async {
  getUserPhoto();
  await Future.delayed(const Duration(seconds: 2));

  logincheck(context);
}
