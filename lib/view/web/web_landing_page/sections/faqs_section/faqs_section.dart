import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/faqs_section/detail_faqs.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';

class FAQsSection extends StatefulWidget {
  const FAQsSection({super.key});

  @override
  State<FAQsSection> createState() => _FAQsSectionState();
}

class _FAQsSectionState extends State<FAQsSection> {
  WebLandingPageController webLandingPageController =
      Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.faqSection.value == false ||
                  editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
                  width: Get.width,
                  // decoration: const BoxDecoration(color: AppColors.blueColor),
                  decoration: editController.allDataResponse[0]
                                      ["faq_details"][0]
                                      ["faq_bg_color_switch"]
                                  .toString() ==
                              "1" &&
                          editController.allDataResponse[0]
                                      ["faq_details"][0]
                                      ["faq_bg_image_switch"]
                                  .toString() ==
                              "0"
                      ? BoxDecoration(
                          color: editController.allDataResponse[0]
                                      ["faq_details"][0]
                                      ["faq_bg_color"]
                                  .toString()
                                  .isEmpty
                              ? Color(int.parse(
                                  editController.introBgColor.value.toString()))
                              : Color(int.parse(editController
                                  .allDataResponse[0]["faq_details"][0]
                                      ["faq_bg_color"]
                                  .toString())),
                        )
                      : BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                APIString.mediaBaseUrl +
                                    editController.allDataResponse[0]
                                            ["faq_details"][0]
                                            ["faq_bg_image"]
                                        .toString(),
                                errorListener: () => const Icon(Icons.error),
                              ),
                              fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      // const Text(
                      //   "Got questions?",
                      //   style: TextStyle(
                      //       color: AppColors.whiteColor,
                      //       fontSize: 40,
                      //       fontWeight: FontWeight.bold),
                      // ),

                      Text(
                        editController.allDataResponse[0]["faq_details"][0]["title"]
                            .toString(),
                        style: GoogleFonts.getFont(editController.allDataResponse[0]["faq_details"][0]["title_font"].toString()).copyWith(
                            fontSize: editController.allDataResponse[0]["faq_details"][0]["title_size"] != null ||
                            editController.allDataResponse[0]["faq_details"][0]["title_size"].toString() !=""
                                ? double.parse(editController.allDataResponse[0]["faq_details"][0]["title_size"].toString())
                                : 40,
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse(editController.allDataResponse[0]["faq_details"][0]["title_color"].toString()))),
                        textAlign: TextAlign.center,

                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width > 1500
                                ? 70
                                : Get.width > 1000
                                    ? 50
                                    : 15),
                         child:  Text(
                    editController.allDataResponse[0]["faq_details"][0]["subtitle"]
                        .toString(),
                    style: GoogleFonts.getFont(editController.allDataResponse[0]["faq_details"][0]["subtitle_font"].toString()).copyWith(
                        fontSize: editController.allDataResponse[0]["faq_details"][0]["subtitle_size"] != null ||
                        editController.allDataResponse[0]["faq_details"][0]["subtitle_size"].toString() !=""
                            ? double.parse(editController.allDataResponse[0]["faq_details"][0]["subtitle_size"].toString())
                            : 25,
                        fontWeight: FontWeight.w400,
                        color: Color(int.parse(editController.allDataResponse[0]["faq_details"][0]["subtitle_color"].toString()))),
                    textAlign: TextAlign.center,

                  ),
                      ),
                      const SizedBox(height: 50),
                      // commonIconButton(
                      //     onTap: () async {
                      //       Get.to(() => const DetailFAQs())!.whenComplete(
                      //           () => Future.delayed(Duration.zero, () {
                      //                 webLandingPageController.getUserCount();
                      //               }));
                      //     },
                      //     hideIcon: true,
                      //     title: "Read FAQs",
                      //     btnColor: Colors.redAccent.withOpacity(0.7),
                      //     txtColor: Colors.white),
                       InkWell(
                         onTap: () async {
                           Get.to(() => const DetailFAQs())!.whenComplete(
                                   () => Future.delayed(Duration.zero, () {
                                 webLandingPageController.getUserCount();
                               }));
                         },
                         child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        editController.allDataResponse[0]["faq_details"][0]["btn_text"].toString(),
                                        style: AppTextStyle.regular500.copyWith(
                                            color: AppColors.whiteColor,
                                            fontSize: 20
                                        )
                                    ),
                                  ],
                                )),
                          ),
                      ),
                       ),
                      const SizedBox(height: 80),
                    ],
                  ),
                );
        });
      },
    );
  }
}
