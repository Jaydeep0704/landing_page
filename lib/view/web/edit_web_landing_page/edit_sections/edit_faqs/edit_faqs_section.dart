import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs/edit_detail_faqs.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';

class EditFAQsSection extends StatefulWidget {
  const EditFAQsSection({super.key});

  @override
  State<EditFAQsSection> createState() => _EditFAQsSectionState();
}

class _EditFAQsSectionState extends State<EditFAQsSection> {
  WebLandingPageController webLandingPageController =
      Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.textBanner.value == false ||
                  editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
                  width: Get.width,
                  decoration: const BoxDecoration(color: AppColors.blueColor),
                  //    decoration: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_bg_color_switch"].toString() == "1" &&
                  //     editController.allDataResponse[0]["text_banner_details"][0]["text_banner_bg_image_switch"].toString() == "0"
                  //     ? BoxDecoration(
                  //   color: editController.allDataResponse[0]
                  //   ["text_banner_details"][0]["text_banner_bg_color"]
                  //       .toString()
                  //       .isEmpty
                  //       ? Color(int.parse(
                  //       editController.introBgColor.value.toString()))
                  //       : Color(int.parse(editController.allDataResponse[0]
                  //   ["text_banner_details"][0]["text_banner_bg_color"]
                  //       .toString())),
                  // )
                  //     : BoxDecoration(
                  //     image: DecorationImage(image: CachedNetworkImageProvider(
                  //       APIString.mediaBaseUrl +
                  //           editController.allDataResponse[0]["text_banner_details"]
                  //           [0]["text_banner_bg_image"]
                  //               .toString(),
                  //       errorListener: () => const Icon(Icons.error),),
                  //         fit: BoxFit.cover)
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      const Text(
                        "Got questions?",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),

                      // Text(
                      //   editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading"]
                      //       .toString(),
                      //   style: GoogleFonts.getFont(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_font"].toString()).copyWith(
                      //       fontSize: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_size"].toString() !=""
                      //           ? double.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_size"].toString())
                      //           : 40,
                      //       fontWeight: FontWeight.bold,
                      //       color: Color(int.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_color"].toString()))),
                      //   textAlign: TextAlign.center,
                      //
                      // ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width > 1500
                                ? 70
                                : Get.width > 1000
                                    ? 50
                                    : 15),
                        child: const Text(
                          "Head to our FAQ page for in-depth answers",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                        /* Text(
                    editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description"]
                        .toString(),
                    style: GoogleFonts.getFont(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_font"].toString()).copyWith(
                        fontSize: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_size"].toString() !=""
                            ? double.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_size"].toString())
                            : 25,
                        fontWeight: FontWeight.w400,
                        color: Color(int.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_color"].toString()))),
                    textAlign: TextAlign.center,

                  )*/
                        ,
                      ),
                      const SizedBox(height: 50),
                      commonIconButton(
                          onTap: () async {
                            Get.to(() => const EditDetailFaqs())!.whenComplete(
                                () => Future.delayed(Duration.zero, () {
                                      webLandingPageController.getUserCount();
                                    }));
                          },
                          hideIcon: true,
                          title: "Read FAQs",
                          btnColor: Colors.redAccent.withOpacity(0.7),
                          txtColor: Colors.white),
                      const SizedBox(height: 80),
                    ],
                  ),
                );
        });
      },
    );
  }
}
