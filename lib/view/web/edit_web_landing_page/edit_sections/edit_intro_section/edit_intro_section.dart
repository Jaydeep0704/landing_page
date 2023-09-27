// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/intro_section_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/update_media_component.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../web_landing_page/controller/landing_page_controller.dart';
import '../../../../../widget/edit_text_dialog.dart';

class EditIntroSection extends StatefulWidget {
  const EditIntroSection({Key? key}) : super(key: key);

  @override
  State<EditIntroSection> createState() => _EditIntroSectionState();
}

class _EditIntroSectionState extends State<EditIntroSection> {
  final introSecController = Get.find<IntroSectionController>();
  final webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final editIntroController = Get.find<EditIntroController>();

  @override
  void initState() {
    super.initState();

    log("editController.introDataList.isNotEmpty    ${editController
        .introDataList.isNotEmpty}");
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          // var data = editController.allDataResponse[0]["intro_details"][0];
          return editController.homeComponentList.isEmpty /*&&*/|| editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
            decoration: editController
                .allDataResponse[0]["intro_details"][0]["intro_bg_color_switch"]
                .toString() == "1" &&
                editController
                    .allDataResponse[0]["intro_details"][0]["intro_bg_image_switch"]
                    .toString() == "0"
                ? BoxDecoration(
              color: editController.allDataResponse[0]
              ["intro_details"][0]["intro_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(int.parse(
                  editController.introBgColor.value.toString()))
                  : Color(int.parse(editController.allDataResponse[0]
              ["intro_details"][0]["intro_bg_color"]
                  .toString())),
            )
                : BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(APIString.mediaBaseUrl +
                        editController.allDataResponse[0]["intro_details"]
                        [0]["intro_bg_image"]
                            .toString(),
                      errorListener: () => const Icon(Icons.error),),
                    fit: BoxFit.cover)
            ),
            width: Get.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: editController.introComp
                              .value,
                          onChanged: (value) {
                            setState(() {
                              editController.introComp.value = value;
                              log("value ---- $value");
                              editController.showHideComponent(
                                  value: value == false
                                      ? "No"
                                      : "Yes",
                                  componentName: "intro");
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
                                                  containerColor: Color(int.parse(
                                                      editController
                                                          .allDataResponse[0][
                                                      "intro_details"][0]["intro_bg_color"]
                                                          .toString())),
                                                  keyNameClr:
                                                  "intro_bg_color",
                                                  clrSwitchValue:
                                                  "1",
                                                  imgSwitchValue:
                                                  "0",
                                                  switchKeyNameImg:
                                                  "intro_bg_image_switch",
                                                  switchKeyNameClr:
                                                  "intro_bg_color_switch",
                                                ));
                                              },
                                              child: const Text("Color Picker")),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.dialog(ImgPickDialog(
                                                  keyNameImg:
                                                  "intro_bg_image",
                                                  switchKeyNameImg:
                                                  "intro_bg_image_switch",
                                                  switchKeyNameClr:
                                                  "intro_bg_color_switch",
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
                          child: Icon(Icons.colorize, color: editController
                              .allDataResponse[0]["intro_details"][0]["intro_bg_color"]
                              .toString() != "4294967295"
                              ? AppColors.whiteColor : AppColors.blackColor),),
                      ],
                    )),
                const SizedBox(height: 25),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            // height: 50,
                            // width: 50,
                            height: 60,
                            width: 60,
                            margin: const EdgeInsets.only(top: 15, right: 15),
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30))),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25)),
                                child: CachedNetworkImage(
                                  width: Get.width,
                                  imageUrl: APIString.mediaBaseUrl +
                                      editController
                                          .allDataResponse[0]["intro_details"][0]["Logo_image"]
                                          .toString(),
                                  placeholder: (context, url) =>
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Color(
                                                int.parse(editController
                                                    .appDemoBgColor.value
                                                    .toString())),
                                          )),
                                  // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -15, right: -15,
                            child: IconButton(onPressed: () {
                              Get.to(() =>
                                  ImgPickDialog(
                                    imageSize: "60*60",
                                    keyNameImg: "Logo_image",
                                    switchKeyNameImg: "",
                                    switchKeyNameClr: "",
                                  ));
                            }, icon: const Icon(Icons.edit)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.width > 1049 ? Get.height : null,
                  child: Column(
                    mainAxisAlignment: Get.width > 1049
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.start,

                    children: [
                      Get.width > 1049
                          ? const SizedBox()
                          : SizedBox(
                          height: Get.width > 1500
                              ? 75
                              : Get.width > 800
                              ? 60
                              : Get.width > 500
                              ? 50
                              : 40),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width > 1500
                                ? 60
                                : Get.width > 1000
                                ? 22
                                : Get.width > 600
                                ? 15
                                : 15),
                        child: Get.width > 1000
                            ? Row(
                          children: [
                            Expanded(
                              child:
                              InkWell(
                                onTap: titleOnTap,
                                child: Text(
                                  editController
                                      .allDataResponse[0]["intro_details"][0]["intro_main_title"]
                                      .toString(),
                                  style: GoogleFonts.getFont(editController
                                      .allDataResponse[0]["intro_details"][0]["intro_main_title_font"]
                                      .toString()).copyWith(
                                      fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString() !=""
                                          ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString())
                                          : Get.width > 1000
                                          ? 50
                                          : Get.width > 550
                                          ? 30
                                          : 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(int.parse(editController
                                          .allDataResponse[0]["intro_details"][0]["intro_main_title_color"]
                                          .toString()))),

                                  // style: GoogleFonts.getFont(selectedFont).copyWith(
                                  //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: 300,
                                  width: 300,
                                  decoration:
                                  editController
                                      .allDataResponse[0]["intro_details"][0]["intro_gif1"]
                                      .toString()
                                      .isEmpty
                                      ? const BoxDecoration()
                                      : const BoxDecoration(
                                    // color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Center(
                                    // child: Text("gif"),
                                      child: buildGif1Widget()
                                  ),
                                ),
                                Row(
                                  children: [
                                    Switch(
                                      value: editIntroController.introGif1Switch
                                          .value,
                                      onChanged: (value) {
                                        setState(() {
                                          editIntroController.introGif1Switch
                                              .value = value;
                                          log("value ---- $value");
                                          editController.showHideMedia(
                                              value: value == false
                                                  ? "hide"
                                                  : "show",
                                              keyName: "intro_gif1_show");
                                        });
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.dialog(
                                              UpdateMediaFunction(
                                                imageSize: "120*120",
                                            keyNameMedia: "intro_gif1",
                                            keyMediaType: "intro_gif1_mediatype",
                                          ));
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    SizedBox(
                                      // height: 50,
                                      // width: 50,
                                      height: 120,
                                      width: 120,
                                      // decoration: editController
                                      //     .allDataResponse[0]["intro_details"][0]["intro_bot_file"]
                                      //     .toString()
                                      //     .isEmpty
                                      //     ? const BoxDecoration()
                                      //     : const BoxDecoration(
                                      //   // color: Colors.yellow
                                      // ),
                                      child: Center(
                                        // child: Text("bot"),
                                        child: buildBotWidget(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          value: editIntroController
                                              .introBotSwitch.value,
                                          onChanged: (value) {
                                            setState(() {
                                              editIntroController.introBotSwitch
                                                  .value = value;
                                              log("value ---- $value");
                                              editController.showHideMedia(
                                                  value: value == false
                                                      ? "hide"
                                                      : "show",
                                                  keyName: "intro_bot_file_show");
                                            });
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(UpdateMediaFunction(
                                                keyNameMedia: "intro_bot_file",
                                                keyMediaType: "intro_bot_file_mediatype",
                                              ));
                                            },
                                            icon: const Icon(Icons.edit)),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    SizedBox(
                                      // height: 100,
                                      // width: 50,
                                      height: 160,
                                      width: 120,
                                      // decoration:
                                      // editController
                                      //     .allDataResponse[0]["intro_details"][0]["intro_gif2"]
                                      //     .toString()
                                      //     .isEmpty
                                      //     ? const BoxDecoration()
                                      //     : const BoxDecoration(
                                      //     color:
                                      //     Colors.red),
                                      child: Center(
                                        // child: Text("gif"),
                                        child: buildGif2Widget(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          value: editIntroController
                                              .introGif2Switch.value,
                                          onChanged: (value) {
                                            setState(() {
                                              editIntroController
                                                  .introGif2Switch.value =
                                                  value;
                                              log("value ---- $value");
                                              editController.showHideMedia(
                                                  value: value == false
                                                      ? "hide"
                                                      : "show",
                                                  keyName: "intro_gif2_show");
                                            });
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(UpdateMediaFunction(
                                                imageSize: "160*120",
                                                keyMediaType: "intro_gif2_mediatype",
                                              ));
                                            },
                                            icon: const Icon(Icons.edit)),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                            : Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            /*    Text(
                                            "Make Your Own Premium Ecommerce App & Website , AI easier way",
                                            style: TextStyle(
                                                // fontSize: 50,
                                                fontSize: Get.width > 1000---
                                                    ? 50
                                                    : 30,
                                                fontWeight:
                                                    FontWeight.bold,
                                                color: Colors.black),
                                          ),*/
                            InkWell(
                              onTap: titleOnTap,
                              child: Text(
                                editController
                                    .allDataResponse[0]["intro_details"][0]["intro_main_title"]
                                    .toString(),
                                style: GoogleFonts.getFont(editController
                                    .allDataResponse[0]["intro_details"][0]["intro_main_title_font"]
                                    .toString()).copyWith(
                                    fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString() !=""
                                        ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString())
                                        : Get.width > 1000
                                        ? 50
                                        : Get.width > 550
                                        ? 30
                                        : 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(int.parse(editController
                                        .allDataResponse[0]["intro_details"][0]["intro_main_title_color"]
                                        .toString()))),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(

                                      height: Get.width > 500 ? 300 : Get
                                          .width > 425 ? 250 : 175,
                                      width: Get.width > 500 ? 300 : Get.width >
                                          425 ? 250 : 175,
                                      decoration: editController
                                          .allDataResponse[0]["intro_details"][0]["intro_gif1"]
                                          .toString()
                                          .isEmpty
                                          ? const BoxDecoration()
                                          : const BoxDecoration(
                                        // color: Colors.blue,
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius
                                                  .circular(
                                                  5))),
                                      child: Center(
                                        // child: Text("gif"),
                                          child: buildGif1Widget()
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          value: editIntroController
                                              .introGif1Switch.value,
                                          onChanged: (value) {
                                            setState(() {
                                              editIntroController
                                                  .introGif1Switch.value =
                                                  value;
                                              log("value ---- $value");
                                              editController.showHideMedia(
                                                  value: value == false
                                                      ? "hide"
                                                      : "show",
                                                  keyName: "intro_gif1_show");
                                            });
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(UpdateMediaFunction(
                                                imageSize: "120*120",
                                                keyNameMedia: "intro_gif1",
                                                keyMediaType: "intro_gif1_mediatype",
                                              ));
                                            },
                                            icon: const Icon(Icons.edit)),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        SizedBox(
                                          // height: 50,
                                          // width: 50,
                                          height: Get.width > 500 ? 120 : Get
                                              .width > 425 ? 100 : 75,
                                          width: Get.width > 500 ? 120 : Get
                                              .width > 425 ? 100 : 75,
                                          // decoration: editController
                                          //     .allDataResponse[0]["intro_details"][0]["intro_bot_file"]
                                          //     .toString()
                                          //     .isEmpty
                                          //     ? const BoxDecoration()
                                          //     : const BoxDecoration(
                                          //   // color: Colors.yellow
                                          // ),
                                          child: Center(
                                            // child: Text("bot"),
                                            child: buildBotWidget(),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Switch(
                                              value: editIntroController
                                                  .introBotSwitch.value,
                                              onChanged: (value) {
                                                setState(() {
                                                  editIntroController
                                                      .introBotSwitch.value =
                                                      value;
                                                  log("value ---- $value");
                                                  editController.showHideMedia(
                                                      value: value == false
                                                          ? "hide"
                                                          : "show",
                                                      keyName: "intro_bot_file_show");
                                                });
                                              },
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Get.dialog(
                                                      UpdateMediaFunction(
                                                        keyNameMedia: "intro_bot_file",
                                                        keyMediaType: "intro_bot_file_mediatype",
                                                      ));
                                                },
                                                icon: const Icon(Icons.edit)),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 10),
                                    const SizedBox(
                                        height: 10),
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        SizedBox(
                                          // height: 100,
                                          // width: 50,
                                          height: Get.width > 500 ? 160 : Get
                                              .width > 425 ? 120 : 90,
                                          width: Get.width > 500 ? 120 : Get
                                              .width > 425 ? 100 : 75,
                                          // decoration:
                                          // editController
                                          //     .allDataResponse[0]["intro_details"][0]["intro_gif2"]
                                          //     .toString()
                                          //     .isEmpty
                                          //     ? const BoxDecoration()
                                          //     : const BoxDecoration(
                                          //     color: Colors.red),
                                          child: Center(
                                            // child: Text("gif"),
                                            child: buildGif2Widget(),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Switch(
                                              value: editIntroController
                                                  .introGif2Switch.value,
                                              onChanged: (value) {
                                                setState(() {
                                                  editIntroController
                                                      .introGif2Switch.value =
                                                      value;
                                                  log("value ---- $value");
                                                  editController.showHideMedia(
                                                      value: value == false
                                                          ? "hide"
                                                          : "show",
                                                      keyName: "intro_gif2_show");
                                                });
                                              },
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Get.dialog(
                                                      UpdateMediaFunction(
                                                        imageSize: "160*120",
                                                        keyNameMedia: "intro_gif2",
                                                        keyMediaType: "intro_gif2_mediatype",
                                                      ));
                                                },
                                                icon: const Icon(Icons.edit)),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Get.width > 1049
                          ? const SizedBox()
                          : SizedBox(
                          height: Get.width > 1500
                              ? 75
                              : Get.width > 800
                              ? 60
                              : Get.width > 500
                              ? 50
                              : 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(
                            width: Get.width > 1500
                                ? Get.width * 0.4
                                : Get.width > 1000
                                ? Get.width * 0.5
                                : Get.width * 0.6,
                            child: InkWell(
                              onTap: () =>
                                  Get.dialog(
                                      TextEditModule(
                                        textKeyName: "intro_desc",
                                        textValue: editController
                                            .allDataResponse[0]["intro_details"][0]["intro_desc"]
                                            .toString(),
                                        colorKeyName: "intro_desc_color",
                                        fontFamilyKeyName:
                                        "intro_desc_font",
                                        fontFamily: editController
                                            .allDataResponse[0]["intro_details"][0][
                                        "intro_desc_font"]
                                            .toString(),
                                        fontSize: editController
                                            .allDataResponse[0]["intro_details"][0][
                                        "intro_desc_size"]
                                            .toString(),
                                        textColor: Color(int.parse(
                                            editController
                                                .allDataResponse[0]["intro_details"][0]["intro_desc_color"]
                                                .toString())),
                                      )),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(2)),
                                        color: editController
                                            .allDataResponse[0]["intro_details"][0]["intro_desc_bg"] ==
                                            "hide"
                                            ? AppColors.transparentColor
                                            : Color(int.parse(editController
                                            .allDataResponse[0]["intro_details"][0]["intro_desc_bg_color"]
                                            .toString()),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
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
                                                              const SizedBox(
                                                                  height: 10),
                                                              Row(
                                                                children: [
                                                                  const Text("Turn On/Off Background"),
                                                                  const SizedBox(width: 25),
                                                                  Obx(() {
                                                                    return Switch(
                                                                      value: editIntroController
                                                                          .introDescBGSwitch
                                                                          .value,
                                                                      onChanged: (value) {
                                                                        setState(() {
                                                                          editIntroController
                                                                              .introDescBGSwitch
                                                                              .value =
                                                                              value;
                                                                          log(
                                                                              "value ---- $value");
                                                                          editController
                                                                              .showHideMedia(
                                                                              value: value ==
                                                                                  false
                                                                                  ? "hide"
                                                                                  : "show",
                                                                              keyName: "intro_desc_bg");
                                                                        });
                                                                      },
                                                                    );
                                                                  }),
                                                                ],
                                                              ),
                                                              ElevatedButton(
                                                                  onPressed: () {
                                                                    Get.dialog( ColorPickDialog(
                                                                      isTextBGColorEdit: true,
                                                                      containerColor:
                                                                      Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_desc_bg_color"].toString())),
                                                                      keyNameClr: "intro_desc_bg_color",
                                                                    ),);
                                                                  },
                                                                  child: const Text("Color Picker")),
                                                            ],
                                                          )),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Icon(Icons.colorize,
                                                  color: editController
                                                      .allDataResponse[0]["intro_details"][0]["intro_desc_bg_color"]
                                                      .toString() != "4294967295"
                                                      ? AppColors.whiteColor : AppColors
                                                      .blackColor),),
                                          ),
                                          Text(
                                            editController
                                              .allDataResponse[0]["intro_details"][0]["intro_desc"]
                                              .toString(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                                editController
                                                    .allDataResponse[0]["intro_details"][0]["intro_desc_font"]
                                                    .toString()).copyWith(

                                                fontSize: editController
                                                    .allDataResponse[0]["intro_details"][0]["intro_desc_size"]
                                                    .toString() == ""
                                                    ? double.parse(editController
                                                    .allDataResponse[0]["intro_details"][0]["intro_desc_size"]
                                                    .toString())
                                                    : 20,
                                                fontWeight: FontWeight.w400,
                                                color: Color(int.parse(
                                                    editController
                                                        .allDataResponse[0]["intro_details"][0]["intro_desc_color"]
                                                        .toString()))),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Get.width > 1049
                          ? const SizedBox()
                          : const SizedBox(height: 40),
                      Wrap(
                        crossAxisAlignment:
                        WrapCrossAlignment.start,
                        alignment: WrapAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              commonIconButton(
                                  onTap: appOpen,


                                  icon: Icons.phone_android,
                                  title: "Create Your App",
                                  btnColor: Colors.redAccent
                                      .withOpacity(0.7),
                                  txtColor: Colors.white),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(2)),
                                        color: editController
                                            .allDataResponse[0]["live_app_count_bg"] ==
                                            "hide"
                                            ? AppColors.transparentColor
                                            : Color(int.parse(editController
                                            .allDataResponse[0]["live_app_count_bg_color"]
                                            .toString()),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons
                                              .remove_red_eye_rounded),
                                          const SizedBox(width: 8),
                                          Row(
                                            children: [
                                              Obx(() =>
                                                  Text("${webLandingPageController
                                                      .appLiveCount.value} ",
                                                      style: GoogleFonts.getFont(
                                                          editController
                                                              .allDataResponse[0]["live_app_count_font"]
                                                              .toString()).copyWith(
                                                        // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                        //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                        //     : 14,
                                                        // fontWeight: FontWeight.w400,
                                                          color: Color(int.parse(
                                                              editController
                                                                  .allDataResponse[0]["live_app_count_color"]
                                                                  .toString()))))),
                                              // Obx(() => Text(" people creating App")),
                                              InkWell(
                                                onTap: () =>
                                                    Get.dialog(
                                                        TextEditModule(
                                                          textKeyName: "live_app_count_string",
                                                          textValue: editController
                                                              .allDataResponse[0]["live_app_count_string"]
                                                              .toString(),
                                                          colorKeyName: "live_app_count_color",
                                                          fontFamilyKeyName:
                                                          "live_app_count_font",
                                                          fontFamily: editController
                                                              .allDataResponse[0]["live_app_count_font"]
                                                              .toString(),
                                                          fontSize: editController
                                                              .allDataResponse[0]["live_app_count_size"]
                                                              .toString(),
                                                          textColor: Color(
                                                              int.parse(
                                                                  editController
                                                                      .allDataResponse[0]["live_app_count_color"]
                                                                      .toString())),
                                                        )),
                                                child: Text(
                                                  editController
                                                      .allDataResponse[0]["live_app_count_string"]
                                                      .toString(),
                                                  style: GoogleFonts.getFont(
                                                      editController
                                                          .allDataResponse[0]["live_app_count_font"]
                                                          .toString()).copyWith(
                                                    // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                    //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                    //     : 14,
                                                    // fontWeight: FontWeight.w400,
                                                      color: Color(int.parse(
                                                          editController
                                                              .allDataResponse[0]["live_app_count_color"]
                                                              .toString()))),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
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
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: [
                                                          const Text("Turn On/Off Background"),
                                                          const SizedBox(width: 25),
                                                          Obx(() {
                                                            return Switch(
                                                              value: editIntroController
                                                                  .appCountBGSwitch
                                                                  .value,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  editIntroController
                                                                      .appCountBGSwitch
                                                                      .value =
                                                                      value;
                                                                  log(
                                                                      "value ---- $value");
                                                                  editController
                                                                      .showHideMedia(
                                                                      value: value ==
                                                                          false
                                                                          ? "hide"
                                                                          : "show",
                                                                      keyName: "live_app_count_bg");
                                                                });
                                                              },
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Get.dialog( ColorPickDialog(
                                                              isTextBGColorEdit: true,
                                                              containerColor: Color(
                                                                  int.parse(editController.allDataResponse[0]["live_app_count_bg_color"].toString())),
                                                              keyNameClr: "live_app_count_bg_color",
                                                            ),);
                                                          },
                                                          child: const Text("Color Picker")),
                                                    ],
                                                  )),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(Icons.colorize,
                                          color: editController
                                              .allDataResponse[0]["live_app_count_bg_color"]
                                              .toString() != "4294967295"
                                              ? AppColors.whiteColor : AppColors
                                              .blackColor),),
                                  ),

                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              commonIconButton(
                                  onTap: websiteOpen,
                                  icon: Icons.language,
                                  title: "Create Your Website",
                                  btnColor: Colors.green
                                      .withOpacity(0.7),
                                  txtColor: Colors.white),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(2)),
                                        color: editController
                                            .allDataResponse[0]["live_web_count_bg"] ==
                                            "hide"
                                            ? AppColors.transparentColor
                                            : Color(int.parse(editController
                                            .allDataResponse[0]["live_web_count_bg_color"]
                                            .toString()),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons
                                              .remove_red_eye_rounded),
                                          const SizedBox(width: 8),
                                          Row(
                                            children: [
                                              Obx(() =>
                                                  Text("${webLandingPageController
                                                      .webLiveCount.value} ",
                                                    style: GoogleFonts.getFont(
                                                        editController
                                                            .allDataResponse[0]["live_web_count_font"]
                                                            .toString()).copyWith(
                                                      // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                                      //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                                      //     : 14,
                                                      // fontWeight: FontWeight.w400,
                                                        color: Color(
                                                            int.parse(editController
                                                                .allDataResponse[0]["live_web_count_color"]
                                                                .toString()))),)),
                                              InkWell(
                                                onTap: () =>
                                                    Get.dialog(
                                                        TextEditModule(
                                                          textKeyName: "live_web_count_string",
                                                          textValue: editController
                                                              .allDataResponse[0]["live_web_count_string"]
                                                              .toString(),
                                                          colorKeyName: "live_web_count_color",
                                                          fontFamilyKeyName:
                                                          "live_web_count_font",
                                                          fontFamily: editController
                                                              .allDataResponse[0]["live_web_count_font"]
                                                              .toString(),
                                                          fontSize: editController
                                                              .allDataResponse[0]["live_web_count_size"]
                                                              .toString(),
                                                          textColor: Color(
                                                              int.parse(
                                                                  editController
                                                                      .allDataResponse[0]["live_web_count_color"]
                                                                      .toString())),
                                                        )),
                                                child: Text(
                                                  editController
                                                      .allDataResponse[0]["live_web_count_string"]
                                                      .toString(),
                                                  style: GoogleFonts.getFont(
                                                      editController
                                                          .allDataResponse[0]["live_web_count_font"]
                                                          .toString()).copyWith(
                                                    // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                                    //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                                    //     : 14,
                                                    // fontWeight: FontWeight.w400,
                                                      color: Color(int.parse(
                                                          editController
                                                              .allDataResponse[0]["live_web_count_color"]
                                                              .toString()))),
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
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
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: [
                                                          const Text("Turn On/Off Background"),
                                                          const SizedBox(width: 25),
                                                          Obx(() {
                                                            return Switch(
                                                              value: editIntroController
                                                                  .webCountBGSwitch
                                                                  .value,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  editIntroController
                                                                      .webCountBGSwitch
                                                                      .value =
                                                                      value;
                                                                  log("value ---- $value");
                                                                  editController
                                                                      .showHideMedia(
                                                                      value: value ==
                                                                          false
                                                                          ? "hide"
                                                                          : "show",
                                                                      keyName: "live_web_count_bg");
                                                                });
                                                              },
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Get.dialog( ColorPickDialog(
                                                              isTextBGColorEdit: true,
                                                              containerColor: Color(
                                                                  int.parse(editController.allDataResponse[0]["live_web_count_bg_color"].toString())),
                                                              keyNameClr: "live_web_count_bg_color",
                                                            ),);
                                                          },
                                                          child: const Text("Color Picker")),
                                                    ],
                                                  )),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(Icons.colorize,
                                          color: editController
                                              .allDataResponse[0]["live_web_count_bg_color"]
                                              .toString() != "4294967295"
                                              ? AppColors.whiteColor : AppColors
                                              .blackColor),),
                                  ),
                                ],
                              ),
                            ],
                          ),


                        ],
                      ),

                      Get.width > 1049
                          ? const SizedBox()
                          : const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void titleOnTap() => Get.dialog(TextEditModule(
                                textKeyName: "intro_main_title",
                                colorKeyName: "intro_main_title_color",
                                fontFamilyKeyName: "intro_main_title_font",
                                textValue: editController
                                    .allDataResponse[0]["intro_details"][0]["intro_main_title"]
                                    .toString(),
                                fontFamily: editController
                                    .allDataResponse[0]["intro_details"][0]["intro_main_title_font"]
                                    .toString(),
                                fontSize: editController
                                    .allDataResponse[0]["intro_details"][0]["intro_main_title_size"]
                                    .toString(),
                                textColor: Color(int.parse(
                                    editController
                                        .allDataResponse[0]["intro_details"][0]["intro_main_title_color"]
                                        .toString())),
                              ));


}

