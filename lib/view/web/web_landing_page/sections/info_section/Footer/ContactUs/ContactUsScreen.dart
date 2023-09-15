import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

import '../helpController.dart';
import 'ContactUsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatefulWidget {
  Contactus();

  @override
  State<Contactus> createState() => ContactusState();
}

class ContactusState extends State<Contactus> {
  ContactusState();

  final helpController = Get.find<HelpController>();
  @override
  void initState() {
    super.initState();
    helpController.getContactUs();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Text("Contact Us",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  width: Get.width,
                  padding: Get.width > 1500
                      ? const EdgeInsets.only(left: 300, right: 300)
                      : Get.width > 1000
                          ? const EdgeInsets.only(left: 200, right: 200)
                          : Get.width > 500
                              ? const EdgeInsets.only(left: 30, right: 30)
                              : const EdgeInsets.only(left: 20, right: 20),
                  // color: Colors.white,
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
                          return Text('Error occurred while fetching data.');
                        } else {
                          if (snapshot.data == true) {
                            return Column(
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

                                SizedBox(
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
                                        children: [
                                          const Icon(
                                            Icons.call,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('Contact Number',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      helpController.contact_india.isNotEmpty
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('India:',
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () => {
                                                    _makePhoneCall(
                                                        helpController
                                                            .contact_india)
                                                  },
                                                  child: Text(
                                                      helpController
                                                          .contact_india,
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      helpController.contact_us.isNotEmpty
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('US:',
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () => {
                                                    _makePhoneCall(
                                                        helpController
                                                            .contact_us)
                                                  },
                                                  child: Text(
                                                      helpController.contact_us,
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

                                      //SizedBox(height: 20,),

                                      //email
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.email,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('Email ID',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () => {
                                          _sendMail(
                                              helpController.contact_email)
                                        },
                                        child: Text(
                                            helpController.contact_email,
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
                                        children: [
                                          const Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('Address',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(helpController.contact_address,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                // )
                              ],
                            );
                          } else {
                            return Text('Error occurred while fetching data.');
                          }
                        }
                      }
                    },
                  ),

                  // Column(
                  //   children: [
                  //
                  //     Container(
                  //       margin: const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 5),
                  //       child: const Text(
                  //           'You can reach our customer support team to address any of your queries or complaints related to product',
                  //           maxLines: 3,
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //               fontSize: 14.0,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.black45)),
                  //     ),
                  //
                  //
                  //     SizedBox(height: 20,),
                  //
                  //     Container(
                  //       alignment: Alignment.center,
                  //       margin: const EdgeInsets.all(5),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           //mb no
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Icon(Icons.call, color: Colors.black,size: 16,),
                  //               const SizedBox(width: 10,),
                  //               const Text('Contact Number', style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 16.0,
                  //                   color: Colors.black)),
                  //             ],
                  //           ),
                  //           SizedBox(height: 10,),
                  //           helpcontroller.contact_india.isNotEmpty?
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: <Widget>[
                  //               Text('India:', style: const TextStyle(
                  //                   fontSize: 16.0,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black87)),
                  //               SizedBox(width: 10,),
                  //               InkWell(
                  //                 onTap: ()=>{
                  //                   _makePhoneCall(helpcontroller.contact_india)
                  //                 },
                  //                 child: Text(helpcontroller.contact_india, style: const TextStyle(
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.blue,
                  //                     decoration: TextDecoration.underline)),
                  //               )
                  //             ],
                  //           ):
                  //           Container(),
                  //           SizedBox(height: 10,),
                  //           helpcontroller.contact_us.isNotEmpty?
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //
                  //             children: <Widget>[
                  //               Text('US:', style: const TextStyle(
                  //                   fontSize: 16.0,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black87)),
                  //               SizedBox(width: 10,),
                  //               InkWell(
                  //                 onTap: ()=>{
                  //                   _makePhoneCall(helpcontroller.contact_us)
                  //                 },
                  //                 child: Text(helpcontroller.contact_us, style: const TextStyle(
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.blue,
                  //                     decoration: TextDecoration.underline)),
                  //               )
                  //             ],
                  //           ):
                  //           Container(),
                  //
                  //           const Divider(
                  //             thickness: 1,
                  //             // thickness of the line
                  //             indent: 20,
                  //             // empty space to the leading edge of divider.
                  //             endIndent: 20,
                  //             // empty space to the trailing edge of the divider.
                  //             color: Colors.black12,
                  //             // The color to use when painting the line.
                  //             height: 30, // The divider's height extent.
                  //           ),
                  //
                  //           //SizedBox(height: 20,),
                  //
                  //           //email
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Icon(Icons.email, color: Colors.black,size: 16,),
                  //               const SizedBox(width: 10,),
                  //               const Text('Email ID', style: TextStyle(
                  //                   fontSize: 16.0,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black)),
                  //             ],
                  //           ),
                  //           SizedBox(height: 10,),
                  //           InkWell(
                  //             onTap: ()=>{
                  //               _sendMail(helpcontroller.contact_email)
                  //             },
                  //             child: Text(helpcontroller.contact_email, style: const TextStyle(
                  //                 fontSize: 16.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.blue,
                  //                 decoration: TextDecoration.underline)),
                  //           ),
                  //
                  //           // SizedBox(height: 20,),
                  //           const Divider(
                  //             thickness: 1,
                  //             // thickness of the line
                  //             indent: 20,
                  //             // empty space to the leading edge of divider.
                  //             endIndent: 20,
                  //             // empty space to the trailing edge of the divider.
                  //             color: Colors.black12,
                  //             // The color to use when painting the line.
                  //             height: 30, // The divider's height extent.
                  //           ),
                  //
                  //           //address
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Icon(Icons.location_on_rounded,color: Colors.black,size: 16,),
                  //               const SizedBox(width: 10,),
                  //               const Text('Address', style: TextStyle(
                  //                   fontSize: 16.0,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black)),
                  //             ],
                  //           ),
                  //           SizedBox(height: 10,),
                  //           Text(helpcontroller.contact_address,style: const TextStyle(
                  //               fontSize: 15.0,
                  //               color: Colors.black)
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     // )
                  //   ],
                  // ),
                ),

                const Expanded(child: SizedBox()),
                // helpcontroller.isApiCallProcessing==true?
                // Container(
                //   alignment: Alignment.center,
                //   width: MediaQuery.of(context).size.width,
                //   child: const GFLoader(
                //       type:GFLoaderType.circle
                //   ),
                // ):
                // Container()
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
