import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/getx_put_initializer.dart';
import 'package:grobiz_web_landing/page_route/route.dart';
import 'package:flutter/gestures.dart';

void main() {
  print("inserted inside void main ----- 1");
  WidgetsFlutterBinding.ensureInitialized();
  print("inserted inside void main ----- 2");
  HttpOverrides.global = MyHttpOverrides();
  print("inserted inside void main ----- 3");
  getXPutInitializer();
  print("inserted inside void main ----- 4");
  runApp(const MyApp());
  print("inserted inside void main ----- 5");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
