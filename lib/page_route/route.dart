import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/test/test_screen.dart';
import 'package:grobiz_web_landing/view/Splash_screen.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_web_landing_screen.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/login_page.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/web_landing_screen.dart';

class PageRoutes {
  static String initialRoute = "/";
  static String webLandingPage = "/webLandingPage";
  static String editWebLandingPage = "/editWebLandingPage";

  static const String login = "/login";
}

Map<String, Widget Function(BuildContext)> routesPage = {
  PageRoutes.initialRoute: (context) => const SplashScreen(),
  PageRoutes.webLandingPage: (context) => const WebLandingScreen(),
  PageRoutes.editWebLandingPage: (context) => const EditWebLandingScreen(),
  // PageRoutes.webLandingPage: (context) => const TestScreen(),
  // PageRoutes.editWebLandingPage: (context) => const TestScreen(),
  PageRoutes.login: (context) => const LoginPage(),
};
