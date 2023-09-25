// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class MixBannerSection extends StatefulWidget {
  const MixBannerSection({Key? key}) : super(key: key);

  @override
  State<MixBannerSection> createState() => _MixBannerSectionState();
}

class _MixBannerSectionState extends State<MixBannerSection> {
  WebLandingPageController webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final mixBannerController = Get.find<MixBannerController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.mixBanner.value == false ||  editController.allDataResponse.isEmpty ?const SizedBox():
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
            padding: editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_show"] == "hide"
                ?const EdgeInsets.symmetric(vertical: 0): const EdgeInsets.symmetric(vertical: 100),
            // child: Get.width > 980
            child: Get.width > 1020
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_show"] == "hide"
                    ?const SizedBox():
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                            height: Get.width > 1100 ?550: 450,
                            width:  Get.width > 1100 ?550: 450,
                            child : buildMediaWidget()
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
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
                      const SizedBox(height: 10),

                      Text(
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
                      const SizedBox(height: 10),
                      SizedBox(
                        width: Get.width * 0.3,
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
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
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
                                      Row(
                                        children: [
                                          Obx(() => Text("${webLandingPageController.appLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                            // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                            //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                            //     : 14,
                                            // fontWeight: FontWeight.w400,
                                              color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))))),
                                          // Obx(() => Text(" people creating App")),
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
                          const SizedBox(height: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_show"] == "hide"
                    ? const SizedBox()
                    : Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                          height: Get.width > 600 ?400: 300,
                          width:  Get.width > 600 ?400: 300,
                          child : buildMediaWidget()
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
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
                    const SizedBox(height: 10),
                    Text(
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
                    const SizedBox(height: 10),
                    Center(
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
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
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

                              icon: Icons.phone_android,
                              title: "Create Your App",
                              btnColor: Colors.redAccent.withOpacity(0.7),
                              txtColor: Colors.white),
                        ),
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
                                Row(
                                  children: [
                                    Obx(() => Text("${webLandingPageController.appLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                      // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                      //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                      //     : 14,
                                      // fontWeight: FontWeight.w400,
                                        color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))))),
                                    // Obx(() => Text(" people creating App")),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
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
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget buildMediaWidget() {
    if ( editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "image" ||
        editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "gif") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file"].toString(),
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
    else if (editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
        return
          mixBannerController.isVideoInitialized.value
              ? AspectRatio(
            aspectRatio: mixBannerController.videoController.value.aspectRatio,
            child: VideoPlayer(mixBannerController.videoController),
          )
          // : const CircularProgressIndicator();
              : const Center(child: CircularProgressIndicator());});
    }
    // else if (editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "video") {
    //   return mixBannerController.isVideoInitialized.value
    //       ? AspectRatio(
    //     aspectRatio: mixBannerController.videoController!.value.aspectRatio,
    //     // child: VideoPlayer(mixBannerController.videoController!),
    //     child:  Chewie(controller: mixBannerController.videoControllerChewie!),
    //   )
    //   // : const CircularProgressIndicator();
    //       : const Center(child: CircularProgressIndicator());
    // }
    else if (editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"].toString().toLowerCase() == "gif") {
      return CachedNetworkImage(
        // width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file"].toString(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
    }
    else {
      return const Center(child: Text("bot"));
    }
  }


}

