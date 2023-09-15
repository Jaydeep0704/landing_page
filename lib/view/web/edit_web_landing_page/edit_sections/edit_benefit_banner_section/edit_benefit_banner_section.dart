import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/EditBannerList.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/edit_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/view/web/web_widget/static_data/static_string.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../../config/api_string.dart';
import '../../../../../widget/update_media_component.dart';
import '../../edit_controller/edit_controller.dart';

class EditBenefitBannerSection extends StatefulWidget {
  const EditBenefitBannerSection({Key? key}) : super(key: key);

  @override
  State<EditBenefitBannerSection> createState() => _EditBenefitBannerSectionState();
}

class _EditBenefitBannerSectionState extends State<EditBenefitBannerSection> {
  WebLandingPageController webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final benefitBannerController = Get.find<BenefitBannerController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   benefitBannerController.getDataApi();
    // });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty ?const SizedBox():
          Container(

            // height: Get.width > 1500 ?600 :Get.width > 900 ?600 : 500,
            width: Get.width,
            decoration:  editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_bg_color_switch"].toString() == "1" &&
                editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_bg_image_switch"].toString() == "0"
                ? BoxDecoration(
              color: editController.allDataResponse[0]
              ["benefit_banner_details"][0]["benefit_banner_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(int.parse(
                  editController.introBgColor.value.toString()))
                  : Color(int.parse(editController.allDataResponse[0]
              ["benefit_banner_details"][0]["benefit_banner_bg_color"]
                  .toString())),
            )
                :BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl +
                      editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_bg_image"]
                          .toString(),
                  errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
            ),
            // padding: EdgeInsets.symmetric(vertical: 80, horizontal: Get.width >1500? Get.width * 0.2: 50),
            child: Get.width > 1000
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 10,
                  horizontal: Get.width > 1000 ? Get.width * 0.05 : 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Switch(
                            value: editController.benefitBanner
                                .value,
                            onChanged: (value) {
                              setState(() {
                                editController.benefitBanner.value = value;
                                print("value ---- $value");
                                editController.showHideComponent(
                                    value: value == false
                                        ? "No"
                                        : "Yes",
                                    componentName: "benefit_banner");
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
                                            ElevatedButton(
                                                onPressed: (){
                                                  Get.dialog( ColorPickDialog(
                                                    containerColor: Color(int.parse(editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_bg_color"].toString())),
                                                    keyNameClr: "benefit_banner_bg_color",
                                                    clrSwitchValue: "1",
                                                    imgSwitchValue: "0",
                                                    switchKeyNameImg: "benefit_banner_bg_image_switch",
                                                    switchKeyNameClr: "benefit_banner_bg_color_switch",
                                                  ));
                                                },
                                                child: const Text("Color Picker")),
                                            const SizedBox(height: 20),
                                            ElevatedButton(onPressed: (){
                                              Get.dialog( ImgPickDialog(
                                                keyNameImg: "benefit_banner_bg_image",
                                                switchKeyNameImg: "benefit_banner_bg_image_switch",
                                                switchKeyNameClr: "benefit_banner_bg_color_switch",
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
                            child: Icon(Icons.colorize,color: editController.allDataResponse[0]["benefit_banner_details"][0]["mix_banner_bg_color"].toString()  != "4294967295"
                                ?AppColors.whiteColor:AppColors.blackColor),),
                        ],
                      )
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///here need to change
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 80,),
                              InkWell(
                                onTap: () =>
                                    Get.dialog(TextEditModule(
                                      textKeyName: "benefit_banner_title",
                                      colorKeyName: "benefit_banner_title_color",
                                      fontFamilyKeyName: "benefit_banner_title_font",
                                      textValue: editController
                                          .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title"]
                                          .toString(),
                                      fontFamily: editController
                                          .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_font"]
                                          .toString(),
                                      fontSize: editController
                                          .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_size"]
                                          .toString(),
                                      textColor: Color(int.parse(editController
                                          .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_color"]
                                          .toString())),
                                    )),

                                child: Text(
                                  editController
                                      .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title"]
                                      .toString(),
                                  style: GoogleFonts.getFont(editController
                                      .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_font"]
                                      .toString()).copyWith(
                                      fontSize: editController
                                          .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_size"]
                                          .toString() != ""
                                          ? double.parse(editController
                                          .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_size"]
                                          .toString())
                                          : 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color(int.parse(editController
                                          .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_color"]
                                          .toString()))),
                                ),
                              ),
                              // const Text(
                              //   "Streamline your\nBack Office",
                              //   style: TextStyle(
                              //       fontSize: 25, fontWeight: FontWeight.bold),
                              // ),
                              const SizedBox(height: 30),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    child: Container(
                                        // decoration: BoxDecoration(
                                        //   color: editController
                                        //       .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file"]
                                        //       .toString()
                                        //       .isEmpty ? Colors.transparent : Colors
                                        //       .blue,
                                        // ),
                                        height: Get.width > 1000 ? 600 : 400,
                                        width: Get.width > 1000 ? 415 : 275,
                                        child: buildMediaWidget()
                                      // child: Image.asset(
                                      //   "assets/nature.jpeg",
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Get.dialog(UpdateMediaFunction(
                                          imageSize: "600*415",
                                          keyNameMedia: "benefit_banner_file",
                                          keyMediaType: "benefit_banner_file_mediatype",
                                        ));
                                      },
                                      icon: const Icon(Icons.edit))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 80,),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80,),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonIconButtonSmall(
                                      onTap: () async {
                                        const url = AppString.playStoreAppLink;
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      icon: Icons.phone_android,
                                      margin: EdgeInsets.zero,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 5),
                                      fontSize: 12,
                                      title: "Create Your App",
                                      btnColor: Colors.redAccent.withOpacity(
                                          0.7),
                                      txtColor: Colors.white),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye_rounded,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),

                                        Obx(() =>
                                        webLandingPageController.appLiveCount
                                            .value.isEmpty ? const SizedBox()
                                            : Text("${webLandingPageController
                                            .appLiveCount
                                            .value} people creating App",
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonIconButtonSmall(
                                      margin: EdgeInsets.zero,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 5),
                                      fontSize: 12,
                                      icon: Icons.language,
                                      title: "Create Your Website",
                                      btnColor: Colors.green.withOpacity(0.7),
                                      txtColor: Colors.white),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye_rounded,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Obx(() =>
                                        webLandingPageController.webLiveCount
                                            .value.isEmpty ? const SizedBox()
                                            : Text("${webLandingPageController
                                            .webLiveCount
                                            .value} people creating Website",
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // commonIconButtonSmall(
                            //     margin: EdgeInsets.zero,
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 0, vertical: 5),
                            //     fontSize: 12,
                            //     icon: Icons.perm_phone_msg_sharp,
                            //     title: "Chat to our expert",
                            //     btnColor: Colors.blue.withOpacity(0.7),
                            //     txtColor: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 25),
                        ///here need to change
                        // Column(
                        //   children: [
                        //     Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: AppColors.blueColor
                        //                 .withOpacity(0.1),
                        //             child: const Center(
                        //                 child: Icon(
                        //                   Icons.add_circle_outline,
                        //                   size: 15,
                        //                   opticalSize: 15,
                        //                   color: AppColors.blueColor,
                        //                 ))),
                        //         const SizedBox(width: 12),
                        //         SizedBox(
                        //           width: Get.width * 0.25,
                        //           child: Column(
                        //             children: [
                        //               Column(
                        //                 crossAxisAlignment: CrossAxisAlignment
                        //                     .start,
                        //                 children: [
                        //                   Text("Title Title Title",
                        //                       style: AppTextStyle.regularBold
                        //                           .copyWith(fontSize: 20)),
                        //                   const SizedBox(height: 10),
                        //                   Text(StaticString.content,
                        //                       style: AppTextStyle.regular300
                        //                           .copyWith(fontSize: 14))
                        //                 ],
                        //               ),
                        //
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     SizedBox(height: Get.width * 0.02),
                        //     const Divider(
                        //       thickness: 0.8,
                        //       color: AppColors.blackColor,
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 25),
                        // Column(
                        //   children: [
                        //     ///here is need to change...
                        //     Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         CircleAvatar(
                        //             radius: 10,
                        //             backgroundColor: AppColors.blueColor
                        //                 .withOpacity(0.1),
                        //             child: const Center(
                        //                 child: Icon(
                        //                   Icons.add_circle_outline,
                        //                   size: 15,
                        //                   opticalSize: 15,
                        //                   color: AppColors.blueColor,
                        //                 ))),
                        //         const SizedBox(width: 12),
                        //         SizedBox(
                        //           width: Get.width * 0.25,
                        //           child: Column(
                        //             children: [
                        //               Column(
                        //                 crossAxisAlignment: CrossAxisAlignment
                        //                     .start,
                        //                 children: [
                        //                   Text("Title Title Title",
                        //                       style: AppTextStyle.regularBold
                        //                           .copyWith(fontSize: 20)),
                        //                   const SizedBox(height: 10),
                        //                   Text(StaticString.content,
                        //                       style: AppTextStyle.regular300
                        //                           .copyWith(fontSize: 14))
                        //                 ],
                        //               ),
                        //
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     SizedBox(height: Get.width * 0.02),
                        //     Divider(
                        //       thickness: 0.8,
                        //       color: AppColors.blackColor.withOpacity(0.5),
                        //     ),
                        //   ],
                        // ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditBanerList())).whenComplete(() {
                                benefitBannerController.getDataApi();
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
                                    Text("Edit Text")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          if (benefitBannerController.DataList.isNotEmpty) {
                            return
                              Container(
                                  height: 450,
                                  child:
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: benefitBannerController.DataList.length,
                                    itemBuilder: (context, index) {
                                      var data = benefitBannerController.DataList[index];
                                      var boolValue = benefitBannerController.bannerInfoReadMore[index];

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: AppColors.blueColor
                                                      .withOpacity(0.1),
                                                  child: const Center(
                                                      child: Icon(
                                                        Icons.add_circle_outline,
                                                        size: 15,
                                                        opticalSize: 15,
                                                        color: AppColors.blueColor,
                                                      ))),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                    data["title"].toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: AppTextStyle.regularBold
                                                        .copyWith(fontSize: 20)

                                                ),
                                              ),
                                            ],
                                          ),
                                        
                                          const SizedBox(height: 10),
                                          Text(
                                              data["description"].toString(),
                                              style: AppTextStyle.regular300.copyWith(fontSize: 14),
                                            textAlign: TextAlign.start,
                                            maxLines: boolValue ? 10 : 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: Get.width * 0.02),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                // boolValue = !boolValue;
                                                benefitBannerController.bannerInfoReadMore[index] = !boolValue;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal : 5,vertical:2),
                                              child: Text(boolValue ? "Read less" : "Read more",
                                                style: AppTextStyle.regular300.copyWith(color: AppColors.blueColor),),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.8,
                                            color: AppColors.blackColor.withOpacity(0.5),
                                          ),
                                        ],
                                      );
                                    },
                                  )
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
                        const SizedBox(height: 80,),

                      ],
                    ),
                  ),
                ],
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: editController.benefitBanner
                                .value,
                            onChanged: (value) {
                              setState(() {
                                editController.benefitBanner.value = value;
                                print("value ---- $value");
                                editController.showHideComponent(
                                    value: value == false
                                        ? "No"
                                        : "Yes",
                                    componentName: "benefit_banner");
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
                                            ElevatedButton(
                                                onPressed: (){
                                              Get.dialog( ColorPickDialog(
                                                containerColor: Color(int.parse(editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_bg_color"].toString())),
                                                keyNameClr: "benefit_banner_bg_color",
                                                clrSwitchValue: "1",
                                                imgSwitchValue: "0",
                                                switchKeyNameImg: "benefit_banner_bg_image_switch",
                                                switchKeyNameClr: "benefit_banner_bg_color_switch",
                                              ));
                                            },
                                                child: const Text("Color Picker")),
                                            const SizedBox(height: 20),
                                            ElevatedButton(onPressed: (){
                                              Get.dialog( ImgPickDialog(
                                                keyNameImg: "benefit_banner_bg_image",
                                                switchKeyNameImg: "benefit_banner_bg_image_switch",
                                                switchKeyNameClr: "benefit_banner_bg_color_switch",
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
                            child: Icon(Icons.colorize,color: editController.allDataResponse[0]["benefit_banner_details"][0]["mix_banner_bg_color"].toString()  != "4294967295"
                                ?AppColors.whiteColor:AppColors.blackColor),),
                        ],
                      )
                  ),
                  const SizedBox(height: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: InkWell(
                          onTap: () =>
                              Get.dialog(TextEditModule(
                                textKeyName: "benefit_banner_title",
                                colorKeyName: "benefit_banner_title_color",
                                fontFamilyKeyName: "benefit_banner_title_font",
                                textValue: editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title"]
                                    .toString(),
                                fontFamily: editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_font"]
                                    .toString(),
                                fontSize: editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_size"]
                                    .toString(),
                                textColor: Color(int.parse(editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_color"]
                                    .toString())),
                              )),
                          child: Text(
                            editController
                                .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title"]
                                .toString(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.getFont(editController
                                .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_font"]
                                .toString()).copyWith(
                                fontSize: editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_size"]
                                    .toString() != ""
                                    ? double.parse(editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_size"]
                                    .toString())
                                    : 35,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title_color"]
                                    .toString()))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              child: Container(

                                  height: Get.width > 1000 ? 600 : 400,
                                  width: Get.width > 1000 ? 415 : 275,
                                  child: buildMediaWidget()
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.dialog(UpdateMediaFunction(
                                  imageSize: "600*415",
                                  keyNameMedia: "benefit_banner_file",
                                  keyMediaType: "benefit_banner_file_mediatype",
                                ));
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonIconButtonSmall(
                                    onTap: () async {
                                      const url = AppString.playStoreAppLink;
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    icon: Icons.phone_android,
                                    margin: EdgeInsets.zero,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    fontSize: 12,
                                    title: "Create Your App",
                                    btnColor: Colors.redAccent.withOpacity(
                                        0.7),
                                    txtColor: Colors.white),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      const Icon(
                                        Icons.remove_red_eye_rounded,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),

                                      Obx(() =>
                                      webLandingPageController.appLiveCount
                                          .value.isEmpty ? const SizedBox()
                                          : Text("${webLandingPageController
                                          .appLiveCount
                                          .value} people creating App",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonIconButtonSmall(
                                    margin: EdgeInsets.zero,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    fontSize: 12,
                                    icon: Icons.language,
                                    title: "Create Your Website",
                                    btnColor: Colors.green.withOpacity(0.7),
                                    txtColor: Colors.white),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      const Icon(
                                        Icons.remove_red_eye_rounded,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Obx(() =>
                                      webLandingPageController.webLiveCount
                                          .value.isEmpty ? const SizedBox()
                                          : Text("${webLandingPageController
                                          .webLiveCount
                                          .value} people creating Website",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // commonIconButtonSmall(
                          //     margin: EdgeInsets.zero,
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 0, vertical: 5),
                          //     fontSize: 12,
                          //     icon: Icons.perm_phone_msg_sharp,
                          //     title: "Chat to our expert",
                          //     btnColor: Colors.blue.withOpacity(0.7),
                          //     txtColor: Colors.white),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ///here need to change
                  // Column(
                  //   children: [
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         CircleAvatar(
                  //             radius: 10,
                  //             backgroundColor: AppColors.blueColor.withOpacity(
                  //                 0.1),
                  //             child: const Center(
                  //                 child: Icon(
                  //                   Icons.add_circle_outline,
                  //                   size: 15,
                  //                   opticalSize: 15,
                  //                   color: AppColors.blueColor,
                  //                 ))),
                  //         const SizedBox(width: 12),
                  //         SizedBox(
                  //           width: Get.width * 0.7,
                  //           child: Column(
                  //             children: [
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text("Title Title Title",
                  //                       style: AppTextStyle.regularBold
                  //                           .copyWith(fontSize: 20)),
                  //                   const SizedBox(height: 10),
                  //                   Text(StaticString.content,
                  //                       style: AppTextStyle.regular300
                  //                           .copyWith(fontSize: 14))
                  //                 ],
                  //               ),
                  //
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width * 0.02),
                  //     const Divider(
                  //       thickness: 0.8,
                  //       color: AppColors.blackColor,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 25),
                  // Column(
                  //   children: [
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         CircleAvatar(
                  //             radius: 10,
                  //             backgroundColor: AppColors.blueColor.withOpacity(
                  //                 0.1),
                  //             child: const Center(
                  //                 child: Icon(
                  //                   Icons.add_circle_outline,
                  //                   size: 15,
                  //                   opticalSize: 15,
                  //                   color: AppColors.blueColor,
                  //                 ))),
                  //         const SizedBox(width: 12),
                  //         SizedBox(
                  //           width: Get.width * 0.7,
                  //           child: Column(
                  //             children: [
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text("Title Title Title",
                  //                       style: AppTextStyle.regularBold
                  //                           .copyWith(fontSize: 20)),
                  //                   const SizedBox(height: 10),
                  //                   Text(StaticString.content,
                  //                       style: AppTextStyle.regular300
                  //                           .copyWith(fontSize: 14))
                  //                 ],
                  //               ),
                  //
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width * 0.02),
                  //     Divider(
                  //       thickness: 0.8,
                  //       color: AppColors.blackColor.withOpacity(0.5),
                  //     ),
                  //   ],
                  // )
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditBanerList())).whenComplete(() {
                          benefitBannerController.getDataApi();
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
                              Text("Edit Text")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (benefitBannerController.DataList.isNotEmpty) {
                      return
                        Container(
                            height: 300,
                            child:
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: benefitBannerController.DataList.length,
                              itemBuilder: (context, index) {
                                var data = benefitBannerController.DataList[index];
                                var boolValue = benefitBannerController.bannerInfoReadMore[index];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        CircleAvatar(
                                            radius: 10,
                                            backgroundColor: AppColors.blueColor
                                                .withOpacity(0.1),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  size: 15,
                                                  opticalSize: 15,
                                                  color: AppColors.blueColor,
                                                ))),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                              data["title"].toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyle.regularBold
                                                  .copyWith(fontSize: 20)

                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        data["description"].toString(),
                                        style: AppTextStyle.regular300
                                            .copyWith(fontSize: 14),
                                      textAlign: TextAlign.start,
                                      maxLines: boolValue ? 10 : 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    TextButton(
                                      onPressed: () {setState(() {benefitBannerController.bannerInfoReadMore[index] = !boolValue;});},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal : 5,vertical:2),
                                        child: Text(boolValue ? "Read less" : "Read more",
                                          style: AppTextStyle.regular300.copyWith(color: AppColors.blueColor),),
                                      ),
                                    ),
                                    SizedBox(height: Get.width * 0.02),
                                    Divider(
                                      thickness: 0.8,
                                      color: AppColors.blackColor.withOpacity(0.5),
                                    ),
                                  ],
                                );
                              },
                            )
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
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        });
      },
    );
  }
  Widget buildMediaWidget() {
    if (editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file"].toString(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
      // return CachedNetworkImage(
      //   imageUrl: widget.introBotFile,
      //   placeholder: (context, url) => const CircularProgressIndicator(),
      //   errorWidget: (context, url, error) => const Icon(Icons.error),
      // );
    }
    else if (editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
        return
          benefitBannerController.isVideoInitialized.value
              ? AspectRatio(
            aspectRatio: benefitBannerController.videoController.value.aspectRatio,
            child: VideoPlayer(benefitBannerController.videoController),
          )
          // : const CircularProgressIndicator();
              : const Center(child: CircularProgressIndicator());});
    }
    // else if (editController.allDataResponse[0]["benefit_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "video") {
    //   return mixBannerController.isVideoInitialized.value
    //       ? AspectRatio(
    //     aspectRatio: mixBannerController.videoController!.value.aspectRatio,
    //     // child: VideoPlayer(mixBannerController.videoController!),
    //     child:  Chewie(controller: mixBannerController.videoControllerChewie!),
    //   )
    //   // : const CircularProgressIndicator();
    //       : const Center(child: CircularProgressIndicator());
    // }
    else if (editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file_mediatype"].toString().toLowerCase() == "gif") {
      if(editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file"].toString().toLowerCase().toString().endsWith(".mp4")){
        return benefitBannerController.isVideoInitialized.value
            ? AspectRatio(
          aspectRatio: benefitBannerController.videoController.value.aspectRatio,
          child: VideoPlayer(benefitBannerController.videoController),
          // child:  Chewie(controller: mixBannerController.videoControllerChewie!),
        )
        // : const CircularProgressIndicator();
            : const Center(child: CircularProgressIndicator());
      }
      else{
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file"].toString(),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }
      // return CachedNetworkImage(
      //   width: Get.width,
      //   imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["benefit_banner_details"][0]["mix_banner_file"].toString(),
      //   placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
      //   errorWidget: (context, url, error) =>
      //   const Icon(Icons.error),
      // );
      // return Image.network(APIString.mediaBaseUrl + editController.allDataResponse[0]["benefit_banner_details"][0]["mix_banner_file"].toString());
    }
    else {
      return const Center(child: Text("bot"));
    }
  }
}






