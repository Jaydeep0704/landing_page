import 'dart:html' as html;
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/config/local_storage.dart';
import 'package:grobiz_web_landing/utils/shared_preference/shared_preference_services.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/ShowCaseAppsList.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/showcase_app_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:grobiz_web_landing/widget/glassmorphic_container.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class EditShowcaseAppsSection extends StatefulWidget {
  const EditShowcaseAppsSection({Key? key}) : super(key: key);

  @override
  State<EditShowcaseAppsSection> createState() =>
      _EditShowcaseAppsSectionState();
}

class _EditShowcaseAppsSectionState extends State<EditShowcaseAppsSection> {
  final webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  // final showCaseAppController = Get.find<ShowCaseAppController>();
  final showCaseAppController = Get.find<ShowCaseAppsController>();


  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   showCaseAppController.getShowCaseApi();
    // });
    getCurrentCouponDetails();
  }

  getCurrentCouponDetails()async{
    showCaseAppController.couponCode.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponCode) ?? "";
    // showCaseAppController.couponUserId.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponUserId);
    // showCaseAppController.couponRegisterDate.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponRegisterDate);
    // showCaseAppController.couponRegisterTime.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponRegisterTime);
    // showCaseAppController.couponUpdatedAt.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponUpdatedAt);
    // showCaseAppController.couponCreatedAt.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponCreatedAt);
    // showCaseAppController.couponId.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponId);

    log("showCaseAppController.couponCode.value ${showCaseAppController.couponCode.value}");
    log("showCaseAppController.couponUserId.value ${showCaseAppController.couponUserId.value}");
    log("showCaseAppController.couponRegisterDate.value ${showCaseAppController.couponRegisterDate.value}");
    log("showCaseAppController.couponRegisterTime.value ${showCaseAppController.couponRegisterTime.value}");
    log("showCaseAppController.couponUpdatedAt.value ${showCaseAppController.couponUpdatedAt.value}");
    log("showCaseAppController.couponCreatedAt.value ${showCaseAppController.couponCreatedAt.value}");
    log("showCaseAppController.couponId.value ${showCaseAppController.couponId.value}");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
                 width: Get.width,
                decoration: editController.allDataResponse[0]["showcase_apps_details"][0] ["showcase_apps_bg_color_switch"].toString() == "1" &&
                    editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_bg_image_switch"].toString() == "0"
                    ?  BoxDecoration(
                  color: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_bg_color"].toString().isEmpty
                      ?Color(int.parse(editController.showcaseAppsBgColor.value.toString()))
                      : Color(int.parse(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_bg_color"].toString())),
                )
                    :BoxDecoration(
                    image: DecorationImage(image: CachedNetworkImageProvider(
                      APIString.mediaBaseUrl +
                          editController.allDataResponse[0]["showcase_apps_details"]
                          [0]["showcase_apps_bg_image"]
                              .toString(),
                      errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
                ),
                child: Column(
                   children: [
                     Align(
                         alignment: Alignment.topRight,
                         child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Switch(
                               value: editController.showcaseApps
                                   .value,
                               onChanged: (value) {
                                 setState(() {
                                   editController.showcaseApps.value = value;
                                   log("value ---- $value");
                                   editController.showHideComponent(
                                       value: value == false
                                           ? "No"
                                           : "Yes",
                                       componentName: "showcase_apps");
                                 });
                               },
                             ),
                             SizedBox(width: 10,),
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
                                                       icon: const Icon(Icons.close)),
                                                 ),
                                                 ElevatedButton(
                                                     onPressed: () {
                                                       Get.dialog( ColorPickDialog(
                                                         // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                         containerColor: Color(int
                                                             .parse(editController
                                                             .allDataResponse[
                                                         0][
                                                         "showcase_apps_details"]
                                                         [0][
                                                         "showcase_apps_bg_color"]
                                                             .toString())),
                                                         keyNameClr:
                                                         "showcase_apps_bg_color",
                                                         clrSwitchValue: "1",
                                                         imgSwitchValue: "0",
                                                         switchKeyNameImg:
                                                         "showcase_apps_bg_image_switch",
                                                         switchKeyNameClr:
                                                         "showcase_apps_bg_color_switch",
                                                       ));
                                                     },
                                                     child:
                                                     const Text("Color Picker")),
                                                 const SizedBox(height: 20),
                                                 ElevatedButton(
                                                     onPressed: () {
                                                       Get.dialog( ImgPickDialog(
                                                         keyNameImg:
                                                         "showcase_apps_bg_image",
                                                         switchKeyNameImg:
                                                         "showcase_apps_bg_image_switch",
                                                         switchKeyNameClr:
                                                         "showcase_apps_bg_color_switch",
                                                       ));
                                                     },
                                                     child: const Text("Image Picker"))
                                               ],
                                             )),
                                       );
                                       // return ColorPickDialog(
                                       //   // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                       //   containerColor: Color(int.parse(
                                       //       editController
                                       //           .allDataResponse[0]
                                       //       ["showcase_apps_details"][0]
                                       //       ["showcase_apps_bg_color"]
                                       //           .toString())),
                                       //   keyNameClr: "showcase_apps_bg_color",
                                       //   clrSwitchValue: "1",
                                       //   imgSwitchValue: "0",
                                       //   switchKeyNameImg:
                                       //   "showcase_apps_bg_image_switch",
                                       //   switchKeyNameClr:
                                       //   "showcase_apps_bg_color_switch",
                                       // );
                                     },
                                   );
                                 },
                               child:Icon(Icons.colorize,color: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_bg_color"].toString()  != "4294967295"
                                   ?AppColors.whiteColor:AppColors.blackColor),
                             ),
                           ],
                         )),
                     const SizedBox(height: 80),

                     ///app created by genesi title and Carosul slider - commented for now
                     ///Starts
                     Padding(
                       padding: EdgeInsets.symmetric(
                           horizontal: Get.width > 1500 ? 60
                               : Get.width > 1000 ? 22
                               : Get.width > 600 ? 15 : 15),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Get.width > 500 ? const Expanded(child: SizedBox( )) :SizedBox(width:  Get.width * 0.10),
                           Expanded(
                             child:  InkWell(
                               onTap: () {
                                 Get.dialog(
                                     TextEditModule(
                                       textKeyName: "showcase_apps_heading",
                                       colorKeyName: "showcase_apps_heading_color",
                                       fontFamilyKeyName: "showcase_apps_heading_font",
                                       textValue: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading"].toString(),
                                       fontFamily: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading_font"].toString(),
                                       textColor: Color(int.parse(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading_color"].toString())),
                                     ));
                               },
                               child: Text(
                                 editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading"].toString(),
                                 textAlign: TextAlign.center,
                                 style: GoogleFonts.getFont(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading_font"].toString()).copyWith(
                                     fontWeight: FontWeight.bold,
                                     fontSize: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading_size"].toString() !=""
                                         ? double.parse(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading_size"].toString())
                                         : 24,
                                     color:  editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading_color"].toString() == ""
                                         ?Colors.black
                                         :Color(int.parse(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_heading_color"].toString()))),
                               ),
                             ),
                           ),
                           Get.width > 500 ? const Expanded(child: SizedBox( )) :SizedBox(width:  Get.width * 0.10),
                           Switch(
                             value: showCaseAppController.titleSwitch.value,
                             onChanged: (value) {
                               setState(() {
                                 showCaseAppController.titleSwitch.value = value;
                                 log("value ---- $value");
                                 editController.showHideMedia(
                                     value: value == false
                                         ? "hide"
                                         : "show",
                                     keyName: "showcase_apps_heading_show_hide");
                               });
                             },
                           ),
                           // const SizedBox(width: 30),
                         ],
                       ),
                     ),
                     Align(
                       alignment: Alignment.topRight,
                       child: InkWell(
                         onTap: () {
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context) => ShowCaseAppsList()));

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
                                 Text("Edit Apps")
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                     ///Here need to change...

                     const SizedBox(height: 40),
                     Switch(
                       value: showCaseAppController.carouselSwitch.value,
                       onChanged: (value) {
                         setState(() {
                           showCaseAppController.carouselSwitch.value = value;
                           log("value ---- $value");
                           editController.showHideMedia(
                               value: value == false
                                   ? "hide"
                                   : "show",
                               keyName: "showcase_apps_show_hide");
                         });
                       },
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Get.width > 505?
                         IconButton(
                           onPressed: () {
                             webLandingPageController.carouselController.previousPage();
                           },
                           icon: const Icon(Icons.arrow_back),
                         )
                             :const SizedBox(),
                         Container(
                           width: Get.width > 1500 ?  Get.width - Get.width * 0.16 : Get.width > 1000 ? Get.width - Get.width * 0.15 : Get.width > 500 ?Get.width - Get.width * 0.2:Get.width -50,
                           alignment: Alignment.center,
                           child: CarouselSlider(
                             carouselController:
                             webLandingPageController.carouselController, // Give the controller
                             options: CarouselOptions(
                               // viewportFraction: Get.width > 1500 ?0.3 : Get.width > 1000 ? 0.33 : Get.width > 500 ? 0.36 :0.89,
                               viewportFraction: Get.width > 1500 ?0.35 : Get.width > 1000 ? 0.45 : Get.width > 500 ? 0.55 :0.89,
                               height:  Get.width > 1500 ? 325 : Get.width > 1000 ? 280 :Get.width > 500 ? 250 : 230,
                               // height:  Get.width > 1500 ? 300 : Get.width > 1000 ? 250 : 230,
                               autoPlayAnimationDuration:
                               const Duration(seconds: 1),
                               autoPlay: true,
                             ),
                             items: showCaseAppController.ShowcaseData.map((featuredImage) {
                               return Container(
                                 // color: AppColors.greenColor,
                                 padding: const EdgeInsets.symmetric(
                                     horizontal: 8.0),
                                 child: Column(
                                   crossAxisAlignment:
                                   CrossAxisAlignment.center,
                                   children: [
                                     Container(
                                       // height: Get.width > 1500 ? 225 : Get.width > 1000 ? 200 : 175,
                                         height: Get.width > 1500 ? 275 : Get.width > 1000 ? 240 :Get.width > 500 ? 212 : 175,
                                         width: Get.width > 1500 ? 650 : Get.width > 1000 ?400 :  Get.width > 600 ?500:Get.width-Get.width*0.2,
                                         // width: Get.width > 1500 ? 600 : Get.width > 1000 ?500 :  Get.width > 500 ?450:Get.width-Get.width*0.2,
                                         decoration: const BoxDecoration(
                                             // color: Colors.blue,
                                             borderRadius:
                                             BorderRadius.all(Radius.circular(5))),
                                         child: ClipRRect(
                                           borderRadius:
                                           const BorderRadius.all(Radius.circular(20)),
                                           child: featuredImage['file_mediatype'] == "image" ||
                                               featuredImage['file_mediatype'] == "gif"
                                               ? CachedNetworkImage(
                                             width: Get.width * 0.9,
                                             imageUrl:
                                             APIString.latestmediaBaseUrl + featuredImage['files'].toString(),
                                             placeholder: (context, url) => Container(
                                               decoration: BoxDecoration(
                                                 color: Color(int.parse(editController
                                                     .appDemoBgColor.value
                                                     .toString())),
                                               ),
                                             ),
                                             errorWidget: (context, url, error) =>
                                             const Icon(Icons.error),
                                             fit: BoxFit.cover,
                                           )
                                               : displayUploadedVideo(featuredImage['files'].toString()),
                                         )
                                       // Image.asset("${featuredImage["image"]}"
                                       // )
                                     ),
                                     Padding(padding: const EdgeInsets.only(top: 20),
                                       child: Text("${featuredImage['title']}"),
                                     )
                                   ],
                                 ),
                               );
                             }).toList(),
                           ),
                         ),
                         Get.width > 505?
                         IconButton(
                           onPressed: () {
                             // Use the controller to change the current page
                             webLandingPageController.carouselController.nextPage();
                           },
                           icon: const Icon(Icons.arrow_forward),
                         ):
                         const SizedBox(),
                       ],
                     ),
                     Get.width > 505?const SizedBox():
                     Padding(
                       padding: const EdgeInsets.only(top: 16),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           IconButton(
                             onPressed: () {
                               webLandingPageController.carouselController.previousPage();
                             },
                             icon: const Icon(Icons.arrow_back),
                           ),
                           const SizedBox(
                             width: 24,
                           ),
                           IconButton(
                             onPressed: () {
                               webLandingPageController.carouselController.nextPage();
                             },
                             icon: const Icon(Icons.arrow_forward),
                           )
                         ],
                       ),
                     ),
                     const SizedBox(height: 40),
                     ///Ends
                     // Padding(
                     //   padding: EdgeInsets.symmetric(
                     //       horizontal: Get.width > 1500 ? 60
                     //           : Get.width > 1000 ? 22
                     //           : Get.width > 600 ? 15 : 15),
                     //   child: Row(
                     //     children: [
                     //       Get.width > 500 ? const Expanded(child: SizedBox( ))
                     //           :SizedBox(width:  Get.width * 0.10),
                     //       Expanded(
                     //         child: Text(
                     //           "Apps Created by \"Genesi\" ",
                     //           textAlign: TextAlign.center,
                     //           style: TextStyle(
                     //             // fontSize: 50,
                     //               fontSize: Get.width > 1000 ? 24 : 24,
                     //               fontWeight: FontWeight.bold,
                     //               color: Colors.black),
                     //         ),
                     //       ),
                     //       Get.width > 500 ? const Expanded(child: SizedBox( ))
                     //           :SizedBox(width:  Get.width * 0.10),
                     //
                     //       // const SizedBox(width: 30),
                     //     ],
                     //   ),
                     // ),
                     // const SizedBox(height: 40),
                     // Row(
                     //   mainAxisAlignment: MainAxisAlignment.center,
                     //   children: [
                     //     Get.width > 505?
                     //     IconButton(
                     //       onPressed: () {
                     //         webLandingPageController.carouselController.previousPage();
                     //       },
                     //       icon: const Icon(Icons.arrow_back),
                     //     )
                     //         :const SizedBox(),
                     //     Container(
                     //       width: Get.width > 1500 ?  Get.width - Get.width * 0.16 : Get.width > 1000 ? Get.width - Get.width * 0.15 : Get.width > 500 ?Get.width - Get.width * 0.2:Get.width -50,
                     //       alignment: Alignment.center,
                     //       child: CarouselSlider(
                     //         carouselController:
                     //         webLandingPageController.carouselController, // Give the controller
                     //         options: CarouselOptions(
                     //           // viewportFraction: Get.width > 1500 ?0.3 : Get.width > 1000 ? 0.33 : Get.width > 500 ? 0.36 :0.89,
                     //           viewportFraction: Get.width > 1500 ?0.35 : Get.width > 1000 ? 0.45 : Get.width > 500 ? 0.55 :0.89,
                     //           height:  Get.width > 1500 ? 325 : Get.width > 1000 ? 280 :Get.width > 500 ? 250 : 230,
                     //           // height:  Get.width > 1500 ? 300 : Get.width > 1000 ? 250 : 230,
                     //           autoPlayAnimationDuration:
                     //           const Duration(seconds: 1),
                     //           autoPlay: true,
                     //         ),
                     //         items: createdApp.map((featuredImage) {
                     //           return Container(
                     //             // color: AppColors.greenColor,
                     //             padding: const EdgeInsets.symmetric(
                     //                 horizontal: 8.0),
                     //             child: Column(
                     //               crossAxisAlignment:
                     //               CrossAxisAlignment.center,
                     //               children: [
                     //                 Container(
                     //                   // height: Get.width > 1500 ? 225 : Get.width > 1000 ? 200 : 175,
                     //                     height: Get.width > 1500 ? 275 : Get.width > 1000 ? 240 :Get.width > 500 ? 212 : 175,
                     //                     width: Get.width > 1500 ? 650 : Get.width > 1000 ?400 :  Get.width > 600 ?500:Get.width-Get.width*0.2,
                     //                     // width: Get.width > 1500 ? 600 : Get.width > 1000 ?500 :  Get.width > 500 ?450:Get.width-Get.width*0.2,
                     //                     decoration: const BoxDecoration(
                     //                         color: Colors.blue,
                     //                         borderRadius:
                     //                         BorderRadius.all(Radius.circular(5))),
                     //                     child: Image.asset("${featuredImage["image"]}")),
                     //                 Padding(padding: const EdgeInsets.only(top: 20),
                     //                   child: Text("${featuredImage["name"]}"),
                     //                 )
                     //               ],
                     //             ),
                     //           );
                     //         }).toList(),
                     //       ),
                     //     ),
                     //     Get.width > 505?
                     //     IconButton(
                     //       onPressed: () {
                     //         // Use the controller to change the current page
                     //         webLandingPageController.carouselController.nextPage();
                     //       },
                     //       icon: const Icon(Icons.arrow_forward),
                     //     ):
                     //     const SizedBox(),
                     //   ],
                     // ),
                     // Get.width > 505?const SizedBox():
                     // Padding(
                     //   padding: const EdgeInsets.only(top: 16),
                     //   child: Row(
                     //     mainAxisAlignment: MainAxisAlignment.center,
                     //     children: [
                     //       IconButton(
                     //         onPressed: () {
                     //           webLandingPageController.carouselController.previousPage();
                     //         },
                     //         icon: const Icon(Icons.arrow_back),
                     //       ),
                     //       const SizedBox(
                     //         width: 24,
                     //       ),
                     //       IconButton(
                     //         onPressed: () {
                     //           webLandingPageController.carouselController.nextPage();
                     //         },
                     //         icon: const Icon(Icons.arrow_forward),
                     //       )
                     //     ],
                     //   ),
                     // ),
                     // const SizedBox(height: 40),
                     ///Ends
                     // Padding(
                     //   padding: EdgeInsets.symmetric(
                     //       horizontal: Get.width > 1500
                     //           ? 60
                     //           : Get.width > 1000
                     //           ? 22
                     //           : Get.width > 600
                     //           ? 15
                     //           : 15),
                     //   child: const Text(
                     //     " \"Genesi\" armours you with the ease of website & app creation via AI tool\nThat none other in it's competition does.\n"
                     //         "with 98% og accuracy , it renders the premium standard quality\n& the app is suitable to beat its rival on the launch",
                     //     textAlign: TextAlign.center,
                     //     style: TextStyle(
                     //         height: 1.5,
                     //         fontWeight: FontWeight.w400,
                     //         fontSize: 20,
                     //         color: Colors.black),
                     //   ),
                     // ),
                     Padding(
                       // padding: EdgeInsets.symmetric(horizontal: Get.width > 1500 ? 60 : Get.width > 1000 ? 22 : Get.width > 600 ? 15 : 15),
                       padding: EdgeInsets.symmetric(horizontal: Get.width > 1500 ? 200 : Get.width > 1000 ? 200 : Get.width > 600 ? 15 : 15),
                       child: InkWell(
                         onTap: () {
                           Get.dialog(
                         TextEditModule(
                         textKeyName: "showcase_apps_desc",
                         colorKeyName: "showcase_apps_desc_color",
                         fontFamilyKeyName: "showcase_apps_desc_font",
                         textValue: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc"].toString(),
                         fontFamily: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc_font"].toString(),
                         textColor: Color(int.parse(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc_color"].toString())),
                         ));
                       },
                         child:   Text(
                           editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc"].toString(),
                           textAlign: TextAlign.center,
                           style: GoogleFonts.getFont(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc_font"].toString()).copyWith(
                               height: 1.5,
                               fontWeight: FontWeight.w400,
                               fontSize: editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc_size"].toString() !=""
                                   ? double.parse(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc_size"].toString())
                                   : 20,
                               color:  editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc_color"].toString() == ""
                                   ?Colors.black
                                   :Color(int.parse(editController.allDataResponse[0]["showcase_apps_details"][0]["showcase_apps_desc_color"].toString()))),
                         ),
                       ),
                     ),
                     const SizedBox(height: 40),
                     Wrap(
                       crossAxisAlignment: WrapCrossAlignment.start,
                       alignment: WrapAlignment.center,
                       // mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             commonIconButton(
                                 onTap: () async {
                                   html.window.open(AppString.playStoreAppLink,"_blank");
                                   // const url =
                                   //     'https://play.google.com/store/apps/details?id=com.efunhub.grobizz';
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
                                     // Obx(() => webLandingPageController
                                     //     .appLiveCount.value.isEmpty
                                     //     ? const SizedBox()
                                     //     : Text(
                                     //     "${webLandingPageController.appLiveCount.value} people creating App")),
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
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             commonIconButton(
                                 onTap: () {
                                   html.window.open(AppString.websiteLink,"_blank");
                                 },
                                 icon: Icons.language,
                                 title: "Create Your Website",
                                 btnColor: Colors.green.withOpacity(0.7),
                                 txtColor: Colors.white),
                             FittedBox(
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
                                     // Text("30k people creating Website"),
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
                         // commonIconButton(
                         //     icon: Icons.perm_phone_msg_sharp,
                         //     title: "Chat to our expert",
                         //     btnColor: Colors.blue.withOpacity(0.7),
                         //     txtColor: Colors.white),
                       ],
                     ),

                     const SizedBox(height: 40),
                     // const Text("Currently App Build in Process for 30k Customers"),

                     const SizedBox(height: 40),
                     Padding(
                       padding: EdgeInsets.symmetric(
                           horizontal: Get.width > 1500
                               ? 60
                               : Get.width > 1000
                               ? 22
                               : Get.width > 600
                               ? 15
                               : 15),
                       child: Wrap(
                         crossAxisAlignment: WrapCrossAlignment.center,
                         // mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           // const Text(
                           //   "Deem coupon code",
                           //   style: TextStyle(
                           //       fontWeight: FontWeight.w400,
                           //       fontSize: 20,
                           //       color: Colors.black),
                           // ),
                           // const Text(
                           //   " Ending in : 00:30:00 hours",
                           //   style: TextStyle(
                           //       fontWeight: FontWeight.w400,
                           //       fontSize: 20,
                           //       color: Colors.blue),
                           // ),
                           /*FittedBox(
                             fit: BoxFit.scaleDown,
                             child: Container(
                               padding: const EdgeInsets.all(20),
                               decoration: const BoxDecoration(
                                   color: AppColors.whiteColor
                               ),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   commonButton(
                                   //     onTap: (){
                                   //   showCaseAppController.generateCoupon().whenComplete(()async {
                                   //     showCaseAppController.couponCode.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponCode);
                                   //     showCaseAppController.couponUserId.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponUserId);
                                   //     showCaseAppController.couponRegisterDate.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponRegisterDate);
                                   //     showCaseAppController.couponRegisterTime.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponRegisterTime);
                                   //     showCaseAppController.couponUpdatedAt.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponUpdatedAt);
                                   //     showCaseAppController.couponCreatedAt.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponCreatedAt);
                                   //     showCaseAppController.couponId.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponId);
                                   //
                                   //   });
                                   // },
                                       title: "Redeem Coupon"),
                                   Obx(() {
                                     return showCaseAppController.couponCode.value.isEmpty
                                         ?  const SizedBox()
                                         :  Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Text("Your Coupon Code is : ${showCaseAppController.couponCode.value}"),
                                         InkWell(
                                             onTap: () async {
                                               await Clipboard.setData(
                                                 ClipboardData(
                                                   text: showCaseAppController.couponCode.value,
                                                 ),
                                               ).then(
                                                     (result) {
                                                   showSnackbar(title: "Success", message: "Copied!");
                                                   // Fluttertoast.showToast(msg: "Copied!");
                                                 },
                                               );
                                             },
                                             child: const Padding(
                                               padding: EdgeInsets.all(8.0),
                                               child: Icon(Icons.copy),
                                             )),
                                       ],
                                     );
                                   },
                                   ),
                                 ],
                               ),
                             ),
                           ),*/
                           FittedBox(
                             fit: BoxFit.scaleDown,
                             child: GlassmorphicContainer(
                               blur: 10,
                               borderRadius: 20,
                               color: Colors.white,
                               gradientBegin: Alignment.topLeft,
                               gradientEnd: Alignment.bottomRight,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   commonButton(
                                     //     onTap: (){
                                     //   showCaseAppController.generateCoupon().whenComplete(()async {
                                     //     showCaseAppController.couponCode.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponCode);
                                     //     showCaseAppController.couponUserId.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponUserId);
                                     //     showCaseAppController.couponRegisterDate.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponRegisterDate);
                                     //     showCaseAppController.couponRegisterTime.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponRegisterTime);
                                     //     showCaseAppController.couponUpdatedAt.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponUpdatedAt);
                                     //     showCaseAppController.couponCreatedAt.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponCreatedAt);
                                     //     showCaseAppController.couponId.value = await getDataFromLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.couponId);
                                     //
                                     //   });
                                     // },
                                       title: "Redeem Coupon",
                                     btnColor: Color(0xFFEA5247),txtColor: AppColors.whiteColor,
                                   ),
                                   Obx(() {
                                     return showCaseAppController.couponCode.value.isEmpty
                                         ?  const SizedBox()
                                         :  Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Text("Your Coupon Code is : ${showCaseAppController.couponCode.value}"),
                                         InkWell(
                                             onTap: () async {
                                               await Clipboard.setData(
                                                 ClipboardData(
                                                   text: showCaseAppController.couponCode.value,
                                                 ),
                                               ).then(
                                                     (result) {
                                                   showSnackbar(title: "Success", message: "Copied!");
                                                   // Fluttertoast.showToast(msg: "Copied!");
                                                 },
                                               );
                                             },
                                             child: const Padding(
                                               padding: EdgeInsets.all(8.0),
                                               child: Icon(Icons.copy),
                                             )),
                                       ],
                                     );
                                   },
                                   ),
                                 ],
                               ),
                             ),
                           )
                         ],
                       ),
                     ),
                     const SizedBox(height: 80),
                   ],
                 ),
               );
        });
      },
    );
  }

  Widget displayUploadedVideo(String videoUrl) {
    VideoPlayerController _controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    bool isVideoPlaying = false;

    // final double videoAspectRatio = /*_controller.value.aspectRatio > 0 ? _controller.value.aspectRatio :*/ 16 / 9;

    return InkWell(
      onTap: () {
        if (_controller.value.isPlaying) {
          isVideoPlaying=false;
          _controller.pause();
        } else {
          _controller.play();
          isVideoPlaying=true;
        }
        // isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return /*AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
              aspectRatio: 16/9,
              // aspectRatio: 1 / 6,
              child:*/ Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller),
                if (!isVideoPlaying)
                  Icon(
                    Icons.play_circle_fill,
                    size: 60,
                    color: Colors.white.withOpacity(0.7),
                  ),
              ],
            );
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

}