Widget buildBotWidget() {
  if (Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_bot_file_mediatype"]
      .toString()
      .toLowerCase() == "image" || Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_bot_file_mediatype"]
      .toString()
      .toLowerCase() == "gif") {
    return CachedNetworkImage(
      width: Get.width,
      imageUrl: APIString.mediaBaseUrl + Get.find<EditController>()
          .allDataResponse[0]["intro_details"][0]["intro_bot_file"]
          .toString(),
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(decoration: BoxDecoration(
        color: Color(
            int.parse(Get.find<EditController>().appDemoBgColor.value.toString())),)),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
    );
  }
  else if (Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_bot_file_mediatype"]
      .toString()
      .toLowerCase() == "video") {
    return Obx(() {
      return Get.find<EditIntroController>().isBotVideoInitialized.value
          ? AspectRatio(
        aspectRatio: Get.find<EditIntroController>().introBotController.value.aspectRatio,
        child: VideoPlayer(Get.find<EditIntroController>().introBotController),
        // child:  Chewie(controller: editIntroController.introBotControllerChewie!),
      )
      // : const CircularProgressIndicator();
          : const Center(child: CircularProgressIndicator());
    });
  }

  else {
    return const Text("bot");
  }
}


Widget buildGif1Widget() {
  if (Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_gif1_mediatype"]
      .toString()
      .toLowerCase() == "image" || Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_gif1_mediatype"]
      .toString()
      .toLowerCase() == "gif") {
    return CachedNetworkImage(
      width: Get.width,
      imageUrl: APIString.mediaBaseUrl +
          Get.find<EditController>().allDataResponse[0]["intro_details"][0]["intro_gif1"]
              .toString(),
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(decoration: BoxDecoration(
        color: Color(
            int.parse(Get.find<EditController>().appDemoBgColor.value.toString())),)),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
    );
  }

  else if (Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_gif1_mediatype"]
      .toString()
      .toLowerCase() == "video") {
    return Obx(() {
      return
        Get.find<EditIntroController>().isIntroGif1Initialized.value
            ? AspectRatio(
          aspectRatio: Get.find<EditIntroController>().introGif1Controller.value
              .aspectRatio,
          child: VideoPlayer(Get.find<EditIntroController>().introGif1Controller),
        )
            : const Center(child: CircularProgressIndicator());
    });
  }

  else {
    return const Text("gif");
  }
}

Widget buildGif2Widget() {
  if (Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_gif2_mediatype"]
      .toString()
      .toLowerCase() == "image" || Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_gif2_mediatype"]
      .toString()
      .toLowerCase() == "gif") {
    return CachedNetworkImage(
      width: Get.width,
      imageUrl: APIString.mediaBaseUrl +
          Get.find<EditController>().allDataResponse[0]["intro_details"][0]["intro_gif2"]
              .toString(),
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(decoration: BoxDecoration(
        color: Color(
            int.parse(Get.find<EditController>().appDemoBgColor.value.toString())),)),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
    );
  }

  else if (Get.find<EditController>()
      .allDataResponse[0]["intro_details"][0]["intro_gif2_mediatype"]
      .toString()
      .toLowerCase() == "video") {
    return Obx(() {
      return
        Get.find<EditIntroController>().isIntroGif2Initialized.value
            ? AspectRatio(
          aspectRatio: Get.find<EditIntroController>().introGif2Controller.value
              .aspectRatio,
          child: VideoPlayer(Get.find<EditIntroController>().introGif2Controller),
        )
            : const Center(child: CircularProgressIndicator());
    });
  }

  else {
    return const Text("gif");
  }
}