// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../helpController.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final helpController = Get.find<HelpController>();

  @override
  void initState() {
    super.initState();
    if (helpController.aboutUs.isEmpty) {
      helpController.getAboutUs();
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text("About Us",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Container(
        padding: Get.width > 1500
            ? const EdgeInsets.only(left: 100, right: 300)
            : Get.width > 1000
                ? const EdgeInsets.only(left: 100, right: 150)
                : Get.width > 500
                    ? const EdgeInsets.only(left: 10, right: 10)
                    : const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return helpController.aboutUs.isEmpty
                    ? const SizedBox()
                    : Html(data: helpController.aboutUs[0]["about"]);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
