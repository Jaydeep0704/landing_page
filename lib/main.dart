import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/getx_put_initializer.dart';
import 'package:grobiz_web_landing/config/local_storage.dart';
import 'package:grobiz_web_landing/page_route/route.dart';
import 'package:grobiz_web_landing/utils/shared_preference/shared_preference_services.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/pricing_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_web_landing_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/web_landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getXPutInitializer();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final pricingScreenController = Get.find<PricingScreenController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Grobiz AI App Builder',
      title: 'Grobiz',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: PageRoutes.initialRoute,
      routes: routesPage,
    );
  }

  // Future getPage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? isLogin = prefs.getBool('is_login');
  //   if (isLogin == true) {
  //     log("going to edit screen");
  //     Get.off(() => const EditWebLandingScreen());
  //   } else {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       Future.delayed(const Duration(seconds: 0), () {
  //         log("going to regular screen");
  //         Get.off(() => const WebLandingScreen());
  //       });
  //     });
  //   }
  // }

  // Future<Position> getUserLocation() async {
  //   log("getUserLocation ----- 1");
  //   LocationPermission permission;
  //   log("getUserLocation ----- 2");
  //
  //   // Check if location permission is granted
  //   permission = await Geolocator.checkPermission();
  //   log("getUserLocation ----- 3");
  //   if (permission == LocationPermission.always ||
  //       permission == LocationPermission.whileInUse) {
  //     Position position = await Geolocator.getCurrentPosition();
  //     setDataToLocalStorage(
  //         dataType: LocalStorage.stringType,
  //         prefKey: LocalStorage.lat,
  //         stringData: position.latitude.toString());
  //     setDataToLocalStorage(
  //         dataType: LocalStorage.stringType,
  //         prefKey: LocalStorage.long,
  //         stringData: position.longitude.toString());
  //     pricingScreenController.isLocation.value = true;
  //     log("is from permission always........ ${position.latitude.toString()}");
  //     pricingScreenController.getPlansData(
  //       lat: position.latitude.toString(),
  //       long: position.longitude.toString(),
  //     );
  //   } else if (permission == LocationPermission.denied) {
  //     pricingScreenController.isLocation.value = false;
  //     pricingScreenController.getPlansData(
  //         lat: "21.2378888", long: "72.863352");
  //     log("getUserLocation ----- 4");
  //     // Request location permission if not granted
  //     permission = await Geolocator.requestPermission();
  //     log("getUserLocation ----- 5");
  //
  //     if (permission == LocationPermission.denied) {
  //       log("getUserLocation ----- 6");
  //       pricingScreenController.isLocation.value = false;
  //       pricingScreenController.getPlansData(
  //           lat: "21.2378888", long: "72.863352");
  //       log("getUserLocation ----- 7");
  //       // Handle the scenario when the user denies the location permission
  //       return Future.error('Location permission denied');
  //     }
  //   } else if (permission == LocationPermission.unableToDetermine) {
  //     pricingScreenController.getPlansData(
  //         lat: "21.2378888", long: "72.863352");
  //     pricingScreenController.isLocation.value = false;
  //   }
  //   // Get the current position
  //   Position position = await Geolocator.getCurrentPosition();
  //   log("getUserLocation ----- 9");
  //   pricingScreenController.latitude.value = position.latitude.toString();
  //   log("getUserLocation ----- 10");
  //   pricingScreenController.longitude.value = position.longitude.toString();
  //   return position;
  // }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
      };
}
