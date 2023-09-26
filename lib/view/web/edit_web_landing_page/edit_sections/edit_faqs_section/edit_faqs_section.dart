import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs_section/edit_detail_faqs.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/faqs_section/detail_faqs.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';

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
          return editController.homeComponentList.isEmpty /*&&*/|| editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
                  width: Get.width,
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
                  child: Get.width > 800 ?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      contentColumn(context),
                      SizedBox(
                        child:  Image.asset("assets/faq_bg_image/faq_question_crop.png"),
                      ),
                    ],
                  ):Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      SizedBox(
                        child:  Image.asset("assets/faq_bg_image/faq_question_crop.png"),
                      ),
                      contentColumn(context),
                    ],
                  ),
                );
        });
      },
    );
  }

  Column contentColumn(BuildContext context) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Align(
                         alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Switch(
                                  value: editController.faqSection.value,
                                  onChanged: (value) {
                                    setState(() {
                                      editController.faqSection.value = value;
                                      log("value ---- $value");
                                      editController.showHideComponent(
                                          value: value == false
                                              ? "No"
                                              : "Yes",
                                          componentName: "faq_details");
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
                                                               containerColor: Color(
                                                                    int.parse(editController.allDataResponse[0]["faq_details"][0][
                                                                    "faq_bg_color"]
                                                                        .toString())),
                                                                keyNameClr:
                                                                "faq_bg_color",
                                                                clrSwitchValue: "1",
                                                                imgSwitchValue: "0",
                                                                switchKeyNameImg:
                                                                "faq_bg_image_switch",
                                                                switchKeyNameClr:
                                                                "faq_bg_color_switch",
                                                              ));
                                                        },
                                                        child: const Text(
                                                            "Color Picker")),
                                                    const SizedBox(height: 20),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Get.to(() => ImgPickDialog(
                                                            keyNameImg: "faq_bg_image",
                                                            switchKeyNameImg: "faq_bg_image_switch",
                                                            switchKeyNameClr: "faq_bg_color_switch",
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
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: ElevatedButton.icon(
                              onPressed: () async {
                                Get.to(() => const EditDetailFaqs())!.whenComplete(
                                        () => Future.delayed(Duration.zero, () {
                                      webLandingPageController.getUserCount();
                                    }));
                              },
                                icon: const Icon(Icons.edit, size: 15, color: Colors.black),
                                //icon data for elevated button
                                label: const Text(
                                  "Edit FAQs",
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                                //label text
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                              ),
                            ),

                          ],
                        )),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: () => Get.dialog(
                          TextEditModule(
                            textKeyName: "title",
                            colorKeyName: "title_color",
                            fontFamilyKeyName: "title_font",
                            textValue: editController.allDataResponse[0]["faq_details"][0]["title"].toString(),
                            fontFamily: editController.allDataResponse[0]["faq_details"][0]["title_font"].toString(),
                            fontSize: editController.allDataResponse[0]["faq_details"][0]["title_size"].toString(),
                            textColor: Color(int.parse(editController.allDataResponse[0]["faq_details"][0]["title_color"].toString())),
                          )),
                      child: Text(
                        editController.allDataResponse[0]["faq_details"][0]["title"]
                            .toString(),
                        style: GoogleFonts.getFont(editController.allDataResponse[0]["faq_details"][0]["title_font"].toString()).copyWith(
                            fontSize: editController.allDataResponse[0]["faq_details"][0]["title_size"] != null||
                                editController.allDataResponse[0]["faq_details"][0]["title_size"].toString() !=""
                                ? double.parse(editController.allDataResponse[0]["faq_details"][0]["title_size"].toString())
                                : 40,
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse(editController.allDataResponse[0]["faq_details"][0]["title_color"].toString()))),
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
                      child:  InkWell(
                        onTap: () => Get.dialog(
                            TextEditModule(
                              textKeyName: "subtitle",
                              colorKeyName: "subtitle_color",
                              fontFamilyKeyName: "subtitle_font",
                              textValue: editController.allDataResponse[0]["faq_details"][0]["subtitle"].toString(),
                              fontFamily: editController.allDataResponse[0]["faq_details"][0]["subtitle_font"].toString(),
                              fontSize: editController.allDataResponse[0]["faq_details"][0]["subtitle_size"].toString(),
                              textColor: Color(int.parse(editController.allDataResponse[0]["faq_details"][0]["subtitle_color"].toString())),
                            )),
                        child: Text(
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
                    ),
                    const SizedBox(height: 50),

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
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ElevatedButton.icon(
                        onPressed:  () => Get.dialog(
                            TextEditModule(
                              textEdit: true,
                              textKeyName: "btn_text",
                              textValue: editController.allDataResponse[0]["faq_details"][0]["btn_text"].toString(),
                            )),
                        icon: const Icon(Icons.edit, size: 15, color: Colors.black),
                        //icon data for elevated button
                        label: const Text(
                          "Edit Button Text",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        //label text
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 80),
                  ],
                );
  }
}
