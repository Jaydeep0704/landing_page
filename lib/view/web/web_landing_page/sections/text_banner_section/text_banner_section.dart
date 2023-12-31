// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';

class TextBannerSection extends StatefulWidget {
  const TextBannerSection({Key? key}) : super(key: key);

  @override
  State<TextBannerSection> createState() => _TextBannerSectionState();
}

class _TextBannerSectionState extends State<TextBannerSection> {
  WebLandingPageController webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.textBanner.value == false || editController.allDataResponse.isEmpty
              ?const SizedBox()
              :Container(
            // height: Get.width > 1500
            //     ? 600
            //     : Get.width > 900
            //     ? 600
            //     : 500,
            width: Get.width,
            decoration:
              // BoxDecoration(color: AppColors.bgGrey.withOpacity(0.5)),
              editController.allDataResponse[0]["text_banner_details"][0]["text_banner_bg_color_switch"].toString() == "1" &&
                  editController.allDataResponse[0]["text_banner_details"][0]["text_banner_bg_image_switch"].toString() == "0"
              ? BoxDecoration(
            color: editController.allDataResponse[0]
            ["text_banner_details"][0]["text_banner_bg_color"]
                .toString()
                .isEmpty
                ? Color(int.parse(
                editController.introBgColor.value.toString()))
                : Color(int.parse(editController.allDataResponse[0]
            ["text_banner_details"][0]["text_banner_bg_color"]
                .toString())),
          )
              : BoxDecoration(
              image: DecorationImage(image: CachedNetworkImageProvider(
                APIString.mediaBaseUrl +
                    editController.allDataResponse[0]["text_banner_details"]
                    [0]["text_banner_bg_image"]
                        .toString(),
                errorListener: () => const Icon(Icons.error),),
                  fit: BoxFit.cover)
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 80),
                Text(
                  editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading"]
                      .toString(),
                  style: GoogleFonts.getFont(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_font"].toString()).copyWith(
                      fontSize: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_size"].toString() !=""
                          ? double.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_size"].toString())
                          : 40,
                      fontWeight: FontWeight.bold,
                      color: Color(int.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_color"].toString()))),
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
                  child:
                  Text(
                    editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description"]
                        .toString(),
                    style: GoogleFonts.getFont(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_font"].toString()).copyWith(
                        fontSize: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_size"].toString() !=""
                            ? double.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_size"].toString())
                            : 25,
                        fontWeight: FontWeight.w400,
                        color: Color(int.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_color"].toString()))),
                    textAlign: TextAlign.center,

                  ),
                ),
                const SizedBox(height: 50),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Get.width > 400 ?   commonIconButton(
                            onTap: appOpen,
                            icon: Icons.phone_android,
                            title: "Create Your App",
                            btnColor:
                            Colors.redAccent.withOpacity(0.7),
                            txtColor: Colors.white)
                        :commonIconButtonMedium(
                            onTap: appOpen,
                            icon: Icons.phone_android,
                            title: "Create Your App",
                            btnColor:
                            Colors.redAccent.withOpacity(0.7),
                            txtColor: Colors.white),
                        SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.remove_red_eye_rounded),
                              const SizedBox(width: 8),
                              Obx(() =>
                              webLandingPageController.appLiveCount.value
                                  .isEmpty ? const SizedBox()
                                  : Text(
                                  "${webLandingPageController.appLiveCount.value} people creating App")),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Get.width > 400 ? commonIconButton(
                            onTap: websiteOpen,
                            icon: Icons.language,
                            title: "Create Your Website",
                            btnColor: Colors.green.withOpacity(0.7),
                            txtColor: Colors.white)
                        :commonIconButtonMedium(
                            onTap: websiteOpen,
                            icon: Icons.language,
                            title: "Create Your Website",
                            btnColor: Colors.green.withOpacity(0.7),
                            txtColor: Colors.white),
                        SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.remove_red_eye_rounded),
                              const SizedBox(width: 8),
                              Obx(() =>
                              webLandingPageController.webLiveCount.value
                                  .isEmpty ? const SizedBox()
                                  : Text(
                                  "${webLandingPageController.webLiveCount.value} people creating Website")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
