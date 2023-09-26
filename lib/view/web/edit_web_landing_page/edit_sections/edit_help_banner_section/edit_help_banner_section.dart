import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';


class EditHelpBannerSection extends StatefulWidget {

  const EditHelpBannerSection({Key? key}) : super(key: key);

  @override
  State<EditHelpBannerSection> createState() => _EditHelpBannerSectionState();
}

class _EditHelpBannerSectionState extends State<EditHelpBannerSection> {
  final editController = Get.find<EditController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty /*&&*/ || editController.allDataResponse.isEmpty ?const SizedBox()
              : Container(
                width: Get.width,
            decoration:  editController.allDataResponse[0]["help_banner_details"][0]["help_banner_bg_color_switch"].toString() == "1" &&
                editController.allDataResponse[0]["help_banner_details"][0]["help_banner_bg_image_switch"].toString() == "0"
                ? BoxDecoration(
              color: editController
                  .allDataResponse[0]["help_banner_details"][0]["help_banner_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(
                  int.parse(editController.helpBannerBgColor.value.toString()))
                  : Color(int.parse(editController
                  .allDataResponse[0]["help_banner_details"][0]["help_banner_bg_color"]
                  .toString())),
            )
                :BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl + editController.allDataResponse[0]["help_banner_details"][0]["help_banner_bg_image"].toString(),
                  errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
            ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                  child: SizedBox(
                    width: Get.width > 1200 ? Get.width * 0.5 : Get.width > 600
                        ? Get.width * 0.65
                        : Get.width,
                    // decoration: BoxDecoration(color: AppColors.bgGrey.withOpacity(0.3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Switch(
                                  value: editController.helpBanner
                                      .value,
                                  onChanged: (value) {
                                    setState(() {
                                      editController.helpBanner.value = value;
                                      editController.showHideComponent(
                                          value: value == false
                                              ? "No"
                                              : "Yes",
                                          componentName: "help_banner");
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
                                                    ),
                                                    ElevatedButton(onPressed: (){
                                                      Get.dialog(ColorPickDialog(
                                                        containerColor: Color(int.parse(
                                                            editController
                                                                .allDataResponse[0]["help_banner_details"][0]["help_banner_bg_color"]
                                                                .toString())),
                                                        keyNameClr: "help_banner_bg_color",
                                                        clrSwitchValue: "1",
                                                        imgSwitchValue: "0",
                                                        switchKeyNameImg: "help_banner_bg_image_switch",
                                                        switchKeyNameClr: "help_banner_bg_color_switch",
                                                      ));
                                                    }, child: const Text("Color Picker")),
                                                    const SizedBox(height: 20),
                                                    ElevatedButton(onPressed: (){
                                                      Get.dialog( ImgPickDialog(
                                                        keyNameImg: "help_banner_bg_image",
                                                        switchKeyNameImg: "help_banner_bg_image_switch",
                                                        switchKeyNameClr: "help_banner_bg_color_switch",
                                                      ));
                                                    }, child: const Text("Image Picker"))
                                                  ],
                                                )
                                            ),

                                          );

                                        },
                                      );
                                    },
                                    child: Icon(Icons.colorize,color: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_bg_color"].toString()  != "4294967295"
                                        ?AppColors.whiteColor:AppColors.blackColor),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: Get.width > 600 ? Get.width * 0.015 : Get
                            .width * 0.03),


                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "help_banner_question",
                                colorKeyName: "help_banner_question_color",
                                fontFamilyKeyName: "help_banner_question_font",
                                textValue: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question"].toString(),
                                fontFamily: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_font"].toString(),
                                fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_color"].toString())),
                              )),
                          child: Text(
                            editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_size"].toString())
                                    : 20,
                                fontWeight: FontWeight.w800,
                                color: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_color"].toString().isEmpty
                                    ?AppColors.blackColor
                                    :Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_question_color"].toString()))),
                          ),
                        ),

                        SizedBox(height: Get.width > 600 ? Get.width * 0.015 : Get
                            .width * 0.03),

                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "help_banner_title",
                                colorKeyName: "help_banner_title_color",
                                fontFamilyKeyName: "help_banner_title_font",
                                textValue: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title"].toString(),
                                fontFamily: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_font"].toString(),
                                fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_color"].toString())),
                              )),
                          child: Text(
                            editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_size"].toString())
                                    : 24,
                                fontWeight: FontWeight.bold,
                                color: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_color"].toString().isEmpty
                                    ?AppColors.blackColor
                                    :Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_title_color"].toString()))),
                          ),
                        ),

                        SizedBox(height: Get.width > 600 ? Get.width * 0.015 : Get
                            .width * 0.03),

                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "help_banner_timeline",
                                colorKeyName: "help_banner_timeline_color",
                                fontFamilyKeyName: "help_banner_timeline_font",
                                textValue: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline"].toString(),
                                fontFamily: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_font"].toString(),
                                fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_color"].toString())),
                              )),
                          child: Text(
                            editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_size"].toString())
                                    : 16,
                                fontWeight: FontWeight.bold,
                                color: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_color"].toString().isEmpty
                                    ?AppColors.blackColor
                                    :Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_timeline_color"].toString()))),
                          ),
                        ),

                        SizedBox(height: Get.width > 600 ? Get.width * 0.015 : Get
                            .width * 0.03),

                        InkWell(
                          onTap: () => Get.dialog(
                              TextEditModule(
                                textKeyName: "help_banner_button_title",
                                colorKeyName: "help_banner_button_title_color",
                                fontFamilyKeyName: "help_banner_button_title_font",
                                textValue: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title"].toString(),
                                fontFamily: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_font"].toString(),
                                fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_size"].toString(),
                                textColor: Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_color"].toString())),
                              )),
                          child:FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                decoration: BoxDecoration(
                                    color: AppColors.greenColor.withOpacity(0.7)),
                                child: Center(child: Text(
                                  editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title"]
                                      .toString(),
                                  style: GoogleFonts.getFont(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_font"].toString()).copyWith(
                                      fontSize: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_size"].toString() !=""
                                          ? double.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_size"].toString())
                                          : 16,
                                      fontWeight: FontWeight.bold,
                                      color: editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_color"].toString().isEmpty
                                          ?AppColors.blackColor
                                          :Color(int.parse(editController.allDataResponse[0]["help_banner_details"][0]["help_banner_button_title_color"].toString()))),
                                ))),
                          ),
                        ),

                        SizedBox(height: Get.width > 600 ? Get.width * 0.015 : Get
                            .width * 0.03),

                      ],
                    ),
                  ),
                ),
              );
        });
      },
    );
  }

}
