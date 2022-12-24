// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:submis_f2/data/source/api/rest_client.dart';
import 'package:submis_f2/utils/resource/rescolor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
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

    Timer(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacementNamed(context, "/home",
          arguments: {"rest": RestClient(Dio())});
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
              width: 300,
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
