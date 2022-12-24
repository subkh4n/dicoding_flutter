import 'package:submis_fl1/model/restaurant.dart';
import 'package:submis_fl1/screen/detail/detail_screen.dart';
import 'package:submis_fl1/screen/home/home_screen.dart';
import 'package:submis_fl1/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerate {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/home":
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(
            milliseconds: 600,
          ),
          child: const HomeScreen(),
        );
      case "/detail":
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            restaurant: settings.arguments as Restaurant,
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
