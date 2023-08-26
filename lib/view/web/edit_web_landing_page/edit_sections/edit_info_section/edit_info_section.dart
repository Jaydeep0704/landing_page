import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/view/web/Footer/AboutUs/AboutScreen.dart';
import 'package:grobiz_web_landing/view/web/career/careers_screen.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_logo_screen.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/login_page.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Footer/ContactUs/ContactUsScreen.dart';
import '../../../Footer/FAQ/FaqScreen.dart';
import '../../../Footer/PrivacyPolicy/PrivacyPolicy.dart';
import '../../../Footer/TandC/termsCondition.dart';


class EditInfoSection extends StatefulWidget {
  const EditInfoSection({Key? key}) : super(key: key);

  @override
  State<EditInfoSection> createState() => _EditInfoSectionState();
}

class _EditInfoSectionState extends State<EditInfoSection> {

  final editInfoController = Get.find<EditInfoController>();
  final editController = Get.find<EditController>();
  final webLandingPageController = Get.find<WebLandingPageController>();


  @override
  void initState() {
    super.initState();
    // editInfoController.getImages();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
               width: Get.width,
              decoration: editController
                .allDataResponse[0]["info_details"][0]["info_bg_color_switch"]
                .toString() == "1" &&
                editController
                    .allDataResponse[0]["info_details"][0]["info_bg_image_switch"]
                    .toString() == "0"
                ? BoxDecoration(
              color: editController
                  .allDataResponse[0]["info_details"][0]["info_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(int.parse(
                  editController.introBgColor.value.toString()))
                  : Color(int.parse(editController
                  .allDataResponse[0]["info_details"][0]["info_bg_color"]
                  .toString())),
            )
                : BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl + editController
                      .allDataResponse[0]["info_details"][0]["info_bg_image"]
                      .toString(),
                  errorListener: () => const Icon(Icons.error),),
                    fit: BoxFit.cover)
            ),
            // decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: editController.footerSection
                                  .value,
                              onChanged: (value) {
                                setState(() {
                                  editController.footerSection.value = value;
                                  print("value ---- $value");
                                  editController.showHideComponent(
                                      value: value == false
                                          ? "No"
                                          : "Yes",
                                      componentName: "footer_section");
                                });
                              },
                            ),
                            const SizedBox(width: 10,),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment:
                                                Alignment.topRight,
                                                child: IconButton(
                                                    onPressed: () =>
                                                        Get.back(),
                                                    icon: const Icon(
                                                        Icons.close)),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Get.dialog(ColorPickDialog(
                                                      // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                      // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                      containerColor: Color(
                                                          int.parse(editController
                                                              .allDataResponse[0][
                                                          "info_details"][0]["info_bg_color"]
                                                              .toString())),
                                                      keyNameClr: "info_bg_color",
                                                      clrSwitchValue: "1",
                                                      imgSwitchValue: "0",
                                                      switchKeyNameImg: "info_bg_image_switch",
                                                      switchKeyNameClr: "info_bg_color_switch",
                                                    ));
                                                  },
                                                  child: const Text(
                                                      "Color Picker")),
                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Get.dialog(ImgPickDialog(
                                                      keyNameImg:
                                                      "info_bg_image",
                                                      switchKeyNameImg:
                                                      "info_bg_image_switch",
                                                      switchKeyNameClr:
                                                      "info_bg_color_switch",
                                                    ));
                                                  },
                                                  child: const Text(
                                                      "Image Picker"))
                                            ],
                                          )),
                                    );
                                    // return ColorPickDialog(
                                    //   // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                    //   // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                    //   containerColor: Color(int.parse(
                                    //       editController
                                    //           .allDataResponse[0]
                                    //               ["intro_details"][0]
                                    //               ["intro_bg_color"]
                                    //           .toString())),
                                    //   keyNameClr: "intro_bg_color",
                                    //   clrSwitchValue: "1",
                                    //   imgSwitchValue: "0",
                                    //   switchKeyNameImg:
                                    //       "intro_bg_image_switch",
                                    //   switchKeyNameClr:
                                    //       "intro_bg_color_switch",
                                    // );
                                  },
                                );
                              },
                              child: Icon(Icons.colorize, color: editController
                                  .allDataResponse[0]["info_details"][0]["info_bg_color"]
                                  .toString() != "4294967295"
                                  ? AppColors.whiteColor : AppColors.blackColor),),
                          ],
                        ),
                        // SizedBox(height: 20),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.push(context, MaterialPageRoute(
                        //           builder: (context) => const EditInfoLogoScreen()))
                        //           .whenComplete(() {
                        //         editInfoController.getImages();
                        //       });
                        //     },
                        //     child: FittedBox(
                        //       fit: BoxFit.scaleDown,
                        //       child: Container(
                        //         padding: const EdgeInsets.all(5),
                        //         margin: const EdgeInsets.only(right: 10),
                        //         decoration: BoxDecoration(
                        //             color: AppColors.greyColor.withOpacity(0.5),
                        //             borderRadius:
                        //             const BorderRadius.all(Radius.circular(5))),
                        //         child: Row(
                        //           children: const [
                        //             Icon(Icons.edit),
                        //             SizedBox(width: 3),
                        //             Text("Edit Images")
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )),
                SizedBox(height: Get.width > 700 ? 80 : 30),
                Get.width > 700 ? horizontalInfo() : verticalInfo(),
                SizedBox(height: Get.width > 700 ? 80 : 30),
              ],
            ),
          );
        });
      },
    );
  }

  ///info section - vertical
    verticalInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const Text(
                "GroBiz ",
                style: TextStyle(fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  const facebookUrl = 'https://www.facebook.com';
                  launch(facebookUrl);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.facebook,
                      size: 18,

                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Facebook",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  const twitterUrl = 'https://twitter.com';
                  launch(twitterUrl);
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/twitter.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "Twitter",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  const youtubeUrl = 'https://www.youtube.com';
                  launch(youtubeUrl);
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/youthtube.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "YouTube",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  const linkedinUrl = 'https://www.linkedin.com';
                  launch(linkedinUrl);
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/linedin.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "Linkedin",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  launchInstagram();
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/instagram.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "Instagram",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
          // width: 10,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),
        // SizedBox(
        //   height: 250,
        //   child: VerticalDivider(
        //     color: Colors.grey.withOpacity(0.5),
        //     width: 10,
        //     thickness: 0.5,
        //     indent: 10,
        //     endIndent: 10,
        //   ),
        // ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const Text(
                "Company ",
                style: TextStyle(fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 10),

              // Text(
              //   "Help",
              //   style: TextStyle(fontSize: 18, color: Colors.black),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => AboutUs())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text(
                  "About Us",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => TFCscreen())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text("T&C",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => PrivacyPolicy())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text("Privacy",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => FaqScreen())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text("Faq",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              // InkWell(
              //   onTap: (){
              //     Get.to(() => RefundPolicy());
              //   },
              //   child: Text("Refund Policy",
              //       style: TextStyle(fontSize: 18, color: Colors.black),
              //       textAlign: TextAlign.center),
              // ),
              // SizedBox(height: 10),
              // Text(
              //   "Pricing",
              //   style: TextStyle(fontSize: 18, color: Colors.black),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(height: 10),

              InkWell(
                onTap: () {
                  Get.to(()=>const CareersScreen())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text(
                  "Career",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              // const SizedBox(height: 8),
              // Text(
              //   StaticString.loremIpsum,
              //   maxLines: 10,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(fontSize: 14, color: Colors.black),
              // )
            ],
          ),
        ),


        // SizedBox(
        //   height: 250,
        //   child: VerticalDivider(
        //     color: Colors.grey.withOpacity(0.5),
        //     width: 10,
        //     thickness: 0.5,
        //     indent: 10,
        //     endIndent: 10,
        //   ),
        // ),

        Divider(
          color: Colors.grey.withOpacity(0.5),
          // width: 10,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Reach Us ",
                style: TextStyle(fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => Contactus())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  // Get.to(() => const LoginPage());
                },
                child: const Text(
                  "Admin Login",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //
    //           const Text(
    //             "GroBiz ",
    //             style: TextStyle(fontSize: 20,
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.bold),
    //             textAlign: TextAlign.center,
    //           ),
    //           const SizedBox(height: 10),
    //
    //           InkWell(
    //             onTap: () {
    //               const facebookUrl = 'https://www.facebook.com';
    //               launch(facebookUrl);
    //             },
    //             child: Row(
    //               children: const [
    //                 Icon(
    //                   Icons.facebook,
    //                   size: 18,
    //
    //                 ),
    //                 SizedBox(width: 10,),
    //                 Text(
    //                   "Facebook",
    //                   style: TextStyle(fontSize: 18, color: Colors.black),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ],
    //             ),
    //           ),
    //
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               const twitterUrl = 'https://twitter.com';
    //               launch(twitterUrl);
    //             },
    //             child: Row(
    //               children: [
    //                 Image.asset(
    //                   'assets/twitter.png',
    //                   width: 18,
    //                   height: 18,
    //                 ),
    //                 const SizedBox(width: 10,),
    //                 const Text(
    //                   "Twitter",
    //                   style: TextStyle(fontSize: 18, color: Colors.black),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ],
    //             ),
    //           ),
    //
    //
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               const youtubeUrl = 'https://www.youtube.com';
    //               launch(youtubeUrl);
    //             },
    //             child: Row(
    //               children: [
    //                 Image.asset(
    //                   'assets/youthtube.png',
    //                   width: 18,
    //                   height: 18,
    //                 ),
    //                 const SizedBox(width: 10,),
    //                 const Text(
    //                   "YouTube",
    //                   style: TextStyle(fontSize: 18, color: Colors.black),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               const linkedinUrl = 'https://www.linkedin.com';
    //               launch(linkedinUrl);
    //             },
    //             child: Row(
    //               children: [
    //                 Image.asset(
    //                   'assets/linedin.png',
    //                   width: 18,
    //                   height: 18,
    //                 ),
    //                 const SizedBox(width: 10,),
    //                 const Text(
    //                   "Linkedin",
    //                   style: TextStyle(fontSize: 18, color: Colors.black),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               launchInstagram();
    //             },
    //             child: Row(
    //               children: [
    //                 Image.asset(
    //                   'assets/instagram.png',
    //                   width: 18,
    //                   height: 18,
    //                 ),
    //                 const SizedBox(width: 10,),
    //                 const Text(
    //                   "Instagram",
    //                   style: TextStyle(fontSize: 18, color: Colors.black),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ],
    //             ),
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //
    //     SizedBox(
    //       height: 250,
    //       child: VerticalDivider(
    //         color: Colors.grey.withOpacity(0.5),
    //         width: 10,
    //         thickness: 0.5,
    //         indent: 10,
    //         endIndent: 10,
    //       ),
    //     ),
    //
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //
    //           const Text(
    //             "Company ",
    //             style: TextStyle(fontSize: 20,
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.bold),
    //             textAlign: TextAlign.center,
    //
    //           ),
    //           const SizedBox(height: 10),
    //
    //           // Text(
    //           //   "Help",
    //           //   style: TextStyle(fontSize: 18, color: Colors.black),
    //           //   textAlign: TextAlign.center,
    //           // ),
    //           // SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               Get.to(() => AboutUs());
    //             },
    //             child: const Text(
    //               "About Us",
    //               style: TextStyle(fontSize: 18, color: Colors.black),
    //               textAlign: TextAlign.center,
    //             ),
    //           ),
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               Get.to(() => TFCscreen());
    //             },
    //             child: const Text("T&C",
    //                 style: TextStyle(fontSize: 18, color: Colors.black),
    //                 textAlign: TextAlign.center),
    //           ),
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               Get.to(() => PrivacyPolicy());
    //             },
    //             child: const Text("Privacy",
    //                 style: TextStyle(fontSize: 18, color: Colors.black),
    //                 textAlign: TextAlign.center),
    //           ),
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               Get.to(() => FaqScreen());
    //             },
    //             child: const Text("Faq",
    //                 style: TextStyle(fontSize: 18, color: Colors.black),
    //                 textAlign: TextAlign.center),
    //           ),
    //           const SizedBox(height: 10),
    //           // InkWell(
    //           //   onTap: (){
    //           //     Get.to(() => RefundPolicy());
    //           //   },
    //           //   child: Text("Refund Policy",
    //           //       style: TextStyle(fontSize: 18, color: Colors.black),
    //           //       textAlign: TextAlign.center),
    //           // ),
    //           // SizedBox(height: 10),
    //           // Text(
    //           //   "Pricing",
    //           //   style: TextStyle(fontSize: 18, color: Colors.black),
    //           //   textAlign: TextAlign.center,
    //           // ),
    //           // SizedBox(height: 10),
    //
    //           InkWell(
    //             onTap: () {
    //               Get.to(()=>const CareersScreen());
    //             },
    //             child: const Text(
    //               "Career",
    //               style: TextStyle(fontSize: 18, color: Colors.black),
    //               textAlign: TextAlign.center,
    //             ),
    //           ),
    //           // const SizedBox(height: 8),
    //           // Text(
    //           //   StaticString.loremIpsum,
    //           //   maxLines: 10,
    //           //   overflow: TextOverflow.ellipsis,
    //           //   style: const TextStyle(fontSize: 14, color: Colors.black),
    //           // )
    //         ],
    //       ),
    //     ),
    //
    //
    //     SizedBox(
    //       height: 250,
    //       child: VerticalDivider(
    //         color: Colors.grey.withOpacity(0.5),
    //         width: 10,
    //         thickness: 0.5,
    //         indent: 10,
    //         endIndent: 10,
    //       ),
    //     ),
    //
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           const Text(
    //             "Reach Us ",
    //             style: TextStyle(fontSize: 20,
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.bold),
    //             textAlign: TextAlign.center,
    //
    //           ),
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               Get.to(() => Contactus());
    //             },
    //             child: const Text(
    //               "Contact Us",
    //               style: TextStyle(fontSize: 18, color: Colors.black),
    //               textAlign: TextAlign.center,
    //             ),
    //           ),
    //
    //           const SizedBox(height: 10),
    //           InkWell(
    //             onTap: () {
    //               Get.to(() => const LoginPage());
    //             },
    //             child: const Text(
    //               "Admin Login",
    //               style: TextStyle(fontSize: 18, color: Colors.black),
    //               textAlign: TextAlign.center,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }

  ///info section - horizontal
  horizontalInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const Text(
                "GroBiz ",
                style: TextStyle(fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  const facebookUrl = 'https://www.facebook.com';
                  launch(facebookUrl);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.facebook,
                      size: 18,

                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Facebook",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  const twitterUrl = 'https://twitter.com';
                  launch(twitterUrl);
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/twitter.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "Twitter",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  const youtubeUrl = 'https://www.youtube.com';
                  launch(youtubeUrl);
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/youthtube.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "YouTube",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  const linkedinUrl = 'https://www.linkedin.com';
                  launch(linkedinUrl);
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/linedin.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "Linkedin",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  launchInstagram();
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/instagram.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 10,),
                    const Text(
                      "Instagram",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 8),
              // Text(
              //   StaticString.loremIpsum,
              //   maxLines: 10,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(fontSize: 14, color: Colors.black),
              // )
            ],
          ),
        ),

        SizedBox(
          height: 250,
          child: VerticalDivider(
            color: Colors.grey.withOpacity(0.5),
            width: 10,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const Text(
                "Company ",
                style: TextStyle(fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 10),

              // Text(
              //   "Help",
              //   style: TextStyle(fontSize: 18, color: Colors.black),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => AboutUs())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text(
                  "About Us",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => TFCscreen())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text("T&C",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => PrivacyPolicy())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text("Privacy",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => FaqScreen())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text("Faq",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              // InkWell(
              //   onTap: (){
              //     Get.to(() => RefundPolicy());
              //   },
              //   child: Text("Refund Policy",
              //       style: TextStyle(fontSize: 18, color: Colors.black),
              //       textAlign: TextAlign.center),
              // ),
              // SizedBox(height: 10),
              // Text(
              //   "Pricing",
              //   style: TextStyle(fontSize: 18, color: Colors.black),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(()=>const CareersScreen())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text(
                  "Career",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              // const SizedBox(height: 8),
              // Text(
              //   StaticString.loremIpsum,
              //   maxLines: 10,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(fontSize: 14, color: Colors.black),
              // )
            ],
          ),
        ),


        SizedBox(
          height: 250,
          child: VerticalDivider(
            color: Colors.grey.withOpacity(0.5),
            width: 10,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Reach Us ",
                style: TextStyle(fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => Contactus())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  // Get.to(() => const LoginPage())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                },
                child: const Text(
                  "Admin Login",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  launchInstagram() async {
    const instagramUrl = 'https://www.instagram.com';
    const instagramAppUrl = 'instagram://user?username=USERNAME'; // Replace 'USERNAME' with the desired Instagram username

    if (await canLaunch(instagramAppUrl)) {
      await launch(instagramAppUrl);
    } else {
      await launch(instagramUrl);
    }
  }

}
