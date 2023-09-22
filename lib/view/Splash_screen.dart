import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/page_route/route.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final editController = Get.find<EditController>();
  final webLandingPageController = Get.find<WebLandingPageController>();

  @override
  void initState() {
    super.initState();
    getPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
      ),
    );
  }

  getPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('is_login');
    if (isLogin == true) {
      // Get.off(()=>const EditWebLandingScreen());
      Get.offNamed(PageRoutes.editWebLandingPage);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 0), () {
          // Get.off(()=>const WebLandingScreen());
          Get.offNamed(PageRoutes.webLandingPage);
        });
      });
    }
  }
}
