// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/edit_partner_logos_screen.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:grobiz_web_landing/widget/update_media_component.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

///shopify purchase view
class EditNumbersBannerSection extends StatefulWidget {
  const EditNumbersBannerSection({Key? key}) : super(key: key);

  @override
  State<EditNumbersBannerSection> createState() =>
      _EditNumbersBannerSectionState();
}

class _EditNumbersBannerSectionState extends State<EditNumbersBannerSection> {
  WebLandingPageController webLandingPageController = Get.find<
      WebLandingPageController>();
  final editController = Get.find<EditController>();
  final ScrollController controller = ScrollController();
  final numberBannerController = Get.find<NumberBannerController>();
  final ScrollController _scrollController1 = ScrollController();

  void _scrollListenerBack1() {
    if (_scrollController1.offset <=
        _scrollController1.position.minScrollExtent &&
        !_scrollController1.position.outOfRange) {
      // setState(() {
      //   _showButtonBack1 = false;
      // });
    } else {
      // setState(() {
      //   _showButtonBack1 = true;
      // });
    }
  }

  void _scrollListenerForward1() {
    if (_scrollController1.offset >=
        _scrollController1.position
            .maxScrollExtent /* &&
        !_scrollController.position.outOfRange*/
    ) {
      // setState(() {
      //   _showButtonForward1 = false;
      // });
    } else {
      // setState(() {
      //   _showButtonForward1 = true;
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController1.addListener(_scrollListenerBack1);
    _scrollController1.addListener(_scrollListenerForward1);
    // Future.delayed(Duration.zero, () {
    //   numberBannerController.getPartnerLogo();
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty /*&&*/ ||  editController.allDataResponse.isEmpty
              ? const SizedBox()
              : SizedBox(
            width: Get.width,
            child: Column(
              children: [
                Align(
            alignment: Alignment.centerRight,
                  child: Switch(
                    value: editController.numbersBanner
                        .value,
                    onChanged: (value) {
                      setState(() {
                        editController.numbersBanner.value = value;
                        log("value ---- $value");
                        editController.showHideComponent(
                            value: value == false
                                ? "No"
                                : "Yes",
                            componentName: "help_banner");
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          AppColors.blueColor.withOpacity(0.4),
                          AppColors.blueColor.withOpacity(0.2),
                          AppColors.whiteColor.withOpacity(0.6),
                          AppColors.whiteColor
                        ],
                        begin: Alignment.topCenter,
                        stops: const [0.4, 0.8, 0.9, 1],
                        end: Alignment.bottomCenter
                      // radius: 0.75,
                    ),
                  ),
                  child: SizedBox(
                    width: Get.width,
                    child: Column(
                      children: [
                        SizedBox(height: Get.width * 0.02),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.65,
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                SizedBox(
                                  height: Get.width * 0.08,
                                  width: Get.width * 0.15,
                                  child: buildMedia1Widget(),
                                ),
                                Row(
                                  children: [
                                    Switch(
                                      value: numberBannerController.file1Switch.value,
                                      onChanged: (value) {
                                        setState(() {
                                          numberBannerController.file1Switch.value = value;
                                          editController.showHideMedia(value: value == false?"hide":"show",keyName: "numbers_banner_file1_show");
                                        });
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.dialog(UpdateMediaFunction(
                                            imageSize: "width * 0.08 & width * 0.15",
                                            keyNameMedia: "numbers_banner_file1",
                                            keyMediaType: "numbers_banner_file1_mediatype",
                                          ));
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: Get.width * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width:  Get.width > 1000 ? Get.width * 0.03 : Get.width * 0.01),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      // height: Get.height * 0.2,
                                      // width: Get.width * 0.2,
                                      height: Get.width > 1000 ?Get.height * 0.6/*0.3*/ :Get.height * 0.35 /*0.15*/,
                                      width: Get.width > 1000 ? Get.width * 0.25/*0.25*/ : Get.width * 0.2,
                                      decoration:  editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2"].toString().isEmpty
                                          ? const BoxDecoration()
                                          :const BoxDecoration(
                                          // color: AppColors.greyColor
                                          //     .withOpacity(0.5)
                                      ),
                                      child: buildMedia2Widget(),
                                      // child: const Center(child: Text("Media")),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          value: numberBannerController.file2Switch.value,
                                          onChanged: (value) {
                                            setState(() {
                                              numberBannerController.file2Switch.value = value;
                                              editController.showHideMedia(value: value == false?"hide":"show",keyName: "numbers_banner_file2_show");
                                            });
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(UpdateMediaFunction(
                                                imageSize: "width * 0.6 & width * 0.25",
                                                keyNameMedia: "numbers_banner_file2",
                                                keyMediaType: "numbers_banner_file2_mediatype",
                                              ));
                                            },
                                            icon: const Icon(Icons.edit)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width:  Get.width > 1000 ? Get.width * 0.05 : Get.width * 0.02),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.635,
                                    child: InkWell(
                                      onTap: () =>
                                          Get.dialog(
                                              TextEditModule(
                                                textKeyName: "numbers_banner_title",
                                                colorKeyName: "numbers_banner_title_color",
                                                fontFamilyKeyName: "numbers_banner_title_font",
                                                textValue: editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title"]
                                                    .toString(),
                                                fontFamily: editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_font"]
                                                    .toString(),
                                                fontSize: editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_size"]
                                                    .toString(),
                                                textColor: Color(int.parse(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_color"]
                                                        .toString())),
                                              )),
                                      child: Text(
                                        editController
                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title"]
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                            editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_font"]
                                                .toString()).copyWith(
                                            fontSize: editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_size"]
                                                .toString() != ""
                                                ? double.parse(editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_size"]
                                                .toString())
                                                : Get.width > 600 ? 40 : 25,
                                            fontWeight: FontWeight.bold,
                                            color: editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_color"]
                                                .toString()
                                                .isEmpty
                                                ? AppColors.blackColor
                                                : Color(int.parse(editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_title_color"]
                                                .toString()))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.width * 0.02),
                                  SizedBox(
                                    width: Get.width * 0.6,
                                    child: InkWell(
                                      onTap: () =>
                                          Get.dialog(
                                              TextEditModule(
                                                textKeyName: "numbers_banner_description",
                                                colorKeyName: "numbers_banner_description_color",
                                                fontFamilyKeyName: "numbers_banner_title_font",
                                                textValue: editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description"]
                                                    .toString(),
                                                fontFamily: editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_font"]
                                                    .toString(),
                                                fontSize: editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_size"]
                                                    .toString(),
                                                textColor: Color(int.parse(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_color"]
                                                        .toString())),
                                              )),
                                      child: Text(
                                        editController
                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description"]
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                            editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_font"]
                                                .toString()).copyWith(
                                            fontSize: editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_size"]
                                                .toString() != ""
                                                ? double.parse(editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_size"]
                                                .toString())
                                                : Get.width > 600 ? 20 : 16,
                                            fontWeight: FontWeight.w300,
                                            color: editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_color"]
                                                .toString()
                                                .isEmpty
                                                ? AppColors.blackColor
                                                : Color(int.parse(editController
                                                .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_description_color"]
                                                .toString()))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.width * 0.02),
                                  Get.width > 450
                                      ? Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "25M",
                                          //   style: AppTextStyle.regularBold
                                          //       .copyWith(fontSize: 30),
                                          // ),
                                          InkWell(
                                            onTap: () =>
                                                Get.dialog(
                                                    TextEditModule(
                                                      textKeyName: "numbers_banner_global_customer_count",
                                                      colorKeyName: "numbers_banner_global_customer_count_color",
                                                      fontFamilyKeyName: "numbers_banner_global_customer_count_font",
                                                      textValue: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count"]
                                                          .toString(),
                                                      fontFamily: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_font"]
                                                          .toString(),
                                                      fontSize: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"]
                                                          .toString(),
                                                      textColor: Color(
                                                          int.parse(
                                                              editController
                                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"]
                                                                  .toString())),
                                                    )),
                                            child: Text(
                                              editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count"]
                                                  .toString(),
                                              style: GoogleFonts.getFont(
                                                  editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_font"]
                                                      .toString()).copyWith(
                                                  fontSize: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"]
                                                      .toString() != ""
                                                      ? double.parse(
                                                      editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"]
                                                          .toString())
                                                      : 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"]
                                                      .toString()
                                                      .isEmpty
                                                      ? AppColors.blackColor
                                                      : Color(
                                                      int.parse(editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"]
                                                          .toString()))),
                                            ),
                                          ),

                                          SizedBox(height: Get.width * 0.008),
                                          SizedBox(
                                            // width: Get.width*0.08,
                                            width: Get.width > 900
                                                ? Get.width * 0.08
                                                : Get.width * 0.15,
                                            // child: Text(
                                            //   "Global Customers",
                                            //   textAlign: TextAlign.center,
                                            //   style: AppTextStyle.regular400
                                            //       .copyWith(
                                            //       fontSize: 14,
                                            //       height: 1.2),
                                            // ),
                                            child: InkWell(
                                              onTap: () =>
                                                  Get.dialog(
                                                      TextEditModule(
                                                        textKeyName: "numbers_banner_global_customer",
                                                        colorKeyName: "numbers_banner_global_customer_color",
                                                        fontFamilyKeyName: "numbers_banner_global_customer_font",
                                                        textValue: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer"]
                                                            .toString(),
                                                        fontFamily: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_font"]
                                                            .toString(),
                                                        fontSize: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_size"]
                                                            .toString(),
                                                        textColor: Color(
                                                            int.parse(
                                                                editController
                                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_color"]
                                                                    .toString())),
                                                      )),
                                              child: Text(
                                                editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer"]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_font"]
                                                        .toString()).copyWith(
                                                    fontSize: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_size"]
                                                        .toString() != ""
                                                        ? double.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_size"]
                                                            .toString())
                                                        : 14,
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w400,
                                                    color: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_color"]
                                                        .toString()
                                                        .isEmpty
                                                        ? AppColors.blackColor
                                                        : Color(int.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_color"]
                                                            .toString()))),
                                              ),
                                            ),

                                          ),
                                        ],
                                      ),
                                      SizedBox(width: Get.width * 0.01),
                                      SizedBox(
                                        height: 90,
                                        child: VerticalDivider(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 10,
                                          thickness: 0.5,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.01),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "1.2B",
                                          //   style: AppTextStyle.regularBold
                                          //       .copyWith(fontSize: 30),
                                          // ),
                                          InkWell(
                                            onTap: () =>
                                                Get.dialog(
                                                    TextEditModule(
                                                      textKeyName: "numbers_banner_orders_processed_count",
                                                      colorKeyName: "numbers_banner_orders_processed_count_color",
                                                      fontFamilyKeyName: "numbers_banner_orders_processed_count_font",
                                                      textValue: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count"]
                                                          .toString(),
                                                      fontFamily: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_font"]
                                                          .toString(),
                                                      fontSize: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_size"]
                                                          .toString(),
                                                      textColor: Color(
                                                          int.parse(
                                                              editController
                                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_color"]
                                                                  .toString())),
                                                    )),
                                            child: Text(
                                              editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count"]
                                                  .toString(),
                                              style: GoogleFonts.getFont(
                                                  editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_font"]
                                                      .toString()).copyWith(
                                                  fontSize: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_size"]
                                                      .toString() != ""
                                                      ? double.parse(
                                                      editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_size"]
                                                          .toString())
                                                      : 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_color"]
                                                      .toString()
                                                      .isEmpty
                                                      ? AppColors.blackColor
                                                      : Color(
                                                      int.parse(editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_color"]
                                                          .toString()))),
                                            ),
                                          ),

                                          SizedBox(height: Get.width * 0.008),
                                          SizedBox(
                                            // width: Get.width*0.08,
                                            width: Get.width > 900
                                                ? Get.width * 0.08
                                                : Get.width * 0.15,
                                            // child: Text(
                                            //   "Orders Processed",
                                            //   textAlign: TextAlign.center,
                                            //   style: AppTextStyle.regular400
                                            //       .copyWith(
                                            //       fontSize: 14,
                                            //       height: 1.2
                                            //   ),
                                            // ),
                                            child: InkWell(
                                              onTap: () =>
                                                  Get.dialog(
                                                      TextEditModule(
                                                        textKeyName: "numbers_banner_orders_processed",
                                                        colorKeyName: "numbers_banner_orders_processed_color",
                                                        fontFamilyKeyName: "numbers_banner_orders_processed_font",
                                                        textValue: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed"]
                                                            .toString(),
                                                        fontFamily: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_font"]
                                                            .toString(),
                                                        fontSize: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_size"]
                                                            .toString(),
                                                        textColor: Color(
                                                            int.parse(
                                                                editController
                                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_color"]
                                                                    .toString())),
                                                      )),
                                              child: Text(
                                                editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed"]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_font"]
                                                        .toString()).copyWith(
                                                    fontSize: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_size"]
                                                        .toString() != ""
                                                        ? double.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_size"]
                                                            .toString())
                                                        : 14,
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w400,
                                                    color: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_color"]
                                                        .toString()
                                                        .isEmpty
                                                        ? AppColors.blackColor
                                                        : Color(int.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_color"]
                                                            .toString()))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: Get.width * 0.01),
                                      SizedBox(
                                        height: 90,
                                        child: VerticalDivider(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 10,
                                          thickness: 0.5,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.01),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "25K",
                                          //   style: AppTextStyle.regularBold
                                          //       .copyWith(fontSize: 30),
                                          // ),

                                          InkWell(
                                            onTap: () =>
                                                Get.dialog(
                                                    TextEditModule(
                                                      textKeyName: "numbers_banner_checkout_count",
                                                      colorKeyName: "numbers_banner_checkout_count_color",
                                                      fontFamilyKeyName: "numbers_banner_checkout_count_font",
                                                      textValue: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count"]
                                                          .toString(),
                                                      fontFamily: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_font"]
                                                          .toString(),
                                                      fontSize: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_size"]
                                                          .toString(),
                                                      textColor: Color(
                                                          int.parse(
                                                              editController
                                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_color"]
                                                                  .toString())),
                                                    )),
                                            child: Text(
                                              editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count"]
                                                  .toString(),
                                              style: GoogleFonts.getFont(
                                                  editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_font"]
                                                      .toString()).copyWith(
                                                  fontSize: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_size"]
                                                      .toString() != ""
                                                      ? double.parse(
                                                      editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_size"]
                                                          .toString())
                                                      : 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_color"]
                                                      .toString()
                                                      .isEmpty
                                                      ? AppColors.blackColor
                                                      : Color(
                                                      int.parse(editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_color"]
                                                          .toString()))),
                                            ),
                                          ),

                                          SizedBox(height: Get.width * 0.008),
                                          SizedBox(
                                            // width: Get.width*0.08,
                                            width: Get.width > 900
                                                ? Get.width * 0.08
                                                : Get.width * 0.15,
                                            // child: Text(
                                            //   "Peak Checkout Started Per Minute",
                                            //   textAlign: TextAlign.center,
                                            //   style: AppTextStyle.regular400
                                            //       .copyWith(
                                            //       fontSize: 14,
                                            //       height: 1.2),
                                            // ),

                                            child: InkWell(
                                              onTap: () =>
                                                  Get.dialog(
                                                      TextEditModule(
                                                        textKeyName: "numbers_banner_checkout",
                                                        colorKeyName: "numbers_banner_checkout_color",
                                                        fontFamilyKeyName: "numbers_banner_checkout_font",
                                                        textValue: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout"]
                                                            .toString(),
                                                        fontFamily: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_font"]
                                                            .toString(),
                                                        fontSize: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_size"]
                                                            .toString(),
                                                        textColor: Color(
                                                            int.parse(
                                                                editController
                                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_color"]
                                                                    .toString())),
                                                      )),
                                              child: Text(
                                                editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout"]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_font"]
                                                        .toString()).copyWith(
                                                    fontSize: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_size"]
                                                        .toString() != ""
                                                        ? double.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_size"]
                                                            .toString())
                                                        : 14,
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w400,
                                                    color: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_color"]
                                                        .toString()
                                                        .isEmpty
                                                        ? AppColors.blackColor
                                                        : Color(int.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_color"]
                                                            .toString()))),
                                              ),
                                            ),

                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          // Text(
                                          //   "25M",
                                          //   style: AppTextStyle.regularBold
                                          //       .copyWith(fontSize: 25),
                                          // ),
                                          InkWell(
                                            onTap: () =>
                                                Get.dialog(
                                                    TextEditModule(
                                                      textKeyName: "numbers_banner_global_customer_count",
                                                      colorKeyName: "numbers_banner_global_customer_count_color",
                                                      fontFamilyKeyName: "numbers_banner_global_customer_count_font",
                                                      textValue: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count"]
                                                          .toString(),
                                                      fontFamily: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_font"]
                                                          .toString(),
                                                      fontSize: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"]
                                                          .toString(),
                                                      textColor: Color(
                                                          int.parse(
                                                              editController
                                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"]
                                                                  .toString())),
                                                    )),
                                            child: Text(
                                              editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count"]
                                                  .toString(),
                                              style: GoogleFonts.getFont(
                                                  editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_font"]
                                                      .toString()).copyWith(
                                                  fontSize: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"]
                                                      .toString() != ""
                                                      ? double.parse(
                                                      editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"]
                                                          .toString())
                                                      : 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"]
                                                      .toString()
                                                      .isEmpty
                                                      ? AppColors.blackColor
                                                      : Color(
                                                      int.parse(editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"]
                                                          .toString()))),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            // width: Get.width*0.08,
                                            // width: Get.width > 900
                                            //     ? Get.width * 0.08
                                            //     : Get.width * 0.15,
                                            //   child: Text(
                                            //     "Global Customers",
                                            //     textAlign: TextAlign.center,
                                            //     style: AppTextStyle.regular400
                                            //         .copyWith(
                                            //         fontSize: 14,
                                            //         height: 1.2),
                                            //   ),
                                            // child:  InkWell(
                                            //   onTap: () => Get.dialog(
                                            //       TextEditModule(
                                            //         textKeyName: "numbers_banner_global_customer_count",
                                            //         colorKeyName: "numbers_banner_global_customer_count_color",
                                            //         fontFamilyKeyName: "numbers_banner_global_customer_count_font",
                                            //         textValue: editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count"].toString(),
                                            //         fontFamily: editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_font"].toString(),
                                            //         fontSize: editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"].toString(),
                                            //         textColor: Color(int.parse(editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"].toString())),
                                            //       )),
                                            //   child: Text(
                                            //     editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count"]
                                            //         .toString(),
                                            //     textAlign: TextAlign.center,
                                            //     style: GoogleFonts.getFont(editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_font"].toString()).copyWith(
                                            //         fontSize: editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"].toString() !=""
                                            //             ? double.parse(editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_size"].toString())
                                            //             : 14,
                                            //         height: 1.2,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"].toString().isEmpty
                                            //             ?AppColors.blackColor
                                            //             :Color(int.parse(editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_count_color"].toString()))),
                                            //   ),
                                            // ),
                                            child: InkWell(
                                              onTap: () =>
                                                  Get.dialog(
                                                      TextEditModule(
                                                        textKeyName: "numbers_banner_global_customer",
                                                        colorKeyName: "numbers_banner_global_customer_color",
                                                        fontFamilyKeyName: "numbers_banner_global_customer_font",
                                                        textValue: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer"]
                                                            .toString(),
                                                        fontFamily: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_font"]
                                                            .toString(),
                                                        fontSize: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_size"]
                                                            .toString(),
                                                        textColor: Color(
                                                            int.parse(
                                                                editController
                                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_color"]
                                                                    .toString())),
                                                      )),
                                              child: Text(
                                                editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer"]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_font"]
                                                        .toString()).copyWith(
                                                    fontSize: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_size"]
                                                        .toString() != ""
                                                        ? double.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_size"]
                                                            .toString())
                                                        : 14,
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w400,
                                                    color: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_color"]
                                                        .toString()
                                                        .isEmpty
                                                        ? AppColors.blackColor
                                                        : Color(int.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_global_customer_color"]
                                                            .toString()))),
                                              ),
                                            ),


                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Divider(
                                        color: Colors.grey.withOpacity(0.5),
                                        // width: 10,
                                        thickness: 0.5,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "1.2B",
                                          //   style: AppTextStyle.regularBold
                                          //       .copyWith(fontSize: 25),
                                          // ),
                                          InkWell(
                                            onTap: () =>
                                                Get.dialog(
                                                    TextEditModule(
                                                      textKeyName: "numbers_banner_orders_processed_count",
                                                      colorKeyName: "numbers_banner_orders_processed_count_color",
                                                      fontFamilyKeyName: "numbers_banner_orders_processed_count_font",
                                                      textValue: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count"]
                                                          .toString(),
                                                      fontFamily: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_font"]
                                                          .toString(),
                                                      fontSize: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_size"]
                                                          .toString(),
                                                      textColor: Color(
                                                          int.parse(
                                                              editController
                                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_color"]
                                                                  .toString())),
                                                    )),
                                            child: Text(
                                              editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count"]
                                                  .toString(),
                                              style: GoogleFonts.getFont(
                                                  editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_font"]
                                                      .toString()).copyWith(
                                                  fontSize: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_size"]
                                                      .toString() != ""
                                                      ? double.parse(
                                                      editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_size"]
                                                          .toString())
                                                      : 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_color"]
                                                      .toString()
                                                      .isEmpty
                                                      ? AppColors.blackColor
                                                      : Color(
                                                      int.parse(editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_count_color"]
                                                          .toString()))),
                                            ),
                                          ),

                                          const SizedBox(height: 5),
                                          SizedBox(
                                            // width: Get.width*0.08,
                                            width: Get.width > 900
                                                ? Get.width * 0.08
                                                : Get.width * 0.15,
                                            // child: Text(
                                            //   "Orders Processed",
                                            //   textAlign: TextAlign.center,
                                            //   style: AppTextStyle.regular400
                                            //       .copyWith(
                                            //       fontSize: 14,
                                            //       height: 1.2),
                                            // ),
                                            child: InkWell(
                                              onTap: () =>
                                                  Get.dialog(
                                                      TextEditModule(
                                                        textKeyName: "numbers_banner_orders_processed",
                                                        colorKeyName: "numbers_banner_orders_processed_color",
                                                        fontFamilyKeyName: "numbers_banner_orders_processed_font",
                                                        textValue: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed"]
                                                            .toString(),
                                                        fontFamily: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_font"]
                                                            .toString(),
                                                        fontSize: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_size"]
                                                            .toString(),
                                                        textColor: Color(
                                                            int.parse(
                                                                editController
                                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_color"]
                                                                    .toString())),
                                                      )),
                                              child: Text(
                                                editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed"]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_font"]
                                                        .toString()).copyWith(
                                                    fontSize: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_size"]
                                                        .toString() != ""
                                                        ? double.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_size"]
                                                            .toString())
                                                        : 14,
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w400,
                                                    color: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_color"]
                                                        .toString()
                                                        .isEmpty
                                                        ? AppColors.blackColor
                                                        : Color(int.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_orders_processed_color"]
                                                            .toString()))),
                                              ),
                                            ),

                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Divider(
                                        color: Colors.grey.withOpacity(0.5),
                                        // width: 10,
                                        thickness: 0.5,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "25K",
                                          //   style: AppTextStyle.regularBold
                                          //       .copyWith(fontSize: 25),
                                          // ),
                                          InkWell(
                                            onTap: () =>
                                                Get.dialog(
                                                    TextEditModule(
                                                      textKeyName: "numbers_banner_checkout_count",
                                                      colorKeyName: "numbers_banner_checkout_count_color",
                                                      fontFamilyKeyName: "numbers_banner_checkout_count_font",
                                                      textValue: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count"]
                                                          .toString(),
                                                      fontFamily: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_font"]
                                                          .toString(),
                                                      fontSize: editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_size"]
                                                          .toString(),
                                                      textColor: Color(
                                                          int.parse(
                                                              editController
                                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_color"]
                                                                  .toString())),
                                                    )),
                                            child: Text(
                                              editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count"]
                                                  .toString(),
                                              style: GoogleFonts.getFont(
                                                  editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_font"]
                                                      .toString()).copyWith(
                                                  fontSize: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_size"]
                                                      .toString() != ""
                                                      ? double.parse(
                                                      editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_size"]
                                                          .toString())
                                                      : 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_color"]
                                                      .toString()
                                                      .isEmpty
                                                      ? AppColors.blackColor
                                                      : Color(
                                                      int.parse(editController
                                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_count_color"]
                                                          .toString()))),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            // width: Get.width*0.08,
                                            // width: Get.width > 900
                                            //     ? Get.width * 0.08
                                            //     : Get.width * 0.15,
                                            // child: Text(
                                            //   "Peak Checkout Started Per Minute",
                                            //   textAlign: TextAlign.center,
                                            //   style: AppTextStyle.regular400
                                            //       .copyWith(
                                            //       fontSize: 14,
                                            //       height: 1.2),
                                            // ),
                                            child: InkWell(
                                              onTap: () =>
                                                  Get.dialog(
                                                      TextEditModule(
                                                        textKeyName: "numbers_banner_checkout",
                                                        colorKeyName: "numbers_banner_checkout_color",
                                                        fontFamilyKeyName: "numbers_banner_checkout_font",
                                                        textValue: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout"]
                                                            .toString(),
                                                        fontFamily: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_font"]
                                                            .toString(),
                                                        fontSize: editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_size"]
                                                            .toString(),
                                                        textColor: Color(
                                                            int.parse(
                                                                editController
                                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_color"]
                                                                    .toString())),
                                                      )),
                                              child: Text(
                                                editController
                                                    .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout"]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(
                                                    editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_font"]
                                                        .toString()).copyWith(
                                                    fontSize: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_size"]
                                                        .toString() != ""
                                                        ? double.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_size"]
                                                            .toString())
                                                        : 14,
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w400,
                                                    color: editController
                                                        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_color"]
                                                        .toString()
                                                        .isEmpty
                                                        ? AppColors.blackColor
                                                        : Color(int.parse(
                                                        editController
                                                            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_checkout_color"]
                                                            .toString()))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.width * 0.02),
                                  SizedBox(
                                    child: Wrap(
                                      crossAxisAlignment:
                                      WrapCrossAlignment.center,
                                      alignment: WrapAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            // commonButton(
                                            Get.width > 450 ? commonIconButton(
                                                onTap: () async {
                                                  const url = AppString.playStoreAppLink;
                                                  if (await canLaunchUrl(Uri.parse(url))) {
                                                    await launchUrl(Uri.parse(url));
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },

                                                margin: EdgeInsets.zero,
                                                icon: Icons.phone_android,
                                                title: "Create Your App",
                                                btnColor: Colors.redAccent
                                                    .withOpacity(0.7),
                                                txtColor: Colors.white)
                                                : FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: commonIconButton(
                                                  onTap: () async {
                                                    const url = AppString.playStoreAppLink;
                                                    if (await canLaunchUrl(Uri.parse(url))) {
                                                      await launchUrl(Uri.parse(url));
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },

                                                  margin: EdgeInsets.zero,
                                                  icon: Icons.phone_android,
                                                  title: "Create Your App",
                                                  btnColor: Colors.redAccent
                                                      .withOpacity(0.7),
                                                  txtColor: Colors.white),
                                            ),
                                            SizedBox(
                                              width: Get.width > 800
                                                  ? Get.width * 0.15
                                                  : Get.width * 0.7,
                                              // : Get.width * 0.30,
                                              child: Container(
                                                margin: const EdgeInsets.only(right:5,top:5),
                                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                                decoration : BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                  color: editController.allDataResponse[0]["live_app_count_bg"] == "hide"
                                                      ? AppColors.transparentColor
                                                      : Color(int.parse(editController.allDataResponse[0]["live_app_count_bg_color"].toString()),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .remove_red_eye_rounded),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child:
                                                      InkWell(
                                                        onTap: () => Get.dialog(
                                                            TextEditModule(
                                                              textKeyName: "live_app_count_string",
                                                              textValue: editController.allDataResponse[0]["live_app_count_string"].toString(),
                                                              colorKeyName: "live_app_count_color",
                                                              fontFamilyKeyName:
                                                              "live_app_count_font",
                                                              fontFamily: editController.allDataResponse[0]["live_app_count_font"]
                                                                  .toString(),
                                                              fontSize: editController.allDataResponse[0]["live_app_count_size"].toString(),
                                                              textColor: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString())),
                                                            )),
                                                        child: Text(
                                                          "${webLandingPageController.appLiveCount.value} ${editController.allDataResponse[0]["live_app_count_string"].toString()}",
                                                          //
                                                          // editController.allDataResponse[0]["live_app_count_string"].toString(),
                                                          style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                                            // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                            //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                            //     : 14,
                                                            // fontWeight: FontWeight.w400,
                                                              color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: Get.width > 1500 ? Get.width * 0.02 : Get.width > 450 ? 0 : Get.width * 0.02, height: 8),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            // commonButton(
                                            Get.width > 450 ? commonIconButton(
                                                onTap: () async {
                                                  const url = AppString.websiteLink;
                                                  if (await canLaunchUrl(Uri.parse(url))) {
                                                    await launchUrl(Uri.parse(url));
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                icon: Icons.language,
                                                margin: EdgeInsets.zero,
                                                title: "Create Your Website",
                                                btnColor: Colors.green
                                                    .withOpacity(0.7),
                                                txtColor: Colors.white)
                                                : FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: commonIconButton(
                                                  onTap: () async {
                                                    const url = AppString.websiteLink;
                                                    if (await canLaunchUrl(Uri.parse(url))) {
                                                      await launchUrl(Uri.parse(url));
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  icon: Icons.language,
                                                  margin: EdgeInsets.zero,
                                                  title: "Create Your Website",
                                                  btnColor: Colors.green
                                                      .withOpacity(0.7),
                                                  txtColor: Colors.white),),
                                            SizedBox(
                                              width: Get.width > 800
                                                  ? Get.width * 0.15
                                                  : Get.width * 0.7,
                                              child: Container(
                                                margin: const EdgeInsets.only(right:5,top:5),
                                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                                decoration : BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                  color: editController.allDataResponse[0]["live_web_count_bg"] == "hide"
                                                      ? AppColors.transparentColor
                                                      : Color(int.parse(editController.allDataResponse[0]["live_web_count_bg_color"].toString()),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .remove_red_eye_rounded),
                                                    const SizedBox(width: 8),
                                                    Flexible(child:
                                                    InkWell(
                                                      onTap: () => Get.dialog(
                                                          TextEditModule(
                                                            textKeyName: "live_web_count_string",
                                                            textValue: editController.allDataResponse[0]["live_web_count_string"].toString(),
                                                            colorKeyName: "live_web_count_color",
                                                            fontFamilyKeyName:
                                                            "live_web_count_font",
                                                            fontFamily: editController.allDataResponse[0]["live_web_count_font"]
                                                                .toString(),
                                                            fontSize: editController.allDataResponse[0]["live_web_count_size"].toString(),
                                                            textColor: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString())),
                                                          )),
                                                      child: Text(
                                                        "${webLandingPageController.webLiveCount.value} ${editController.allDataResponse[0]["live_web_count_string"].toString()}",
                                                        style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                                          // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                                          //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                                          //     : 14,
                                                          // fontWeight: FontWeight.w400,
                                                            color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),
                                                      ),
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Get.width * 0.04),
                                  InkWell(
                                    onTap: () =>
                                        Get.dialog(
                                            TextEditModule(
                                              textKeyName: "numbers_banner_tagline",
                                              colorKeyName: "numbers_banner_tagline_color",
                                              fontFamilyKeyName: "numbers_banner_tagline_font",
                                              textValue: editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline"]
                                                  .toString(),
                                              fontFamily: editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_font"]
                                                  .toString(),
                                              fontSize: editController
                                                  .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_size"]
                                                  .toString(),
                                              textColor: Color(int.parse(
                                                  editController
                                                      .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_color"]
                                                      .toString())),
                                            )),
                                    child: Text(
                                      editController
                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline"]
                                          .toString(),
                                      style: GoogleFonts.getFont(editController
                                          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_font"]
                                          .toString()).copyWith(
                                        // fontSize: editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_size"].toString() !=""
                                        //     ? double.parse(editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_size"].toString())
                                        //     : 30,
                                          fontWeight: FontWeight.w200,
                                          color: editController
                                              .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_color"]
                                              .toString()
                                              .isEmpty
                                              ? AppColors.blackColor
                                              : Color(int.parse(editController
                                              .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_tagline_color"]
                                              .toString()))),
                                    ),
                                  ),
                                  SizedBox(height: Get.width * 0.02),
                                ],
                              ),
                            ),
                            SizedBox(width:  Get.width > 1000 ? Get.width * 0.05 : Get.width * 0.02),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      // height: Get.height * 0.2,
                                      // width: Get.width * 0.2,
                                        height: Get.width > 1000 ?Get.height * 0.6/*0.3*/ :Get.height * 0.35 /*0.15*/,
                                        width: Get.width > 1000 ? Get.width * 0.25/*0.25*/ : Get.width * 0.2,
                                        decoration:  editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3"].toString().isEmpty
                                            ? const BoxDecoration()
                                            :const BoxDecoration(
                                            // color: AppColors.greyColor.withOpacity(0.5)
                                        ),
                                        child: buildMedia3Widget()
                                      // child: const Center(child: Text("Media")),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          value: numberBannerController.file3Switch.value,
                                          onChanged: (value) {
                                            setState(() {
                                              numberBannerController.file3Switch.value = value;
                                              editController.showHideMedia(value: value == false?"hide":"show",keyName: "numbers_banner_file3_show");
                                            });
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(UpdateMediaFunction(
                                                imageSize: "width * 0.6 & width * 0.25",
                                                keyNameMedia: "numbers_banner_file3",
                                                keyMediaType: "numbers_banner_file3_mediatype",
                                              ));
                                            },
                                            icon: const Icon(Icons.edit)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width:  Get.width > 1000 ? Get.width * 0.03 : Get.width * 0.01),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditPartnerLogoScreen())).whenComplete(() {
                        numberBannerController.getPartnerLogo();
                      });
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.5),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          children: const [
                            Icon(Icons.edit),
                            SizedBox(width: 3),
                            Text("Edit Partner Logos")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(color: AppColors.whiteColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 70,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Obx(() {
                                return numberBannerController.partnerBannerLogos.isEmpty
                                    ? ListView.builder(
                                  // padding: EdgeInsets.only(right: 15),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  // itemCount: companiesData.length,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: ClipOval(
                                        clipBehavior: Clip.antiAlias,
                                        // borderRadius: BorderRadius.all(Radius.circular(25)),
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                    );
                                  },
                                )
                                    : ListView.builder(
                                  padding: const EdgeInsets.only(right: 15),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  // itemCount: companiesData.length,
                                  itemCount: numberBannerController
                                      .partnerBannerLogos.length,
                                  itemBuilder: (context, index) {
                                    var data = numberBannerController
                                        .partnerBannerLogos[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: ClipOval(
                                        clipBehavior: Clip.antiAlias,
                                        // borderRadius: BorderRadius.all(Radius.circular(25)),
                                        child: CachedNetworkImage(
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                          imageUrl: APIString.bannerMediaUrl +
                                              data["images"].toString(),
                                          placeholder: (context, url) =>
                                              Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: const BoxDecoration(
                                                    color: AppColors.greyColor,
                                                  )),
                                          // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                      ),
                                    );

                                  },
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                 Row(
                     mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                     children: [
                       Obx(() {
                         return numberBannerController
                             .partnerBannerLogos.isEmpty ? const SizedBox() : IconButton(
                             onPressed: () {
                               // performMultipleScrolls(3);
                               int currentIndex = _scrollController1.hasClients
                                   ? (_scrollController1.position.maxScrollExtent -
                                   _scrollController1.position.pixels) ~/
                                   56
                                   : 0;
                               int targetIndex = currentIndex + 2;
                               if (targetIndex < numberBannerController
                                   .partnerBannerLogos.length) {
                                 _scrollController1.animateTo(
                                   _scrollController1.position.maxScrollExtent -
                                       targetIndex * 56.0,
                                   duration: const Duration(milliseconds: 500),
                                   curve: Curves.easeInOut,
                                 );
                               }
                             },
                             icon: const Icon(Icons.arrow_back_ios));
                       }),

                       Obx(() {
                         return numberBannerController
                             .partnerBannerLogos.isEmpty?const SizedBox():IconButton(
                             onPressed: () {
                               int currentIndex = _scrollController1.hasClients
                                   ? (_scrollController1.position.minScrollExtent +
                                   _scrollController1.position.pixels) ~/
                                   56
                                   : 0;
                               int targetIndex = currentIndex + 2;
                               if (targetIndex < numberBannerController
                                   .partnerBannerLogos.length) {
                                 _scrollController1.animateTo(
                                   _scrollController1.position.minScrollExtent +
                                       targetIndex * 56.0,
                                   duration: const Duration(milliseconds: 500),
                                   curve: Curves.easeInOut,
                                 );
                               }
                               // performMultipleScrolls1(3);
                             },
                             icon: const Icon(Icons.arrow_forward_ios_outlined));
                       }),
                     ],
                 )
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }


  Widget buildMedia1Widget() {
    if (editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file1_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController
            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file1"]
            .toString(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(
          color: Color(
              int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }
    else if (editController
        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file1_mediatype"]
        .toString()
        .toLowerCase() == "video") {
      return Obx(() {
        return
          numberBannerController.isMedia1Initialized.value
              ? AspectRatio(
            aspectRatio: numberBannerController.media1Controller.value
                .aspectRatio,
            child: VideoPlayer(numberBannerController.media1Controller),
          )
              : const Center(child: CircularProgressIndicator());});
    }

    else if (editController
        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file1_mediatype"]
        .toString()
        .toLowerCase() == "gif") {
      if (editController
          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file1"]
          .toString().toLowerCase().toString()
          .endsWith(".mp4")) {
        return numberBannerController.isMedia1Initialized.value
            ? AspectRatio(
          aspectRatio: numberBannerController.media1Controller.value
              .aspectRatio,
          child: VideoPlayer(numberBannerController.media1Controller),
        )
            : const Center(child: CircularProgressIndicator());
      }
      else {
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController
              .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file1"]
              .toString(),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(decoration: BoxDecoration(
            color: Color(
                int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }
    }
    else {
      return const Center(child: Text("bot"));
    }
  }

  Widget buildMedia2Widget() {
    if (editController
        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2_mediatype"]
        .toString()
        .toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController
            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2"]
            .toString(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(
          color: Color(
              int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }
    else if (editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
        return
          numberBannerController.isMedia2Initialized.value
              ? AspectRatio(
            aspectRatio: numberBannerController.media2Controller.value.aspectRatio,
            child: VideoPlayer(numberBannerController.media2Controller),
          )
              : const Center(child: CircularProgressIndicator());});
    }
    else if (editController
        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2_mediatype"]
        .toString()
        .toLowerCase() == "gif") {
      if (editController
          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2"]
          .toString().toLowerCase().toString()
          .endsWith(".mp4")) {
        return numberBannerController.isMedia2Initialized.value
            ? AspectRatio(
          aspectRatio: numberBannerController.media2Controller.value
              .aspectRatio,
          child: VideoPlayer(numberBannerController.media2Controller),
        )
            : const Center(child: CircularProgressIndicator());
      }
      else {
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController
              .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2"]
              .toString(),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(decoration: BoxDecoration(
            color: Color(
                int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }
    }
    else {
      return const Center(child: Text("bot"));
    }
  }

  Widget buildMedia3Widget() {
    if (editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController
            .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3"]
            .toString(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(
          color: Color(
              int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }
    else if (editController.allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
        return numberBannerController.isMedia3Initialized.value
            ? AspectRatio(
          aspectRatio: numberBannerController.media3Controller.value.aspectRatio,
          child: VideoPlayer(numberBannerController.media3Controller),
        )
            : const Center(child: CircularProgressIndicator());});
    }
    else if (editController
        .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3_mediatype"]
        .toString()
        .toLowerCase() == "gif") {
      if (editController
          .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3"]
          .toString().toLowerCase().toString()
          .endsWith(".mp4")) {
        return numberBannerController.isMedia3Initialized.value
            ? AspectRatio(
          aspectRatio: numberBannerController.media3Controller.value
              .aspectRatio,
          child: VideoPlayer(numberBannerController.media3Controller),
        )
            : const Center(child: CircularProgressIndicator());
      }
      else {
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController
              .allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3"]
              .toString(),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(decoration: BoxDecoration(
            color: Color(
                int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }
    }
    else {
      return const Center(child: Text("bot"));
    }
  }
}
