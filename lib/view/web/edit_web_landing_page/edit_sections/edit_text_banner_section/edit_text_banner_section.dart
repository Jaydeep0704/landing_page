// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import '../../edit_controller/edit_controller.dart';


class EditTextBannerSection extends StatefulWidget {
  const EditTextBannerSection({Key? key}) : super(key: key);

  @override
  State<EditTextBannerSection> createState() => _EditTextBannerSectionState();
}

class _EditTextBannerSectionState extends State<EditTextBannerSection> {
  WebLandingPageController webLandingPageController = Get.find<
      WebLandingPageController>();
  final editController = Get.find<EditController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return  editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty
              ?const SizedBox()
              :Container(
            width: Get.width,
            decoration:
            // BoxDecoration(color: AppColors.bgGrey.withOpacity(0.5)),
            editController
                .allDataResponse[0]["text_banner_details"][0]["text_banner_bg_color_switch"]
                .toString() == "1" &&
                editController
                    .allDataResponse[0]["text_banner_details"][0]["text_banner_bg_image_switch"]
                    .toString() == "0"
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
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: editController.textBanner
                              .value,
                          onChanged: (value) {
                            setState(() {
                              editController.textBanner.value = value;
                              log("value ---- $value");
                              editController.showHideComponent(
                                  value: value == false
                                      ? "No"
                                      : "Yes",
                                  componentName: "text_banner");
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
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  onPressed: () => Get.back(),
                                                  icon: const Icon(
                                                    Icons.close,
                                                  )),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      ColorPickDialog(
                                                        // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                        // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                        containerColor: Color(
                                                            int.parse(editController.allDataResponse[0]["text_banner_details"][0][
                                                            "text_banner_bg_color"]
                                                                .toString())),
                                                        keyNameClr:
                                                        "text_banner_bg_color",
                                                        clrSwitchValue: "1",
                                                        imgSwitchValue: "0",
                                                        switchKeyNameImg:
                                                        "text_banner_bg_image_switch",
                                                        switchKeyNameClr:
                                                        "text_banner_bg_color_switch",
                                                      ));
                                                },
                                                child: const Text(
                                                    "Color Picker")),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.to(() => ImgPickDialog(
                                                    keyNameImg:
                                                    "text_banner_bg_image",
                                                    switchKeyNameImg:
                                                    "text_banner_bg_image_switch",
                                                    switchKeyNameClr:
                                                    "text_banner_bg_color_switch",
                                                  ));
                                                },
                                                child: const Text(
                                                    "Image Picker"))
                                          ],
                                        )),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.colorize)),
                      ],
                    )),
                  const SizedBox(height: 10,),
                // const Text(
                //   "Main Heading",
                //   style: TextStyle(
                //       fontSize: 40, fontWeight: FontWeight.bold),
                // ),
                InkWell(
                  onTap: () => Get.dialog(
                      TextEditModule(
                        textKeyName: "text_banner_heading",
                        colorKeyName: "text_banner_heading_color",
                        fontFamilyKeyName: "text_banner_heading_font",
                        textValue: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading"].toString(),
                        fontFamily: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_font"].toString(),
                        fontSize: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_size"].toString(),
                        textColor: Color(int.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_heading_color"].toString())),
                      )),
                  child: Text(
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
                ),

                const SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width > 1500
                          ? 70
                          : Get.width > 1000
                          ? 50
                          : 15),
                  child: /*const Text(
                    "Sub Heading  Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),*/

                  InkWell(
                    onTap: () => Get.dialog(
                        TextEditModule(
                          textKeyName: "text_banner_description",
                          colorKeyName: "text_banner_description_color",
                          fontFamilyKeyName: "text_banner_description_font",
                          textValue: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description"].toString(),
                          fontFamily: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_font"].toString(),
                          fontSize: editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_size"].toString(),
                          textColor: Color(int.parse(editController.allDataResponse[0]["text_banner_details"][0]["text_banner_description_color"].toString())),
                        )),
                    child: Text(
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
                        commonIconButton(
                            onTap: () async {
                              const url = AppString.playStoreAppLink;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },

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
                                  "${webLandingPageController.appLiveCount
                                      .value} people creating App")),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        commonIconButton(
                            onTap: () async {
                              const url = AppString.websiteLink;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
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
                                  "${webLandingPageController.webLiveCount
                                      .value} people creating Website")),
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

