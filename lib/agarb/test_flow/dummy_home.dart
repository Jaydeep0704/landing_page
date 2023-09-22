import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/agarb/test_flow/controller.dart';

class DummyHomePage extends StatefulWidget {
  const DummyHomePage({super.key});

  @override
  State<DummyHomePage> createState() => _DummyHomePageState();
}

class _DummyHomePageState extends State<DummyHomePage> {
  final controllerFile = Get.find<ControllerFile>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerFile.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() => controllerFile.dataList.isEmpty
              ? SizedBox()
              : Text("${controllerFile.dataList}"))
        ],
      ),
    );
  }
}
