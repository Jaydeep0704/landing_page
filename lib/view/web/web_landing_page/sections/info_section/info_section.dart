import 'dart:developer';
import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/pricing_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_apps_demo_section/add_latest_project/add_Project_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/edit_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_checkout_section/edit_checkoutController.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_how_it_works_section/edit_hiw_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/login_page.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/faqs_section/detail_faqs.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/AboutUs/AboutScreen.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/ContactUs/ContactUsScreen.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/FAQ/FaqScreen.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/TandC/termsCondition.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/career/careers_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSection extends StatefulWidget {
  const InfoSection({Key? key}) : super(key: key);

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  final editController = Get.find<EditController>();
  final editInfoController = Get.find<EditInfoController>();
  final webLandingPageController = Get.find<WebLandingPageController>();

  ///
  final benefitBannerController = Get.find<BenefitBannerController>();
  final editCheckOutController = Get.find<EditCheckOutController>();
  final editIntroController = Get.find<EditIntroController>();
  final editHiwController = Get.find<EditHiwController>();
  final numberBannerController = Get.find<NumberBannerController>();
  final mixBannerController = Get.find<MixBannerController>();
  final pricingScreenController = Get.find<PricingScreenController>();
  final getLatestProject = Get.find<AddProjectController>();

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
          return editController.footerSection.value == false ||
                  editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
                  width: Get.width,
                  decoration: editController.allDataResponse[0]["info_details"]
                                      [0]["info_bg_color_switch"]
                                  .toString() ==
                              "1" &&
                          editController.allDataResponse[0]["info_details"][0]
                                      ["info_bg_image_switch"]
                                  .toString() ==
                              "0"
                      ? BoxDecoration(
                          color: editController.allDataResponse[0]
                                      ["info_details"][0]["info_bg_color"]
                                  .toString()
                                  .isEmpty
                              ? Color(int.parse(
                                  editController.introBgColor.value.toString()))
                              : Color(int.parse(editController
                                  .allDataResponse[0]["info_details"][0]
                                      ["info_bg_color"]
                                  .toString())),
                        )
                      : BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                APIString.mediaBaseUrl +
                                    editController.allDataResponse[0]
                                            ["info_details"][0]["info_bg_image"]
                                        .toString(),
                                errorListener: () => const Icon(Icons.error),
                              ),
                              fit: BoxFit.cover)),
                  child: Column(
                    children: [
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
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  // const facebookUrl = 'https://www.facebook.com';
                  // launch(facebookUrl);
                  html.window.open(AppString.fbLink, "_blank");
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.facebook,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
                  //const twitterUrl = 'https://twitter.com';
                  // launch(twitterUrl);
                  html.window.open(AppString.twitterLink, "_blank");
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/twitter.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                  // const youtubeUrl = 'https://www.youtube.com';
                  // launch(youtubeUrl);
                  html.window.open(AppString.ytLink, "_blank");
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/youthtube.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                  // const linkedinUrl = 'https://www.linkedin.com';
                  // launch(linkedinUrl);
                  html.window.open(AppString.linkedInLink, "_blank");
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/linedin.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                  // launchInstagram();
                  html.window.open(AppString.instaLink, "_blank");
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/instagram.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                style: TextStyle(
                    fontSize: 20,
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
                  Get.to(() => AboutUs())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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
                  Get.to(() => TnCScreen())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
                },
                child: const Text("T&C",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => PrivacyPolicy())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
                },
                child: const Text("Privacy",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  // Get.to(() => FaqScreen())!.whenComplete(() =>     Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                  Get.to(() => DetailFAQs())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
                },
                child: const Text("FAQs",
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
                  Get.to(() => const CareersScreen())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => Contactus())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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
                  Get.find<EditHiwController>().botController.pause();
                  Get.to(() => const LoginPage())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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

  ///info section - horizontal
  verticalInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "GroBiz ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 80,
                    child: Divider(
                      color: Colors.black.withOpacity(0.8),
                      // width: 10,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      // const facebookUrl = 'https://www.facebook.com';
                      // launch(facebookUrl);
                      html.window.open(AppString.fbLink, "_blank");
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.facebook,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // const twitterUrl = 'https://twitter.com';
                      // launch(twitterUrl);
                      html.window.open(AppString.twitterLink, "_blank");
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/twitter.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Twitter",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // const youtubeUrl = 'https://www.youtube.com';
                      // launch(youtubeUrl);
                      html.window.open(AppString.ytLink, "_blank");
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/youthtube.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "YouTube",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // const linkedinUrl = 'https://www.linkedin.com';
                      // launch(linkedinUrl);
                      html.window.open(AppString.linkedInLink, "_blank");
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/linedin.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Linkedin",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // launchInstagram();
                      html.window.open(AppString.instaLink, "_blank");
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/instagram.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Instagram",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.7,
          child: Divider(
            color: Colors.grey.withOpacity(0.8),
            // width: 10,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Company ",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 80,
                child: Divider(
                  color: Colors.black.withOpacity(0.8),
                  // width: 10,
                  thickness: 0.5,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              const SizedBox(height: 5),

              // Text(
              //   "Help",
              //   style: TextStyle(fontSize: 18, color: Colors.black),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => AboutUs())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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
                  Get.to(() => TnCScreen())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
                },
                child: const Text("T&C",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => PrivacyPolicy())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
                },
                child: const Text("Privacy",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  // Get.to(() => FaqScreen())!.whenComplete(() =>     Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                  Get.to(() => DetailFAQs())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
                },
                child: const Text("FAQs",
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
                  Get.to(() => const CareersScreen())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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
          width: Get.width * 0.7,
          child: Divider(
            color: Colors.grey.withOpacity(0.8),
            // width: 10,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Reach Us ",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 80,
                child: Divider(
                  color: Colors.black.withOpacity(0.8),
                  // width: 10,
                  thickness: 0.5,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Get.to(() => Contactus())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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
                  // Get.find<EditHiwController>().botController.pause();
                  // disposeAllController();
                  Get.to(() => const LoginPage())!
                      .whenComplete(() => Future.delayed(Duration.zero, () {
                            webLandingPageController.getUserCount();
                          }));
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
    const instagramAppUrl =
        'instagram://user?username=USERNAME'; // Replace 'USERNAME' with the desired Instagram username

    if (await canLaunch(instagramAppUrl)) {
      await launch(instagramAppUrl);
    } else {
      await launch(instagramUrl);
    }
  }

  disposeAllController() {
    if (editController.allDataResponse.isNotEmpty) {
      log("dispose called when list isNotEmpty");
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_bot_file_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editIntroController.introBotController.pause();
        editIntroController.introBotController.dispose();
        // editIntroController.introBotControllerChewie!.dispose();
      }
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif1_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editIntroController.introGif1Controller.pause();
        editIntroController.introGif1Controller.dispose();
      }
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif2_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editIntroController.introGif2Controller.pause();
        editIntroController.introGif2Controller.dispose();
      }
      //----------how it works
      if (editController.allDataResponse[0]["how_it_works_details"][0]
                  ["hiw_gif_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editHiwController.botController.pause();
        editHiwController.botController.dispose();
        editHiwController.botChewieController.dispose();
      }
      //----------mix banner
      if (editController.allDataResponse[0]["mix_banner_details"][0]
                  ["mix_banner_file_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        mixBannerController.videoController.pause();
        mixBannerController.videoController.dispose();
      }
      //----------NUMBER BANNER
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file1_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        numberBannerController.media1Controller.pause();
        numberBannerController.media1Controller.dispose();
      }
      //--------------
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file2_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        numberBannerController.media2Controller.pause();
        numberBannerController.media2Controller.dispose();
      }
      //--------------
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file3_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        numberBannerController.media3Controller.pause();
        numberBannerController.media3Controller.dispose();
      }
    }
  }
}
