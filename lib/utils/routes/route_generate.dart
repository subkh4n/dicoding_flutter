import 'package:submis_f2/data/source/api/rest_client.dart';
import 'package:submis_f2/screen/detail/detail_screen.dart';
import 'package:submis_f2/screen/home/home_screen.dart';
import 'package:submis_f2/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerate {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments =
        settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/home":
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(
            milliseconds: 600,
          ),
          child: HomeScreen(
            client: arguments!["rest"] as RestClient,
          ),
        );
      case "/detail":
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            client: arguments!["rest"] as RestClient,
            id: arguments["id"] as String,
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
