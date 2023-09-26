// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';
import 'dart:async';
import '../helpController.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => ContactusState();
}

class ContactusState extends State<Contactus> {
  ContactusState();

  final helpController = Get.find<HelpController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (helpController.contactUs.isEmpty) {
      helpController.getContactUs();
    }
    KeyboardScroll.addScrollListener(_scrollController);
  }

  @override
  void dispose() {
    KeyboardScroll.removeScrollListener();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: const Text("Contact Us",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            body: Row(
              children: <Widget>[
                Get.width > 501
                    ? const Expanded(child: SizedBox())
                    : const SizedBox(),
                Container(
                  padding: const EdgeInsets.only(
                      right: 25, left: 25, bottom: 25, top: 25),
                  width: Get.width > 800
                      ? 700
                      : Get.width > 501
                          ? 400
                          : Get.width,
                  // width: Get.width,
                  // padding: Get.width > 1500
                  //     ? const EdgeInsets.only(left: 300, right: 300)
                  //     : Get.width > 1000
                  //         ? const EdgeInsets.only(left: 200, right: 200)
                  //         : Get.width > 500
                  //             ? const EdgeInsets.only(left: 30, right: 30)
                  //             : const EdgeInsets.only(left: 20, right: 20),
                  child: Obx(() {
                    return helpController.contactUs.isEmpty
                        ? const SizedBox()
                        : SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 40, right: 40, bottom: 5),
                                  child: const Text(
                                      'You can reach our customer support team to address any of your queries or complaints related to product',
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45)),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //mb no
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.call,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Contact Number',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      helpController
                                              .contactUs[0]["contact_india"]
                                              .isNotEmpty
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Text('India:',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87)),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () => {
                                                    _makePhoneCall(
                                                        helpController
                                                                .contactUs[0]
                                                            ["contact_india"])
                                                  },
                                                  child: Text(
                                                      helpController
                                                              .contactUs[0]
                                                          ["contact_india"],
                                                      style: const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)),
                                                )
                                              ],
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      helpController.contactUs[0]["contact_us"]
                                              .isNotEmpty
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Text('US:',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87)),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () => {
                                                    _makePhoneCall(
                                                        helpController
                                                                .contactUs[0]
                                                            ["contact_us"])
                                                  },
                                                  child: Text(
                                                      helpController
                                                              .contactUs[0]
                                                          ["contact_us"],
                                                      style: const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)),
                                                )
                                              ],
                                            )
                                          : Container(),

                                      const Divider(
                                        thickness: 1,
                                        indent: 20,
                                        endIndent: 20,
                                        color: Colors.black12,
                                        height: 30,
                                      ),

                                      //email
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.email,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Email ID',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () => {
                                          // _sendMail(helpController.contact_email)
                                          _sendMail(helpController.contactUs[0]
                                              ["email"])
                                        },
                                        child: Text(
                                            helpController.contactUs[0]
                                                ["email"],
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline)),
                                      ),

                                      // SizedBox(height: 20,),
                                      const Divider(
                                        thickness: 1,
                                        // thickness of the line
                                        indent: 20,
                                        // empty space to the leading edge of divider.
                                        endIndent: 20,
                                        // empty space to the trailing edge of the divider.
                                        color: Colors.black12,
                                        // The color to use when painting the line.
                                        height:
                                            30, // The divider's height extent.
                                      ),

                                      //address
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Address',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          // helpController.contact_address,
                                          helpController.contactUs[0]
                                              ["address"],
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                // )
                              ],
                            ),
                          );
                  }),
                ),
                Get.width > 501
                    ? const Expanded(child: SizedBox())
                    : const SizedBox(),
              ],
            ));
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendMail(String mail_id) async {
    final mailtoUri = Uri(
      scheme: 'mailto',
      path: mail_id,
    );

    await launchUrl(mailtoUri);
  }
}
