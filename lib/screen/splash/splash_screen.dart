import 'dart:async';

import 'package:submis_fl1/utils/resource/rescolor.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController imageAnimationController;
  late Animation<double> imageAnimation;

  @override
  void initState() {
    super.initState();
    setUpAnimation();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColor.green,
      body: Center(
        child: ScaleTransition(
          scale: imageAnimation,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/splash.gif",
              width: 200,
            ),
          ),
        ),
      ),
    );
  }

  void setUpAnimation() {
    imageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: 0.1,
    );

    imageAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: imageAnimationController,
    );

    imageAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    imageAnimationController.dispose();
  }
}
