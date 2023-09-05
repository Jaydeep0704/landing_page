import 'dart:html' as html;
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:grobiz_web_landing/widget/update_media_component.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';


class EditMixBannerSection extends StatefulWidget {
  const EditMixBannerSection({Key? key}) : super(key: key);

  @override
  State<EditMixBannerSection> createState() => _EditMixBannerSectionState();
}

class _EditMixBannerSectionState extends State<EditMixBannerSection> {
  WebLandingPageController webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final mixBannerController = Get.find<MixBannerController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty ?const SizedBox():
          Container(
            // height: Get.width > 1500 ?600 :Get.width > 900 ?600 : 500,
            width: Get.width,
            decoration:  editController.allDataResponse[0]["mix_banner_details"][0] ["mix_banner_bg_color_switch"].toString() == "1" &&
                editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_bg_image_switch"].toString() == "0"
                ?   BoxDecoration(
              color: editController
                  .allDataResponse[0]["mix_banner_details"][0]["mix_banner_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(
                  int.parse(editController.mixBannerBgColor.value.toString()))
                  : Color(int.parse(editController
                  .allDataResponse[0]["mix_banner_details"][0]["mix_banner_bg_color"]
                  .toString())),
            )
                :BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl +
                      editController.allDataResponse[0]["mix_banner_details"]
                      [0]["mix_banner_bg_image"]
                          .toString(),
                  errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
            ),
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: editController.mixBanner
                              .value,
                          onChanged: (value) {
                            setState(() {
                              editController.mixBanner.value = value;
                              print("value ---- $value");
                              editController.showHideComponent(
                                  value: value == false
                                      ? "No"
                                      : "Yes",
                                  componentName: "mix_banner");
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
                                            child: IconButton(onPressed: () => Get.back(),
                                                icon: const Icon(Icons.close)),
                                          ),ElevatedButton(onPressed: (){
                                            Get.dialog( ColorPickDialog(
                                              containerColor: Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_bg_color"].toString())),
                                              keyNameClr: "mix_banner_bg_color",
                                              clrSwitchValue: "1",
                                              imgSwitchValue: "0",
                                              switchKeyNameImg: "mix_banner_bg_image_switch",
                                              switchKeyNameClr: "mix_banner_bg_color_switch",
                                            ));
                                          }, child: const Text("Color Picker")),
                                          const SizedBox(height: 20),
                                          ElevatedButton(onPressed: (){
                                            Get.dialog( ImgPickDialog(
                                              keyNameImg: "mix_banner_bg_image",
                                              switchKeyNameImg: "mix_banner_bg_image_switch",
                                              switchKeyNameClr: "mix_banner_bg_color_switch",
                                            ));
                                          }, child: const Text("Image Picker"))
                                        ],
                                      )
                                  ),

                                );
                                // return ColorPickDialog(
                                //   containerColor: Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["mix_banner_bg_color"].toString())),
                                //   keyNameClr: "mix_banner_bg_color",
                                //   clrSwitchValue: "1",
                                //   imgSwitchValue: "0",
                                //   switchKeyNameImg: "mix_banner_bg_image_switch",
                                //   switchKeyNameClr: "mix_banner_bg_color_switch",
                                // );
                              },
                            );
                          },
                          child: Icon(Icons.colorize,color: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_bg_color"].toString()  != "4294967295"
                              ?AppColors.whiteColor:AppColors.blackColor),),
                      ],
                    )
                ),
                Get.width > 980
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                    height: Get.width > 1100 ?550: 450,
                                    width:  Get.width > 1100 ?550: 450,
                                    child : buildMediaWidget()
                                  // child: Image.asset(
                                  //   "assets/nature.jpeg",
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width > 800 ? 415 : 275,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Switch(
                                      value: mixBannerController.mixBannerFileShowSwitch.value,
                                      onChanged: (value) {
                                        // setState(() {
                                        //   mixBannerController.mixBannerFileShowSwitch.value = value;
                                        // });
                                        setState(() {
                                          mixBannerController.mixBannerFileShowSwitch.value = value;
                                          log("value ---- $value");
                                          editController.showHideMedia(value: value == false?"hide":"show",keyName: "mix_banner_file_show");
                                        });
                                      },
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          Get.dialog(UpdateMediaFunction(
                                            imageSize: "550*550",
                                            keyNameMedia: "mix_banner_file",
                                            keyMediaType: "mix_banner_file_mediatype",
                                          ));
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   "Small Text",
                        //   style:
                        //   TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
                        // ),
                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "mix_banner_subtitle",
                                colorKeyName: "mix_banner_subtitle_color",
                                fontFamilyKeyName: "mix_banner_subtitle_font",
                                textValue: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle"].toString(),
                                fontFamily: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_font"].toString(),
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_color"].toString())),
                              )),
                          child: Text(
                            editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_size"].toString())
                                    : 22,
                                fontWeight: FontWeight.w300,
                                color: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_color"].toString().isEmpty
                                    ?AppColors.blackColor
                                    :Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_color"].toString()))),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // const Spacer(),
                        // const Text(
                        //   "Heading",
                        //   style:
                        //   TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        // ),
                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "mix_banner_title",
                                colorKeyName: "mix_banner_title_color",
                                fontFamilyKeyName: "mix_banner_title_font",
                                textValue: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title"].toString(),
                                fontFamily: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_font"].toString(),
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_color"].toString())),
                              )),
                          child: Text(
                            editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_size"].toString())
                                    : 30,
                                fontWeight: FontWeight.bold,
                                color: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_color"].toString().isEmpty
                                    ?AppColors.blackColor
                                    :Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_color"].toString()))),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // SizedBox(
                        //     width: Get.width * 0.3,
                        //     child: const Text(
                        //       "Sub Text Sub Text Sub Text Sub Text",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w700, fontSize: 17),
                        //     )),
                        SizedBox(
                          width: Get.width * 0.3,
                          child: InkWell(
                            onTap: () => Get.dialog(
                                TextEditModule(
                                  textKeyName: "mix_banner_description",
                                  colorKeyName: "mix_banner_description_color",
                                  fontFamilyKeyName: "mix_banner_description_font",
                                  textValue: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description"].toString(),
                                  fontFamily: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_font"].toString(),
                                  fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_size"].toString(),
                                  textColor: Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_color"].toString())),
                                )),
                            child: Text(
                              editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description"]
                                  .toString(),
                              style: GoogleFonts.getFont(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_font"].toString()).copyWith(
                                  fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_size"].toString() !=""
                                      ? double.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_size"].toString())
                                      : 25,
                                  fontWeight: FontWeight.w700,
                                  color: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_color"].toString().isEmpty
                                      ?AppColors.blackColor
                                      :Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_color"].toString()))),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // crossAxisAlignment: WrapCrossAlignment.center,
                          // alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: commonIconButton(
                                        onTap: () async {
                                          html.window.open(AppString.playStoreAppLink,"_blank");
                                          // const url = 'https://play.google.com/store/apps/details?id=com.efunhub.grobizz';
                                          // if (await canLaunch(url)) {
                                          //   await launch(url);
                                          // } else {
                                          //   throw 'Could not launch $url';
                                          // }
                                        },
                                        margin: EdgeInsets.zero,
                                        width: Get.width > 1500
                                            ? 250
                                            : Get.width > 1000
                                            ? 250
                                            : Get.width > 800
                                            ? 250
                                            : 150,
                                        icon: Icons.phone_android,
                                        title: "Create Your App",
                                        btnColor: Colors.redAccent.withOpacity(0.7),
                                        txtColor: Colors.white)),
                                const SizedBox(height: 10),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    decoration : BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                                      color: editController.allDataResponse[0]["live_app_count_bg"] == "hide"
                                          ? AppColors.transparentColor
                                          : Color(int.parse(editController.allDataResponse[0]["live_app_count_bg_color"].toString()),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.remove_red_eye_rounded),
                                        const SizedBox(width: 8),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child:
                                          Row(
                                            children: [
                                              Obx(() => Text("${webLandingPageController.appLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                                // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                //     : 14,
                                                // fontWeight: FontWeight.w400,
                                                  color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))))),
                                              // Obx(() => Text(" people creating App")),
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
                                                  editController.allDataResponse[0]["live_app_count_string"].toString(),
                                                  style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                                    // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                    //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                    //     : 14,
                                                    // fontWeight: FontWeight.w400,
                                                      color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonIconButton(
                                    onTap: () {
                                      html.window.open(AppString.websiteLink,"_blank");
                                    },
                                    margin: EdgeInsets.zero,
                                    icon: Icons.language,
                                    title: "Create Your Website",
                                    btnColor: Colors.green.withOpacity(0.7),
                                    txtColor: Colors.white),
                                const SizedBox(height: 10),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    decoration : BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                                      color: editController.allDataResponse[0]["live_web_count_bg"] == "hide"
                                          ? AppColors.transparentColor
                                          : Color(int.parse(editController.allDataResponse[0]["live_web_count_bg_color"].toString()),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.remove_red_eye_rounded),
                                        const SizedBox(width: 8),
                                        Row(
                                          children: [
                                            Obx(() => Text("${webLandingPageController.webLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                              // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                              //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                              //     : 14,
                                              // fontWeight: FontWeight.w400,
                                                color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),)),
                                            // Obx(() => Text(" people creating App")),
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
                                                editController.allDataResponse[0]["live_web_count_string"].toString(),
                                                style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                                  // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                                  //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                                  //     : 14,
                                                  // fontWeight: FontWeight.w400,
                                                    color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),
                                              ),
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                  height: Get.width > 600 ?400: 300,
                                  width:  Get.width > 600 ?400: 300,
                                  child : buildMediaWidget()
                              ),
                            ),
                            Container(

                              width: Get.width > 800 ? 415 : 275,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Switch(
                                    value: mixBannerController.mixBannerFileShowSwitch.value,
                                    onChanged: (value) {
                                      // setState(() {
                                      //   mixBannerController.mixBannerFileShowSwitch.value = value;
                                      // });
                                      setState(() {
                                        mixBannerController.mixBannerFileShowSwitch.value = value;
                                        log("value ---- $value");
                                        editController.showHideMedia(value: value == false?"hide":"show",keyName: "mix_banner_file_show");
                                      });
                                    },
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        Get.dialog(UpdateMediaFunction(
                                          imageSize: "550*550",
                                          keyNameMedia: "mix_banner_file",
                                          keyMediaType: "mix_banner_file_mediatype",
                                        ));
                                      },
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const Text(
                        //   "Small Text",
                        //   style:
                        //   TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
                        // ),
                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "mix_banner_subtitle",
                                colorKeyName: "mix_banner_subtitle_color",
                                fontFamilyKeyName: "mix_banner_subtitle_font",
                                textValue: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle"].toString(),
                                fontFamily: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_font"].toString(),
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_color"].toString())),
                              )),
                          child: Text(
                            editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_size"].toString())
                                    : 22,
                                fontWeight: FontWeight.w300,
                                color: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_color"].toString().isEmpty
                                    ?AppColors.blackColor
                                    :Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_subtitle_color"].toString()))),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // const Spacer(),
                        // const Text(
                        //   "Heading",
                        //   style:
                        //   TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        // ),
                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "mix_banner_title",
                                colorKeyName: "mix_banner_title_color",
                                fontFamilyKeyName: "mix_banner_title_font",
                                textValue: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title"].toString(),
                                fontFamily: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_font"].toString(),
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_color"].toString())),
                              )),
                          child: Text(
                            editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_size"].toString())
                                    : 30,
                                fontWeight: FontWeight.bold,
                                color: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_color"].toString().isEmpty
                                    ?AppColors.blackColor
                                    :Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_title_color"].toString()))),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // const Text(
                        //   "Sub Text Sub Text Sub Text Sub Text",
                        //   style:
                        //   TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                        // ),
                        SizedBox(
                          width: Get.width * 0.3,
                          child: InkWell(
                            onTap: () => Get.dialog(
                                TextEditModule(
                                  textKeyName: "mix_banner_description",
                                  colorKeyName: "mix_banner_description_color",
                                  fontFamilyKeyName: "mix_banner_description_font",
                                  textValue: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description"].toString(),
                                  fontFamily: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_font"].toString(),
                                  fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_size"].toString(),
                                  textColor: Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_color"].toString())),
                                )),
                            child: Center(
                              child: Text(
                                editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description"]
                                    .toString(),
                                style: GoogleFonts.getFont(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_font"].toString()).copyWith(
                                    fontSize: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_size"].toString() !=""
                                        ? double.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_size"].toString())
                                        : 25,
                                    fontWeight: FontWeight.w700,
                                    color: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_color"].toString().isEmpty
                                        ?AppColors.blackColor
                                        :Color(int.parse(editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_description_color"].toString()))),
                            textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: commonIconButton(
                                  onTap: () async {
                                    html.window.open(AppString.playStoreAppLink,"_blank");
                                    // const url = 'https://play.google.com/store/apps/details?id=com.efunhub.grobizz';
                                    // if (await canLaunch(url)) {
                                    //   await launch(url);
                                    // } else {
                                    //   throw 'Could not launch $url';
                                    // }
                                  },
                                  icon: Icons.phone_android,
                                  title: "Create Your App",
                                  btnColor: Colors.redAccent.withOpacity(0.7),
                                  txtColor: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_red_eye_rounded),
                                const SizedBox(width: 8),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child:Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    decoration : BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                                      color: editController.allDataResponse[0]["live_app_count_bg"] == "hide"
                                          ? AppColors.transparentColor
                                          : Color(int.parse(editController.allDataResponse[0]["live_app_count_bg_color"].toString()),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Obx(() => Text("${webLandingPageController.appLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                          // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                          //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                          //     : 14,
                                          // fontWeight: FontWeight.w400,
                                            color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))))),
                                        // Obx(() => Text(" people creating App")),
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
                                            editController.allDataResponse[0]["live_app_count_string"].toString(),
                                            style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                              // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                              //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                              //     : 14,
                                              // fontWeight: FontWeight.w400,
                                                color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: commonIconButton(
                                  onTap: () {
                                    html.window.open(AppString.websiteLink,"_blank");
                                  },
                                  icon: Icons.language,
                                  title: "Create Your Website",
                                  btnColor: Colors.green.withOpacity(0.7),
                                  txtColor: Colors.white),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                decoration : BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                                  color: editController.allDataResponse[0]["live_web_count_bg"] == "hide"
                                      ? AppColors.transparentColor
                                      : Color(int.parse(editController.allDataResponse[0]["live_web_count_bg_color"].toString()),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.remove_red_eye_rounded),
                                    const SizedBox(width: 8),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        children: [
                                          Obx(() => Text("${webLandingPageController.webLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                            // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                            //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                            //     : 14,
                                            // fontWeight: FontWeight.w400,
                                              color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),)),
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
                                              ),
                                            ),
                                            child: Text(
                                              editController.allDataResponse[0]["live_web_count_string"].toString(),
                                              style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                                // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                                //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                                //     : 14,
                                                // fontWeight: FontWeight.w400,
                                                  color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),
                                            ),
                                          ),

                                        ],
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
                  ],
                ),
              ],
            ),
          );
        }
        );
      },
    );
  }

  Widget buildMediaWidget() {
    if (editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "image" ||
        editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() ==  "gif") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file"].toString(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }
    else if (editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
        return
          mixBannerController.isVideoInitialized.value
              ? AspectRatio(
            aspectRatio: mixBannerController.videoController.value.aspectRatio,
            child: VideoPlayer(mixBannerController.videoController),
          ) : const Center(child: CircularProgressIndicator());
      });
    }
    // else if (editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "gif") {
    //     return CachedNetworkImage(
    //       // width: Get.width,
    //       imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file"].toString(),
    //       fit: BoxFit.cover,
    //       placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
    //       errorWidget: (context, url, error) =>
    //       const Icon(Icons.error),
    //     );
    // }
    else {
      return const Center(child: Text("bot"));
    }
  }
}



