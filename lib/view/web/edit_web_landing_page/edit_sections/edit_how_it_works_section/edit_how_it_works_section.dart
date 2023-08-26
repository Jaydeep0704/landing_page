import 'dart:developer';
import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_how_it_works_section/edit_hiw_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:grobiz_web_landing/widget/update_media_component.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';


class EditHowItWorksSection extends StatefulWidget {
  const EditHowItWorksSection({Key? key}) : super(key: key);

  @override
  State<EditHowItWorksSection> createState() => _EditHowItWorksSectionState();
}

class _EditHowItWorksSectionState extends State<EditHowItWorksSection> {
  WebLandingPageController webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final editHIWController = Get.find<EditHiwController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty ?const SizedBox():
        Container(
          width: Get.width,
          decoration: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_bg_color_switch"].toString() == "1" &&
              editController.allDataResponse[0]["how_it_works_details"][0]["hiw_bg_image_switch"].toString() == "0"
              ?  BoxDecoration(
            color: editController
                .allDataResponse[0]["how_it_works_details"][0]["hiw_bg_color"]
                .toString()
                .isEmpty
                ? Color(int.parse(editController.hiwBgColor.value.toString()))
                : Color(int.parse(editController
                .allDataResponse[0]["how_it_works_details"][0]["hiw_bg_color"]
                .toString())),
          )
              :BoxDecoration(
              image: DecorationImage(image: CachedNetworkImageProvider(
                APIString.mediaBaseUrl + editController.allDataResponse[0]["how_it_works_details"][0]["hiw_bg_image"].toString(),
                errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: /*Get.width >600 ?0:*/ 16),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: editController.howItWorks
                              .value,
                          onChanged: (value) {
                            setState(() {
                              editController.howItWorks.value = value;
                              log("value ---- $value");
                              editController.showHideComponent(
                                  value: value == false
                                      ? "No"
                                      : "Yes",
                                  componentName: "how_it_works");
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
                                              child: IconButton(onPressed: () => Get.back(),
                                                  icon: const Icon(Icons.close)),
                                            ),    ElevatedButton(onPressed: (){
                                              Get.dialog(ColorPickDialog(
                                                containerColor: Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_bg_color"].toString())),
                                                keyNameClr: "hiw_bg_color",
                                                clrSwitchValue: "1",
                                                imgSwitchValue: "0",
                                                switchKeyNameImg: "hiw_bg_image_switch",
                                                switchKeyNameClr: "hiw_bg_color_switch",
                                              ));
                                            }, child: const Text("Color Picker")),
                                            const SizedBox(height: 20),
                                            ElevatedButton(onPressed: (){
                                              Get.dialog(ImgPickDialog(
                                                keyNameImg: "hiw_bg_image",
                                                switchKeyNameImg: "hiw_bg_image_switch",
                                                switchKeyNameClr: "hiw_bg_color_switch",
                                              ));
                                            }, child: const Text("Image Picker"))
                                          ],
                                        )
                                    ),

                                  );

                                },
                              );
                            },
                          child:Icon(Icons.colorize,color: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_bg_color"].toString()  != "4294967295"
                              ?AppColors.whiteColor:AppColors.blackColor),),
                      ],
                    )
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: Get.width * 0.45,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Expanded(child: SizedBox()),
                          Expanded(
                            // child: Text(
                            //   "How It Works",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     // fontSize: Get.width >1000 ?50:30,
                            //       fontSize: 24,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black),
                            // ),

                            child:   InkWell(
                              onTap: () => Get.dialog(
                                  TextEditModule(
                                    textKeyName: "hiw_title",
                                    colorKeyName: "hiw_title_color",
                                    fontFamilyKeyName: "hiw_title_font",
                                    textValue: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title"].toString(),
                                    fontFamily: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_font"].toString(),
                                    fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_size"].toString(),
                                    textColor: Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_color"].toString())),
                                  )),
                              child: Text(
                                editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title"].toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_font"].toString()).copyWith(
                                    fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_size"].toString() !=""
                                        ? double.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_size"].toString())
                                        : 24,
                                    fontWeight: FontWeight.bold,
                                    color: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_color"].toString().isEmpty
                                        ?AppColors.blackColor
                                        :Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_title_color"].toString()))),
                              ),
                            ),

                          ),
                          // const Expanded(child: SizedBox()),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // const Text(
                //   " ◉ All in one business site includes - website, Mobile Apps, AfterCore  & many more",
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.black),
                // ),
                InkWell(
                  onTap: () => Get.dialog(
                      TextEditModule(
                        textKeyName: "hiw_subtitle",
                        colorKeyName: "hiw_subtitle_color",
                        fontFamilyKeyName: "hiw_subtitle_font",
                        textValue: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle"].toString(),
                        fontFamily: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_font"].toString(),
                        fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_size"].toString(),
                        textColor: Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_color"].toString())),
                      )),
                  child: Text(
                    editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle"]
                        .toString(),
                    style: GoogleFonts.getFont(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_font"].toString()).copyWith(
                        fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_size"].toString() !=""
                            ? double.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_size"].toString())
                            : 20,
                        fontWeight: FontWeight.w600,
                        color: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_color"].toString().isEmpty
                            ?AppColors.blackColor
                            :Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_subtitle_color"].toString()))),
                  ),
                ),

                const SizedBox(height: 20),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 350,
                          width: 350,
                          decoration:  editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif"].toString().isEmpty
                              ? BoxDecoration()
                              : const BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                              child: buildBotWidget()
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Switch(
                                value: editHIWController.hiwGifShowSwitch.value,
                                onChanged: (value) {
                                  setState(() {
                                    editHIWController.hiwGifShowSwitch.value = value;
                                    log("value ---- $value");
                                    editController.showHideMedia(value: value == false?"hide":"show",keyName: "hiw_gif_show");
                                  });
                                },
                              ),
                              IconButton(
                                  onPressed: (){
                                    Get.dialog(UpdateMediaFunction(
                                      keyNameMedia: "hiw_gif",
                                      keyMediaType: "hiw_gif_mediatype",
                                    ));
                                  },
                                  icon: const Icon(Icons.edit)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    // const Text(
                    //   "Let me take you on a tour - How to Start - launch journey",
                    //   style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black),
                    // ),
                    InkWell(
                      onTap: () => Get.dialog(
                          TextEditModule(
                            textKeyName: "hiw_guide",
                            colorKeyName: "hiw_guide_color",
                            fontFamilyKeyName: "hiw_guide_font",
                            textValue: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide"].toString(),
                            fontFamily: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_font"].toString(),
                            fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_size"].toString(),
                            textColor: Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_color"].toString())),
                          )),
                      child: Text(
                        editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide"]
                            .toString(),
                        style: GoogleFonts.getFont(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_font"].toString()).copyWith(
                            fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_size"].toString() !=""
                                ? double.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_size"].toString())
                                : 20,
                            fontWeight: FontWeight.w600,
                            color: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_color"].toString().isEmpty
                                ?AppColors.blackColor
                                :Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_guide_color"].toString()))),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: const [
                //     Text(
                //       "❖ Choose your platform - a) Mobile App b) Mobile App & Website c) Website",
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black),
                //     ),
                //     SizedBox(height: 20),
                //     Text(
                //       "I) SignUp & tell \"Genesi\" about your business",
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black),
                //     ),
                //     SizedBox(height: 20),
                //     Text(
                //       "II) On preview page see dummy data for UI & its features. To ask admin, To user mode, Erase temporary data.",
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black),
                //     ),
                //     SizedBox(height: 20),
                //     Text(
                //       "III) Follow \"Genesi\" Tap & save, App gets created see there & then, speak to an expert for launch.",
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black),
                //     ),
                //   ],
                // ),
                InkWell(
                  onTap: () => Get.dialog(
                      TextEditModule(
                        textKeyName: "hiw_desc",
                        colorKeyName: "hiw_desc_color",
                        fontFamilyKeyName: "hiw_desc_font",
                        textValue: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc"].toString(),
                        fontFamily: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_font"].toString(),
                        fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_size"].toString(),
                        textColor: Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_color"].toString())),
                      )),
                  child: Text(
                    editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc"]
                        .toString(),
                    style: GoogleFonts.getFont(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_font"].toString()).copyWith(
                        fontSize: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_size"].toString() !=""
                            ? double.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_size"].toString())
                            : 20,
                        fontWeight: FontWeight.w600,
                        color: editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_color"].toString().isEmpty
                            ?AppColors.blackColor
                            :Color(int.parse(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_desc_color"].toString()))),
                  ),
                ),

                const SizedBox(height: 40),
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
                            btnColor:
                            Colors.redAccent.withOpacity(0.7),
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
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_red_eye_rounded),
                                const SizedBox(width: 8),
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
                        FittedBox(fit: BoxFit.scaleDown,
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
                              mainAxisAlignment:
                              MainAxisAlignment.center,
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

                    // commonIconButton(
                    //     icon: Icons.perm_phone_msg_sharp,
                    //     title: "Chat to our expert",
                    //     btnColor: Colors.blue.withOpacity(0.7),
                    //     txtColor: Colors.white),
                  ],
                ),

                ///recent purchases
                // const SizedBox(height: 40),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //     Text(
                //       "See Recent Purchases",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //           color: Colors.black,
                //           // fontSize: 40,
                //           fontSize: 24,
                //           fontWeight: FontWeight.w400),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 40),
                // SizedBox(
                //   height: 150,
                //   width: 450,
                //   // padding: EdgeInsets.symmetric(vertical: 50),
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       Positioned(
                //         // alignment: Alignment.center,
                //         left: 0, right: 0, top: 0, bottom: 0,
                //         child: CarouselSlider(
                //           carouselController:
                //               purchaseMemberCarouselController, // Give the controller
                //           options: CarouselOptions(
                //             viewportFraction: 1,
                //             autoPlayAnimationDuration:
                //                 const Duration(seconds: 1),
                //             autoPlay: true,
                //           ),
                //           items: purchaseHistory.map((featuredImage) {
                //             return Container(
                //               width: 380,
                //               decoration: BoxDecoration(
                //                   color:
                //                       Colors.black.withOpacity(0.2),
                //                   borderRadius:
                //                       const BorderRadius.all(
                //                           Radius.circular(20))),
                //               child: Center(
                //                 child: Text(
                //                   "${featuredImage["name"]} purchased ${featuredImage["plan"]}",
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //             );
                //           }).toList(),
                //         ),
                //       ),
                //       Positioned(
                //         left: 0,
                //         top: 0,
                //         bottom: 0,
                //         child: IconButton(
                //           onPressed: () {
                //             // Use the controller to change the current page
                //             carouselController.previousPage();
                //           },
                //           icon: const Icon(Icons.arrow_back),
                //         ),
                //       ),
                //       Positioned(
                //         right: 0,
                //         top: 0,
                //         bottom: 0,
                //         child: IconButton(
                //           onPressed: () {
                //             // Use the controller to change the current page
                //             carouselController.nextPage();
                //           },
                //           icon: const Icon(Icons.arrow_forward),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
        });
      },
    );
  }


      Widget buildBotWidget() {
    if (editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif"].toString(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }
    else if (editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
      return editHIWController.isBotVideoInitialized.value
            ? AspectRatio(
                 aspectRatio: editHIWController.botController.value.aspectRatio,
                 child: VideoPlayer(editHIWController.botController),
               )
            : const Center(child: CircularProgressIndicator());});
    }

    else if (editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif_mediatype"].toString().toLowerCase() == "gif") {
      if(editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif"].toString().toLowerCase().toString().endsWith(".mp4")){
        return Obx(() {
        return editHIWController.isBotVideoInitialized.value
            ? AspectRatio(
          aspectRatio: editHIWController.botController.value.aspectRatio,
          child: VideoPlayer(editHIWController.botController),
          // child:  Chewie(controller: editHIWController.botControllerChewie!),
        )
        // : const CircularProgressIndicator();
            : const Center(child: CircularProgressIndicator());});
      }
      else{
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif"].toString(),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }

    }
    else {
      return const Text("bot");
    }
  }


}
