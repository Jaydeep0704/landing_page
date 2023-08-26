import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/add_case_studies.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/detail_case_study_screen.dart';
import 'package:grobiz_web_landing/view/web/web_widget/static_data/static_list.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';

class EditCaseStudySection extends StatefulWidget {
  const EditCaseStudySection({Key? key}) : super(key: key);

  @override
  State<EditCaseStudySection> createState() => _EditCaseStudySectionState();
}

class _EditCaseStudySectionState extends State<EditCaseStudySection> {
  final editCaseStudyController = Get.find<EditCaseStudyController>();
  final editPartnerController = Get.find<EditCaseStudyController>();
  final editController = Get.find<EditController>();

  final detailCaseStudyController = Get.find<DetailCaseStudyController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   editPartnerController.getCaseStudy();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty ?const SizedBox()
              : SizedBox(
            height: 700,
            width: Get.width,
            child: Stack(

              children: [
                Container(
                  // height: Get.width > 1500 ?Get.width * 0.2:Get.width > 1000 ?Get.width * 0.3: Get.width > 600 ?Get.width * 0.4: Get.width * 0.6,
                  height: 300,
                  width: Get.width,
                  decoration:
                  editController
                      .allDataResponse[0]["case_study_details"][0]["case_study_bg_color_switch"]
                      .toString() == "1" &&
                      editController
                          .allDataResponse[0]["case_study_details"][0]["case_study_bg_image_switch"]
                          .toString() == "0"
                      ? BoxDecoration(
                    color: editController
                        .allDataResponse[0]["case_study_details"][0]["case_study_bg_color"]
                        .toString()
                        .isEmpty
                        ? Color(
                        int.parse(editController.helpBannerBgColor.value
                            .toString()))
                        : Color(int.parse(editController
                        .allDataResponse[0]["case_study_details"][0]["case_study_bg_color"]
                        .toString())),
                  )
                      : BoxDecoration(
                      image: DecorationImage(image: CachedNetworkImageProvider(
                        APIString.mediaBaseUrl + editController
                            .allDataResponse[0]["case_study_details"][0]["case_study_bg_image"]
                            .toString(),
                        errorListener: () => const Icon(Icons.error),),
                          fit: BoxFit.cover)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Switch(
                                value: editController.caseStudy
                                    .value,
                                onChanged: (value) {
                                  setState(() {
                                    editController.caseStudy.value = value;
                                    print("value ---- $value");
                                    editController.showHideComponent(
                                        value: value == false
                                            ? "No"
                                            : "Yes",
                                        componentName: "case_study");
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
                                                      onPressed: () =>
                                                          Get.back(),
                                                      icon: const Icon(
                                                          Icons.close)),
                                                ),
                                                ElevatedButton(onPressed: () {
                                                  Get.dialog(ColorPickDialog(
                                                    containerColor: Color(
                                                        int.parse(
                                                            editController
                                                                .allDataResponse[0]["case_study_details"][0]["case_study_bg_color"]
                                                                .toString())),
                                                    keyNameClr: "case_study_bg_color",
                                                    clrSwitchValue: "1",
                                                    imgSwitchValue: "0",
                                                    switchKeyNameImg: "case_study_bg_image_switch",
                                                    switchKeyNameClr: "case_study_bg_color_switch",
                                                  ));
                                                },
                                                    child: const Text(
                                                        "Color Picker")),
                                                const SizedBox(height: 20),
                                                ElevatedButton(onPressed: () {
                                                  Get.dialog(ImgPickDialog(
                                                    keyNameImg: "case_study_bg_image",
                                                    switchKeyNameImg: "case_study_bg_image_switch",
                                                    switchKeyNameClr: "case_study_bg_color_switch",
                                                  ));
                                                },
                                                    child: const Text(
                                                        "Image Picker"))
                                              ],
                                            )
                                        ),

                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.colorize,
                                    color: editController
                                        .allDataResponse[0]["case_study_details"][0]["help_banner_bg_color"]
                                        .toString() != "4294967295"
                                        ? AppColors.whiteColor : AppColors
                                        .blackColor),
                              ),
                            ],
                          )
                      ),

                      SizedBox(height: Get.width > 1500 ? Get.width * 0.02 : Get
                          .width > 1000 ? Get.width * 0.03 : Get.width * 0.04),
                      // Text(
                      //   "You're in good company",
                      //   textAlign: TextAlign.center,
                      //   style: AppTextStyle.regularBold
                      //       .copyWith(color: AppColors.whiteColor, fontSize: 25,),
                      // ),
                      InkWell(
                        onTap: () =>
                            Get.dialog(
                                TextEditModule(
                                  textKeyName: "case_study_title",
                                  colorKeyName: "case_study_title_color",
                                  fontFamilyKeyName: "case_study_title_font",
                                  textValue: editController
                                      .allDataResponse[0]["case_study_details"][0]["case_study_title"]
                                      .toString(),
                                  fontFamily: editController
                                      .allDataResponse[0]["case_study_details"][0]["case_study_title_font"]
                                      .toString(),
                                  fontSize: editController
                                      .allDataResponse[0]["case_study_details"][0]["case_study_title_size"]
                                      .toString(),
                                  textColor: Color(int.parse(editController
                                      .allDataResponse[0]["case_study_details"][0]["case_study_title_color"]
                                      .toString())),
                                )),
                        child: Text(
                          editController
                              .allDataResponse[0]["case_study_details"][0]["case_study_title"]
                              .toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(editController
                              .allDataResponse[0]["case_study_details"][0]["case_study_title_font"]
                              .toString()).copyWith(
                              fontSize: editController
                                  .allDataResponse[0]["case_study_details"][0]["case_study_title_size"]
                                  .toString() != ""
                                  ? double.parse(editController
                                  .allDataResponse[0]["case_study_details"][0]["case_study_title_size"]
                                  .toString())
                                  : 25,
                              fontWeight: FontWeight.bold,
                              color: editController
                                  .allDataResponse[0]["case_study_details"][0]["case_study_title_color"]
                                  .toString()
                                  .isEmpty
                                  ? AppColors.blackColor
                                  : Color(int.parse(editController
                                  .allDataResponse[0]["case_study_details"][0]["case_study_title_color"]
                                  .toString()))),
                        ),
                      ),

                      SizedBox(height: Get.width > 1500 ? Get.width * 0.02 : Get
                          .width > 1000 ? Get.width * 0.03 : Get.width * 0.04),
                      SizedBox(
                        width: Get.width > 1500
                            ? Get.width * 0.4
                            : Get.width > 1000
                            ? Get.width * 0.6
                            : Get.width * 0.8,
                        child: /*Text(
                          "See how companies like yours used Grobiz's app platform to help them achieve their business goals",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular400
                              .copyWith(
                              color: AppColors.whiteColor, fontSize: 16,
                              height: 1.2),
                        )*/
                        InkWell(
                          onTap: () =>
                              Get.dialog(
                                  TextEditModule(
                                    textKeyName: "case_study_description",
                                    colorKeyName: "case_study_description_color",
                                    fontFamilyKeyName: "case_study_description_font",
                                    textValue: editController
                                        .allDataResponse[0]["case_study_details"][0]["case_study_description"]
                                        .toString(),
                                    fontFamily: editController
                                        .allDataResponse[0]["case_study_details"][0]["case_study_description_font"]
                                        .toString(),
                                    fontSize: editController
                                        .allDataResponse[0]["case_study_details"][0]["case_study_description_size"]
                                        .toString(),
                                    textColor: Color(int.parse(editController
                                        .allDataResponse[0]["case_study_details"][0]["case_study_description_color"]
                                        .toString())),
                                  )),
                          child: Text(
                            editController
                                .allDataResponse[0]["case_study_details"][0]["case_study_description"]
                                .toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(editController
                                .allDataResponse[0]["case_study_details"][0]["case_study_description_font"]
                                .toString()).copyWith(
                                fontSize: editController
                                    .allDataResponse[0]["case_study_details"][0]["case_study_description_size"]
                                    .toString() != ""
                                    ? double.parse(editController
                                    .allDataResponse[0]["case_study_details"][0]["case_study_description_size"]
                                    .toString())
                                    : 25,
                                height: 1.2,
                                fontWeight: FontWeight.w400,
                                color: editController
                                    .allDataResponse[0]["case_study_details"][0]["case_study_description_color"]
                                    .toString()
                                    .isEmpty
                                    ? AppColors.blackColor
                                    : Color(int.parse(editController
                                    .allDataResponse[0]["case_study_details"][0]["case_study_description_color"]
                                    .toString()))),
                          ),
                        ),

                      ),
                      SizedBox(height: Get.width > 1500 ? Get.width * 0.02 : Get
                          .width > 1000 ? Get.width * 0.03 : Get.width * 0.04),
                    ],
                  ),
                ),
                // SizedBox(height: 200),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      log("---------------------------------------");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const AllNewCaseStudies()))
                          .whenComplete(() {
                        editCaseStudyController.getCaseStudy();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, right: 10),
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
                              Text("Edit Case Studies")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0, right: 0,
                  top: 200,
                  child: SizedBox(
                    width: Get.width * 0.85,
                    height: 400,
                    child: Obx(() {
                      return editPartnerController.caseStudyList.isEmpty
                          ? const Center(child: Text("No Data"))
                          : ListView.builder(
                        // physics: const AlwaysScrollableScrollPhysics(),
                        // itemCount: caseStudyData.length,
                        itemCount: editPartnerController.caseStudyList.length,

                        // shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // var a = caseStudyData[index];
                          var data = editPartnerController.caseStudyList[index];

                          return Container(
                            width: Get.width > 375 ? 350 : Get.width * 0.85,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              /* border: Border.all(color: AppColors.blackColor)*/),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: Get.width > 375 ? 350 : Get.width *
                                      0.85,
                                  decoration: const BoxDecoration(
                                    // border: Border.all(color: AppColors.blackColor,width: 1),
                                    border: Border(right: BorderSide(
                                        color: AppColors.blackColor,
                                        width: 1.5),
                                        left: BorderSide(
                                            color: AppColors.blackColor,
                                            width: 1.5),
                                        top: BorderSide(
                                            color: AppColors.blackColor,
                                            width: 1.5)),
                                  ),
                                  // child: Image.asset("${a["logo"]}", height: 100, width: 150,),
                                  child: CachedNetworkImage(
                                    height: 200,
                                    width: 150,
                                    fit: BoxFit.cover,
                                    imageUrl: APIString.bannerMediaUrl +
                                        data["case_study_image"].toString(),
                                    placeholder: (context, url) =>
                                        Container(
                                          height: 100,
                                          width: 150,
                                          decoration: const BoxDecoration(
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(border: Border.all(
                                      color: AppColors.blackColor, width: 1.5)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.lightBlueColor,
                                              border: Border.all(
                                                  color: AppColors.blueColor,
                                                  width: 0.8),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(20))
                                          ),
                                          child: Text(
                                            "${data["case_study_type"]}",
                                            style: AppTextStyle.regularBold
                                                .copyWith(fontSize: 12,
                                                color: AppColors.blueColor),)),
                                      const SizedBox(height: 10),
                                      Text("${data["case_study_title"]}",
                                        style: AppTextStyle.regularBold
                                            .copyWith(
                                            fontSize: 16),),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${data["case_study_short_desciption"]}",
                                        style: AppTextStyle.regular300.copyWith(
                                            fontSize: 14),),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() =>
                                                  DetailCaseStudyScreen(
                                                    shortDescription: data,));
                                            },
                                            child: Container(
                                              width: 175,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: AppColors.greenColor
                                                      .withOpacity(0.5)),
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: Center(child: Text(
                                                "Read the case study",
                                                style: AppTextStyle
                                                    .regular900,)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },);
                    }),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }
}

