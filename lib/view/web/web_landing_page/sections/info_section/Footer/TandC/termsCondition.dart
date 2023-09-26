// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';
import '../helpController.dart';

class TnCScreen extends StatefulWidget {
  const TnCScreen({super.key});

  @override
  State<TnCScreen> createState() => TnCScreenState();
}

class TnCScreenState extends State<TnCScreen> {
  TnCScreenState();

  final helpController = Get.find<HelpController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getData();
    KeyboardScroll.addScrollListener(_scrollController);
  }

  @override
  void dispose() {
    KeyboardScroll.removeScrollListener();
    _scrollController.dispose();
    super.dispose();
  }

  getData() {
    if (helpController.allTerms.isEmpty) {
      helpController.getTfcData();
    }
    if (helpController.allRefundPolicy.isEmpty) {
      helpController.getRefundpolicy();
    }
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
      body: SingleChildScrollView(
        controller: _scrollController,
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
                children: const [
                  Icon(Icons.circle, size: 15, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
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
              Obx(() {
                return helpController.allTerms.isEmpty
                    ? const SizedBox()
                    : Html(
                        // data: helpController.terms,
                        data: helpController.allTerms[0]["term"],
                      );
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.circle, size: 15, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
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
              // Container(
              //   child: Html(
              //     data: helpController.refund,
              //   ),
              // ),
              Obx(() {
                return helpController.allRefundPolicy.isEmpty
                    ? const SizedBox()
                    : Html(
                        // data: helpController.terms,
                        data: helpController.allRefundPolicy[0]
                            ["refund_policy"],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
