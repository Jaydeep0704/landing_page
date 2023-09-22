import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:video_player/video_player.dart';

import '../../../../../config/api_string.dart';
import '../../../web_landing_page/controller/landing_page_controller.dart';
import '../../../web_landing_page/sections/checkout_info_section/CheckOutInfoControllers.dart';
import '../../../web_landing_page/sections/checkout_info_section/CheckOutListScreen.dart';
import '../../edit_controller/edit_controller.dart';


class EditCheckoutInfoSection extends StatefulWidget {
  const EditCheckoutInfoSection({Key? key}) : super(key: key);

  @override
  State<EditCheckoutInfoSection> createState() =>
      _EditCheckoutInfoSectionState();
}

class _EditCheckoutInfoSectionState extends State<EditCheckoutInfoSection> {
  final checkoutInfoController = Get.find<CheckOutInfoController>();
  final landingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  int _currentIndex = 0;
  bool isScrolling = true;



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty &&  editController.allDataResponse.isEmpty
              ?const SizedBox()
              :Container(
                // height: 700,
               padding: EdgeInsets.only(
                left: Get.width > 650 ? Get.width * 0.1 : Get.width * 0.05,
                right: Get.width > 650 ? Get.width * 0.1 : Get.width * 0.05),
            decoration: editController
                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_color_switch"]
                .toString() == "1" &&
                editController
                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_image_switch"]
                    .toString() == "0"
                ? BoxDecoration(
              color: editController
                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(int.parse(
                  editController.introBgColor.value.toString()))
                  : Color(int.parse(editController
                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_color"]
                  .toString())),
            )
                : BoxDecoration(
                   image: DecorationImage(
                     image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl +
                      editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_image"]
                          .toString(),
                  errorListener: () => const Icon(Icons.error),),
                    fit: BoxFit.cover)
            ), width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: editController.checkoutInfo
                              .value,
                          onChanged: (value) {
                            setState(() {
                              editController.checkoutInfo.value = value;
                              print("value ---- $value");
                              editController.showHideComponent(
                                  value: value == false
                                      ? "No"
                                      : "Yes",
                                  componentName: "checkout_info");
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
                                                      Icons.close)),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      ColorPickDialog(
                                                        // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                        // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                        containerColor: Color(
                                                            int.parse(editController
                                                                .allDataResponse[0]["checkout_info_details"][0][
                                                            "checkout_info_bg_color"]
                                                                .toString())),
                                                        keyNameClr:
                                                        "checkout_info_bg_color",
                                                        clrSwitchValue: "1",
                                                        imgSwitchValue: "0",
                                                        switchKeyNameImg:
                                                        "checkout_info_bg_image_switch",
                                                        switchKeyNameClr:
                                                        "checkout_info_bg_color_switch",
                                                      ));
                                                },
                                                child: const Text(
                                                    "Color Picker")),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      ImgPickDialog(
                                                        keyNameImg:
                                                        "checkout_info_bg_image",
                                                        switchKeyNameImg:
                                                        "checkout_info_bg_image_switch",
                                                        switchKeyNameClr:
                                                        "checkout_info_bg_color_switch",
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

                const SizedBox(height: 80),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      left: Get.width * 0.1, right: Get.width * 0.1),
                  // child: Text(
                  //   "Build your one-of-a-kind checkout with advanced customizations",
                  //   textAlign: TextAlign.center,
                  //   style: AppTextStyle.regular800.copyWith(fontSize: 32),
                  // ),
                  child: InkWell(
                    onTap: () =>
                        Get.dialog(
                            TextEditModule(
                              textKeyName: "checkout_info_title1",
                              colorKeyName: "checkout_info_title1_color",
                              fontFamilyKeyName: "checkout_info_title1_font",
                              textValue: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1"]
                                  .toString(),
                              fontFamily: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_font"]
                                  .toString(),
                              fontSize: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_size"]
                                  .toString(),
                              textColor: Color(int.parse(editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_color"]
                                  .toString())),
                            )),
                    child: Text(
                      editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1"]
                          .toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_font"]
                          .toString()).copyWith(
                          fontSize: editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_size"]
                              .toString() != ""
                              ? double.parse(editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_size"]
                              .toString())
                              : 32,
                          fontWeight: FontWeight.w800,
                          color: Color(int.parse(editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_color"]
                              .toString()))),

                      // style: GoogleFonts.getFont(selectedFont).copyWith(
                      //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                    ),
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: Get.width * 0.1,

                            top: 16,
                            bottom: 16),
                        // child: Text(
                        //   "Customize your checkout—and Shop Pay—with powerful apps and branding tools, without sacrificing security or performance.",
                        //   textAlign: TextAlign.center,
                        //   style: AppTextStyle.regular400.copyWith(fontSize: 14),
                        // ),
                        child: InkWell(
                          onTap: () =>
                              Get.dialog(
                                  TextEditModule(
                                    textKeyName: "checkout_info_description1",
                                    colorKeyName: "checkout_info_description1_color",
                                    fontFamilyKeyName: "checkout_info_description1_font",
                                    textValue: editController
                                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1"]
                                        .toString(),
                                    fontFamily: editController
                                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_font"]
                                        .toString(),
                                    fontSize: editController
                                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_size"]
                                        .toString(),
                                    textColor: Color(int.parse(editController
                                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_color"]
                                        .toString())),
                                  )),
                          child: Text(
                            editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1"]
                                .toString(),
                            style: GoogleFonts.getFont(editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_font"]
                                .toString()).copyWith(
                                fontSize: editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_size"]
                                    .toString() != ""
                                    ? double.parse(editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_size"]
                                    .toString())
                                    : 14,
                                fontWeight: FontWeight.w400,
                                color: Color(int.parse(editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_color"]
                                    .toString()))),

                            // style: GoogleFonts.getFont(selectedFont).copyWith(
                            //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                          ),
                        ),

                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (
                                      context) => const CheckOutList()));
                            },
                            icon: const Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.black
                            ),
                            //icon data for elevated button
                            label: const Text(
                              "Edit Info",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            //label text
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                Get.width > 650
                    ? const SizedBox()
                    :    Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: AppColors.yellowColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(5))
                  ),

                  child: InkWell(
                    onTap: () =>
                        Get.dialog(
                            TextEditModule(
                              textKeyName: "checkout_info_tag",
                              colorKeyName: "checkout_info_tag_color",
                              fontFamilyKeyName: "checkout_info_tag_font",
                              textValue: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag"]
                                  .toString(),
                              fontFamily: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_font"]
                                  .toString(),
                              fontSize: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                                  .toString(),
                              textColor: Color(int.parse(
                                  editController
                                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_color"]
                                      .toString())),
                            )),
                    child: Text(
                      editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag"]
                          .toString(),
                      style: GoogleFonts.getFont(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_font"]
                          .toString()).copyWith(
                          fontSize: editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                              .toString() != ""
                              ? double.parse(editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                              .toString())
                              : 14,
                          fontWeight: FontWeight.w300,
                          color: Color(int.parse(editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_color"]
                              .toString()))),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Get.width > 650
                    ? const SizedBox()
                : InkWell(
                  onTap: () =>
                      Get.dialog(
                          TextEditModule(
                            textKeyName: "checkout_info_title2",
                            colorKeyName: "checkout_info_title2_color",
                            fontFamilyKeyName: "checkout_info_title2_font",
                            textValue: editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2"]
                                .toString(),
                            fontFamily: editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_font"]
                                .toString(),
                            fontSize: editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                                .toString(),
                            textColor: Color(int.parse(editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_color"]
                                .toString())),
                          )),
                  child: Text(
                    editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2"]
                        .toString(),
                    style: GoogleFonts.getFont(editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_font"]
                        .toString()).copyWith(
                        fontSize: editController
                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                            .toString() != ""
                            ? double.parse(editController
                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                            .toString())
                            : 20,
                        fontWeight: FontWeight.bold,
                        color: Color(int.parse(editController
                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_color"]
                            .toString()))),
                  ),
                ),

                const SizedBox(height: 25),
                Get.width > 650
                    ? const SizedBox()
                    : InkWell(
                  onTap: () =>
                      Get.dialog(
                          TextEditModule(
                            textKeyName: "checkout_info_description2",
                            colorKeyName: "checkout_info_description2_color",
                            fontFamilyKeyName: "checkout_info_description2_font",
                            textValue: editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2"]
                                .toString(),
                            fontFamily: editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_font"]
                                .toString(),
                            fontSize: editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                                .toString(),
                            textColor: Color(int.parse(editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_color"]
                                .toString())),
                          )),
                  child: Text(
                    editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2"]
                        .toString(),
                    style: GoogleFonts.getFont(editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_font"]
                        .toString()).copyWith(
                        fontSize: editController
                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                            .toString() != ""
                            ? double.parse(editController
                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                            .toString())
                            : 15,
                        fontWeight: FontWeight.w400,
                        color: Color(int.parse(editController
                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_color"]
                            .toString()))),
                  ),
                ),

                const SizedBox(height: 32),
                Get.width > 650
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: AppColors.yellowColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5))
                            ),
                            // child: Text(
                            //   "Grobiz Plus",
                            //   textAlign: TextAlign.center,
                            //   style: AppTextStyle.regular300
                            //       .copyWith(fontSize: 14),
                            // ),
                            child: InkWell(
                              onTap: () =>
                                  Get.dialog(
                                      TextEditModule(
                                        textKeyName: "checkout_info_tag",
                                        colorKeyName: "checkout_info_tag_color",
                                        fontFamilyKeyName: "checkout_info_tag_font",
                                        textValue: editController
                                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag"]
                                            .toString(),
                                        fontFamily: editController
                                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_font"]
                                            .toString(),
                                        fontSize: editController
                                            .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                                            .toString(),
                                        textColor: Color(int.parse(
                                            editController
                                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_color"]
                                                .toString())),
                                      )),
                              child: Text(
                                editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag"]
                                    .toString(),
                                style: GoogleFonts.getFont(editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_font"]
                                    .toString()).copyWith(
                                    fontSize: editController
                                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                                        .toString() != ""
                                        ? double.parse(editController
                                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                                        .toString())
                                        : 14,
                                    fontWeight: FontWeight.w300,
                                    color: Color(int.parse(editController
                                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_color"]
                                        .toString()))),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () =>
                                Get.dialog(
                                    TextEditModule(
                                      textKeyName: "checkout_info_title2",
                                      colorKeyName: "checkout_info_title2_color",
                                      fontFamilyKeyName: "checkout_info_title2_font",
                                      textValue: editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2"]
                                          .toString(),
                                      fontFamily: editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_font"]
                                          .toString(),
                                      fontSize: editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                                          .toString(),
                                      textColor: Color(int.parse(editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_color"]
                                          .toString())),
                                    )),
                            child: Text(
                              editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2"]
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_font"]
                                  .toString()).copyWith(
                                  fontSize: editController
                                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                                      .toString() != ""
                                      ? double.parse(editController
                                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                                      .toString())
                                      : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(int.parse(editController
                                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_color"]
                                      .toString()))),
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () =>
                                Get.dialog(
                                    TextEditModule(
                                      textKeyName: "checkout_info_description2",
                                      colorKeyName: "checkout_info_description2_color",
                                      fontFamilyKeyName: "checkout_info_description2_font",
                                      textValue: editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2"]
                                          .toString(),
                                      fontFamily: editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_font"]
                                          .toString(),
                                      fontSize: editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                                          .toString(),
                                      textColor: Color(int.parse(editController
                                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_color"]
                                          .toString())),
                                    )),
                            child: Text(
                              editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2"]
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_font"]
                                  .toString()).copyWith(
                                  fontSize: editController
                                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                                      .toString() != ""
                                      ? double.parse(editController
                                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                                      .toString())
                                      : 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(int.parse(editController
                                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_color"]
                                      .toString()))),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),


                          Obx(() {
                            if (checkoutInfoController.CheckInfoDataList.isNotEmpty) {
                              return SizedBox(
                                height: 600,
                                child: ListView.builder(
                                  physics: checkoutInfoController.CheckInfoDataList.length == 1 ?const NeverScrollableScrollPhysics():const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: checkoutInfoController.CheckInfoDataList.length,
                                  itemBuilder: (context, index) {
                                    var data = checkoutInfoController.CheckInfoDataList[index];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _currentIndex = index;
                                              isScrolling = false;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 2,
                                                margin: const EdgeInsets.only(
                                                    right: 16),
                                                decoration: BoxDecoration(
                                                  // color: getItemColor(index),
                                                  color: _currentIndex == index
                                                    ? AppColors.blueColor
                                                    : Colors.grey,
                                                  borderRadius: BorderRadius
                                                      .circular(10),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      data["title"].toString(),
                                                      style: AppTextStyle
                                                          .regular700.copyWith(
                                                          fontSize: 22),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      data["description"]
                                                          .toString(),
                                                      style: AppTextStyle
                                                          .regular400.copyWith(
                                                          fontSize: 14),
                                                    ),

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    'No Data ..',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),


                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.075,
                    ),

                    ///slider code
                    Expanded(
                      child: SizedBox(
                        height: 600,
                        width: Get.width,
                        child: CarouselSlider.builder(
                          carouselController: landingPageController.appDetailsController,
                          options: CarouselOptions(scrollPhysics: checkoutInfoController.CheckInfoDataList.length == 1?NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            // autoPlay: true,
                            autoPlay: isScrolling,
                            autoPlayInterval: const Duration(seconds: 10),
                            viewportFraction: 1.0,
                            height: 630,
                          ),
                          itemCount: checkoutInfoController.CheckInfoDataList
                              .length,
                          itemBuilder: (context, itemIndex, realIndex) {
                            var a = checkoutInfoController
                                .CheckInfoDataList[itemIndex];
                            return _currentIndex == itemIndex
                                ? SizedBox(
                              width: Get.width > 500 ? Get.width * 0.5 : Get.width > 350 ? Get.width * 0.7 : Get.width * 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 550,
                                    width: Get.width * 0.9,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: a["file_media_type"]
                                              .toString() == "image" ||
                                              a["file_media_type"].toString() ==
                                                  "gif"
                                              ? CachedNetworkImage(
                                            imageUrl: APIString
                                                .latestmediaBaseUrl +
                                                a["files"].toString(),
                                            placeholder: (context, url) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(int.parse(
                                                        editController
                                                            .appDemoBgColor
                                                            .value.toString())),
                                                  ),
                                                ),
                                            errorWidget: (context, url,
                                                error) =>
                                            const Icon(Icons.error),
                                            fit: BoxFit
                                                .cover, // Use cover to make the image fit the container
                                          )
                                              : displayUploadedVideo(
                                              a["files"].toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : Container();
                          },
                        ),
                      ),
                    ),

                  ],
                )
                    :SizedBox(
                  // height: Get.width * 0.7,
                  width: Get.width * 0.7,
                  child: CarouselSlider.builder(
                    carouselController: landingPageController.appDetailsController,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      // autoPlay: true,
                      autoPlay: isScrolling,

                      autoPlayInterval: const Duration(seconds: 10),
                      viewportFraction: 1.0,
                      height: 750,
                    ),
                    itemCount: checkoutInfoController.CheckInfoDataList.length,
                    itemBuilder: (context, itemIndex, realIndex) {
                      var a = checkoutInfoController
                          .CheckInfoDataList[itemIndex];
                      return _currentIndex == itemIndex
                          ? SizedBox(
                        width: Get.width > 500 ? Get.width * 0.5 : Get.width >
                            350 ? Get.width * 0.7 : Get.width * 0.7,
                           child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                            const SizedBox(height: 10),
                            Container(
                              height: 300,
                              // Increase the height of the image container
                              width: Get.width * 0.9,
                              // Increase the width of the image container
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: a["file_media_type"].toString() ==
                                        "image" ||
                                        a["file_media_type"].toString() == "gif"
                                        ? CachedNetworkImage(
                                      imageUrl: APIString.latestmediaBaseUrl +
                                          a["files"].toString(),
                                      placeholder: (context, url) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  editController.appDemoBgColor
                                                      .value.toString())),
                                            ),
                                          ),
                                      errorWidget: (context, url,
                                          error) => const Icon(Icons.error),
                                      fit: BoxFit
                                          .cover, // Use cover to make the image fit the container
                                    )
                                        :
                                    //buildMediaWidget()
                                    displayUploadedVideo(a["files"].toString()),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 2,
                                      margin: const EdgeInsets.only(
                                          right: 16),
                                      decoration: BoxDecoration(
                                        color: AppColors.blueColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            a["title"].toString(),
                                            style: AppTextStyle.regular700
                                                .copyWith(fontSize: 22),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            a["description"].toString(),
                                            style: AppTextStyle.regular400
                                                .copyWith(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        ),
                      )
                          : Container();
                    },
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),);
        });
      },
    );
  }

  Widget displayUploadedVideo(String videoUrl) {
    // VideoPlayerController controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));

    bool isVideoPlaying = false;

    // final double videoAspectRatio = /*_controller.value.aspectRatio > 0 ? _controller.value.aspectRatio :*/ 16 / 9;

    return InkWell(
      onTap: () {
        if (controller.value.isPlaying) {
          isVideoPlaying = false;
          controller.pause();
        } else {
          controller.play();
          isVideoPlaying = true;
        }
        // isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                //aspectRatio: 16/9,
                // aspectRatio: 1 / 6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(controller),
                    if (!isVideoPlaying)
                      Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white.withOpacity(0.7),
                      ),
                  ],
                ));
            // );

          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            );
          }
        },
      ),
    );
  }

  Color getItemColor(int index) {
    return _currentIndex == index ? AppColors.blueColor : Colors.grey;
  }
}



