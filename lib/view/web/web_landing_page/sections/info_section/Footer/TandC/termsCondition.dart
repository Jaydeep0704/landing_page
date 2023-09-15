import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

import '../AboutUs/AboutUsModel.dart';
import '../helpController.dart';
import 'TFCModel.dart';

class TnCScreen extends StatefulWidget {
  TnCScreen();

  @override
  State<TnCScreen> createState() => TnCScreenState();
}

class TnCScreenState extends State<TnCScreen> {
  TnCScreenState();
  final helpController = Get.find<HelpController>();

  @override
  void initState() {
    super.initState();

    helpController.getTfcData();
    helpController.getRefundpolicy();
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Terms and Condition",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Image.asset(
      //   'assets/favicon.png',
      // ),
      body: Container(
        child: FutureBuilder<bool>(
          future: helpController.getAboutUs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: const GFLoader(
                  type: GFLoaderType.circle,
                ),
              );
            } else {
              if (snapshot.hasError) {
                return const Text('Error occurred while fetching data.');
              } else {
                if (snapshot.data == true) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: Get.width > 1500
                          ? const EdgeInsets.only(left: 100, right: 100)
                          : Get.width > 1000
                              ? const EdgeInsets.only(left: 50, right: 50)
                              : Get.width > 500
                                  ? const EdgeInsets.only(left: 20, right: 20)
                                  : const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.circle,
                                  size: 15, color: Colors.black),
                              const SizedBox(width: 8),
                              const Text(
                                'TERM & CONDITION',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  //decoration: TextDecoration.underline
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Html(
                              data: helpController.terms,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.circle,
                                  size: 15, color: Colors.black),
                              const SizedBox(width: 8),
                              const Text(
                                'REFUND POLICY',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  //decoration: TextDecoration.underline
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Html(
                              data: helpController.refund,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text('Error occurred while fetching data.');
                }
              }
            }
          },
        ),
      ),
    );
  }
}
