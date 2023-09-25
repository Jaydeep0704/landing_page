// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/intro_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:video_player/video_player.dart';

class IntroSection extends StatefulWidget {
  const IntroSection({Key? key}) : super(key: key);

  @override
  State<IntroSection> createState() => _IntroSectionState();
}

class _IntroSectionState extends State<IntroSection> {
  final introSecController = Get.find<IntroSectionController>();
  final webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final editIntroController = Get.find<EditIntroController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.introComp.value == false || editController.allDataResponse.isEmpty&& editController.homeComponentList.isEmpty
              ? const SizedBox()
              : Container(
                          decoration: editController.allDataResponse[0]["intro_details"][0]["intro_bg_color_switch"].toString() == "1" &&
                              editController.allDataResponse[0]["intro_details"][0]["intro_bg_image_switch"].toString() == "0"
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
                              :BoxDecoration(
                            image: DecorationImage(image: CachedNetworkImageProvider( APIString.mediaBaseUrl +
                                editController.allDataResponse[0]["intro_details"]
                                [0]["intro_bg_image"]
                                    .toString(),
                            errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
                          ),
                          // height: Get.width > 1200 ?960:Get.width > 1000 ?875:Get.width > 800 ?800 :Get.width > 500 ?700:700,
                          width: Get.width,
                          child: Column(
                            children: [
                              const SizedBox(height: 25),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // height: 50,
                                      // width: 50,
                                      height: 60,
                                      width: 60,
                                      // margin: const EdgeInsets.symmetric(horizontal: 25),
                                      decoration: const BoxDecoration(
                                          // color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      // child: const Center(child: Text("logo")),
                                      child :  Center(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                                          child: CachedNetworkImage(
                                            width: Get.width,
                                            imageUrl: APIString.mediaBaseUrl +
                                                editController.allDataResponse[0]["intro_details"][0]["Logo_image"]
                                                    .toString(),
                                            placeholder: (context, url) => Container(
                                                decoration: BoxDecoration(
                                                  color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                                )),
                                            // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                            errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                          ),
                                        ),
                                      ),

                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Get.to(()=>const EditWebLandingScreen());
                                    //   },
                                    //   child: Container(
                                    //     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    //     decoration: BoxDecoration(
                                    //         border: Border.all(color: AppColors.blackColor),
                                    //         borderRadius: const BorderRadius.all(Radius.circular(8))
                                    //     ),
                                    //     child: Center(child: Text("Sign In",style: AppTextStyle.regular500.copyWith(fontSize: 20,color: AppColors.blackColor),),),
                                    //   ),
                                    // )
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
                                          horizontal: Get.width > 1500 ? 60 : Get.width > 1000 ? 22 :  15),
                                      child: Get.width > 1000
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child:    Text(
                                                    editController.allDataResponse[0]["intro_details"][0]["intro_main_title"]
                                                        .toString(),
                                                    style: GoogleFonts.getFont(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_font"].toString()).copyWith(
                                                        fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString() !=""
                                                            ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString())
                                                            : Get.width > 1000
                                                            ? 50
                                                            : 30,
                                                        fontWeight: FontWeight.bold,
                                                        color:  editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString() == ""
                                                            ?Colors.black
                                                            :Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString()))),
                                                  ),


                                                  // child: Text("Make Your Own Premium Ecommerce App & Website , AI easier way",
                                                  //   textAlign: TextAlign.center,
                                                  //   style: TextStyle(
                                                  //       // fontSize: 50,
                                                  //       fontSize: Get.width > 1000 ? 50 : 30,
                                                  //       fontWeight: FontWeight.bold,
                                                  //       color: Colors.black),
                                                  // ),
                                                ),

                                                const SizedBox(width: 20),
                                                editController.allDataResponse[0]["intro_details"][0]["intro_gif1_show"] == "hide"
                                                    ?const SizedBox(): Container(
                                                  // height: 150,
                                                  // width: 150,
                                                  height: 300,
                                                  width: 300,
                                                  decoration:

                                                      const BoxDecoration(
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
                                                const SizedBox(width: 40),
                                                Column(
                                                  children: [
                                                    // Text("${editController.allDataResponse[0]["intro_details"][0]["intro_bot_file"].toString().isEmpty}"),
                                                    editController.allDataResponse[0]["intro_details"][0]["intro_bot_file_show"] == "hide"
                                                    ?const SizedBox():SizedBox(
                                                      height: 120,
                                                      width: 120,
                                                      child:  Center(
                                                        child : buildBotWidget(),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    editController.allDataResponse[0]["intro_details"][0]["intro_gif2_show"] == "hide"
                                                        ?const SizedBox(): SizedBox(
                                                      height: 160,
                                                      width: 120,
                                                      child: Center(
                                                        child : buildGif2Widget(),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                // Text(
                                                //   "Make Your Own Premium Ecommerce App & Website , AI easier way",
                                                //   style: TextStyle(
                                                //       // fontSize: 50,
                                                //       fontSize: Get.width > 1000
                                                //           ? 50
                                                //           : 30,
                                                //       fontWeight:
                                                //           FontWeight.bold,
                                                //       color: Colors.black),
                                                // ),
                                                Text(
                                                  editController.allDataResponse[0]["intro_details"][0]["intro_main_title"]
                                                      .toString(),
                                                  style: GoogleFonts.getFont(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_font"].toString()).copyWith(
                                                      fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString() !=""
                                                          ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString())
                                                          : Get.width > 1000
                                                          ? 50
                                                          : 30,
                                                      fontWeight: FontWeight.bold,
                                                      color:  editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString() == ""
                                                          ?Colors.black
                                                          :Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString()))),
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    editController.allDataResponse[0]["intro_details"][0]["intro_gif1_show"] == "hide"
                                                        ?const SizedBox():  Container(
                                                      height: Get.width > 500 ? 300 : Get.width > 425 ?250:175,
                                                      width: Get.width > 500 ? 300 : Get.width > 425 ?250:175,
                                                      decoration:  const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(Radius.circular(5))),
                                                      child: Center(
                                                          child: buildGif1Widget()
                                                      ),
                                                    ),
                                                    const SizedBox(width: 40),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        editController.allDataResponse[0]["intro_details"][0]["intro_bot_file_show"] == "hide"
                                                            ?const SizedBox(): SizedBox(
                                                          height: Get.width > 500 ? 120 :Get.width > 425 ? 100 : 75,
                                                          width: Get.width > 500 ? 120 :Get.width > 425 ? 100 : 75,
                                                          child:  Center(
                                                            child : buildBotWidget(),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        editController.allDataResponse[0]["intro_details"][0]["intro_gif2_show"] == "hide"
                                                            ?const SizedBox():  SizedBox(
                                                          height: Get.width > 500 ? 160 : Get.width > 425 ? 120 : 90,
                                                          width: Get.width > 500 ? 120 :Get.width > 425 ? 100 : 75,
                                                          child: Center(
                                                            // child: Text("gif"),
                                                            child : buildGif2Widget(),
                                                          ),
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
                                            height: Get.width > 1500 ? 75 : Get.width > 800 ? 60 : Get.width > 500 ? 50 : 40),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // const Expanded(child: SizedBox()),
                                        SizedBox(
                                          width: Get.width > 1500
                                              ? Get.width * 0.4
                                              : Get.width > 1000
                                                  ? Get.width * 0.5
                                                  : Get.width * 0.6,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                              decoration : BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                  color:  editController.allDataResponse[0]["intro_details"][0]["intro_desc_bg"] == "hide"
                                                      ? AppColors.transparentColor
                                                      : Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_desc_bg_color"].toString()))),
                                              child: Text(
                                                editController.allDataResponse[0]["intro_details"][0]["intro_desc"]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.getFont(editController.allDataResponse[0]["intro_details"][0]["intro_desc_font"].toString()).copyWith(
                                                    fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_desc_size"].toString() ==""
                                                        ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_desc_size"].toString())
                                                        : 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_desc_color"].toString()))),

                                                // style: GoogleFonts.getFont(selectedFont).copyWith(
                                                //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // const Expanded(child: SizedBox()),
                                      ],
                                    ),
                                    Get.width > 1049
                                        ? const SizedBox()
                                        : const SizedBox(height: 40),
                                    Wrap(
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
                                            commonIconButton(
                                                onTap: () async {
                                                  const url = AppString.playStoreAppLink;
                                                  if (await canLaunchUrl(Uri.parse(url))) {
                                                    await launchUrl(Uri.parse(url));
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },

                                                icon: Icons.phone_android,
                                                title: "Create Your App",
                                                btnColor: Colors.redAccent
                                                    .withOpacity(0.7),
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
                                                    const Icon(Icons
                                                        .remove_red_eye_rounded),
                                                    const SizedBox(width: 8),
                                                    Row(
                                                      children: [
                                                        Obx(() => Text("${webLandingPageController.appLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                                            fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                                ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                                : 14,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))))),
                                                       Text(
                                                            editController.allDataResponse[0]["live_app_count_string"].toString(),
                                                            style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                                                // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                                //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                                //     : 14,
                                                                // fontWeight: FontWeight.w400,
                                                                color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            commonIconButton(
                                                onTap: () async {
                                                  const url = AppString.websiteLink;
                                                  if (await canLaunchUrl(Uri.parse(url))) {
                                                    await launchUrl(Uri.parse(url));
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                icon: Icons.language,
                                                title: "Create Your Website",
                                                btnColor: Colors.green
                                                    .withOpacity(0.7),
                                                txtColor: Colors.white),
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
                                                    const Icon(Icons
                                                        .remove_red_eye_rounded),
                                                    const SizedBox(width: 8),
                                                    // Obx(() => Text(
                                                    //     "${webLandingPageController.webLiveCount.value} people creating Website")),
                                                    Row(
                                                      children: [
                                                        Obx(() => Text("${webLandingPageController.webLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                                            // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                                            //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                                            //     : 14,
                                                            // fontWeight: FontWeight.w400,
                                                            color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),)),
                                                        // Obx(() => Text(" people creating App")),
                                                        Text(
                                                          editController.allDataResponse[0]["live_web_count_string"].toString(),
                                                          style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                                              // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                                              //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                                              //     : 14,
                                                              // fontWeight: FontWeight.w400,
                                                              color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),
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
                                        //     btnColor:
                                        //         Colors.blue.withOpacity(0.7),
                                        //     txtColor: Colors.white),
                                      ],
                                    ),
                                    // const SizedBox(height: 40),
                                    // // const Text("Currently App Build in Process for 30k Customers"),
                                    // // const Text("30k people active now & creating app"),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: const [
                                    //     Icon(Icons.people),
                                    //     SizedBox(width: 5),
                                    //     Text("30k people active now & creating app"),
                                    //   ],
                                    // ),
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


  Widget buildBotWidget() {

    if (editController.allDataResponse[0]["intro_details"][0]["intro_bot_file_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["intro_details"][0]["intro_bot_file"].toString(),
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }
    else if (editController.allDataResponse[0]["intro_details"][0]["intro_bot_file_mediatype"].toString().toLowerCase() == "video") {

      return Obx(() {
        return editIntroController.isBotVideoInitialized.value
            ? AspectRatio(
               // aspectRatio: editIntroController.introBotController.value.aspectRatio,
               aspectRatio: 1,
               child: VideoPlayer(editIntroController.introBotController),
             )
            : const Center(child: CircularProgressIndicator());

      });
    }
    else if (editController.allDataResponse[0]["intro_details"][0]["intro_bot_file_mediatype"].toString().toLowerCase() == "gif") {
      if(editController.allDataResponse[0]["intro_details"][0]["intro_bot_file"].toString().toLowerCase().toString().endsWith(".mp4")){
        return editIntroController.isBotVideoInitialized.value
            ? AspectRatio(
               aspectRatio: editIntroController.introBotController.value.aspectRatio,
               child: VideoPlayer(editIntroController.introBotController),
              )
            : const Center(child: CircularProgressIndicator());
      }
      else{
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["intro_details"][0]["intro_bot_file"].toString(),
          fit: BoxFit.fill,
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

  Widget buildGif1Widget() {
    if (editController.allDataResponse[0]["intro_details"][0]["intro_gif1_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["intro_details"][0]["intro_gif1"].toString(),
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }

    else if (editController.allDataResponse[0]["intro_details"][0]["intro_gif1_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
        return editIntroController.isIntroGif1Initialized.value
              ? AspectRatio(
                aspectRatio: editIntroController.introGif1Controller.value.aspectRatio,
                child: VideoPlayer(editIntroController.introGif1Controller),
              )
              : const Center(child: CircularProgressIndicator());

      });
    }
    else if (editController.allDataResponse[0]["intro_details"][0]["intro_gif1_mediatype"].toString().toLowerCase() == "gif") {
      if(editController.allDataResponse[0]["intro_details"][0]["intro_gif1"].toString().toLowerCase().toString().endsWith(".mp4")){
        return editIntroController.isIntroGif1Initialized.value
            ? AspectRatio(
          aspectRatio: editIntroController.introGif1Controller.value.aspectRatio,
          child: VideoPlayer(editIntroController.introGif1Controller),
          // child:  Chewie(controller: editIntroController.introBotControllerChewie!),
        )
            : const Center(child: CircularProgressIndicator());
      }
      else{
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["intro_details"][0]["intro_gif1"].toString(),
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }
    }
    else {
      return const Text("gif");
    }
  }

  Widget buildGif2Widget() {
    if (editController.allDataResponse[0]["intro_details"][0]["intro_gif2_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["intro_details"][0]["intro_gif2"].toString(),
        fit: BoxFit.fill,
        // fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );

    }

    else if (editController.allDataResponse[0]["intro_details"][0]["intro_gif2_mediatype"].toString().toLowerCase() == "video") {
      // return displayUploadedVideo(editController.allDataResponse[0]["intro_details"][0]["intro_gif2"].toString());
      return Obx(() {
        return
          editIntroController.isIntroGif2Initialized.value
              ? AspectRatio(
            aspectRatio: editIntroController.introGif2Controller.value.aspectRatio,
            child: VideoPlayer(editIntroController.introGif2Controller),
          )
              : const Center(child: CircularProgressIndicator());});
    }
    else if (editController.allDataResponse[0]["intro_details"][0]["intro_gif2_mediatype"].toString().toLowerCase() == "gif") {
      if(editController.allDataResponse[0]["intro_details"][0]["intro_gif2"].toString().toLowerCase().toString().endsWith(".mp4")){
        return editIntroController.isIntroGif2Initialized.value
            ? AspectRatio(
          aspectRatio: editIntroController.introGif2Controller.value.aspectRatio,
          child: VideoPlayer(editIntroController.introGif2Controller),
          // child:  Chewie(controller: editIntroController.introBotControllerChewie!),
        )
            : const Center(child: CircularProgressIndicator());
      }
      else{
        return CachedNetworkImage(
          imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["intro_details"][0]["intro_gif2"].toString(),
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }
    }
    else {
      return const Text("gif");
    }
  }

}

