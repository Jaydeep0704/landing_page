// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../../config/api_string.dart';
import '../../../../../widget/common_button.dart';
import '../../../edit_web_landing_page/edit_sections/edit_checkout_section/edit_checkoutController.dart';

class CheckoutSection extends StatefulWidget {
  const CheckoutSection({Key? key}) : super(key: key);

  @override
  State<CheckoutSection> createState() => _CheckoutSectionState();
}

class _CheckoutSectionState extends State<CheckoutSection> {

  final editController = Get.find<EditController>();
  final editCheckOutController = Get.find<EditCheckOutController>();
  WebLandingPageController webLandingPageController = Get.find<WebLandingPageController>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(()=>
        editController.checkout.value == false ||  editController.allDataResponse.isEmpty ?const SizedBox(): Container(
          // height: 700,
          // margin: const EdgeInsets.only(top: 40, bottom: 40),
          padding: EdgeInsets.only(
            left: Get.width > 1000
                ? Get.width * 0.1
                : Get.width > 650
                ? Get.width * 0.075
                : Get.width * 0.05,
            right: Get.width > 1000
                ? Get.width * 0.1
                : Get.width > 650
                ? Get.width * 0.075
                : Get.width * 0.05,
          ),
          decoration:  editController.allDataResponse[0]["checkout_details"][0]["checkout_bg_color_switch"].toString() == "1" &&
              editController.allDataResponse[0]["checkout_details"][0]["checkout_bg_image_switch"].toString() == "0"
              ? BoxDecoration(
            color: editController.allDataResponse[0]["checkout_details"][0]["checkout_bg_color"]
                .toString()
                .isEmpty
                ? Color(int.parse(
                editController.introBgColor.value.toString()))
                : Color(int.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_bg_color"]
                .toString())),
          )
              :BoxDecoration(
              image: DecorationImage(image: CachedNetworkImageProvider(
                APIString.mediaBaseUrl +
                    editController.allDataResponse[0]["checkout_details"][0]["checkout_bg_image"]
                        .toString(),
                errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
          ),
          width: Get.width,
          child: Column(
            children: [
              const SizedBox(height: 80),
              Get.width > 675
                  ?  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(

                        height: Get.width > 2200 ? Get.width * 0.25 :Get.width > 1600 ? Get.width * 0.33 :Get.width * 0.4,
                        width: Get.width > 2200 ? Get.width * 0.25 :Get.width > 1600 ? Get.width * 0.33 :Get.width * 0.4,
                        child: buildMediaWidget()

                    ),
                  ),

                  SizedBox(
                    width: Get.width * 0.1,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Changes in this section
                        Text(
                          editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline"]
                              .toString(),
                          style: GoogleFonts.getFont(editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_font"].toString()).copyWith(
                              fontSize: editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_size"].toString() !=""
                                  ? double.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_size"].toString())
                                  : Get.width > 1000
                                  ? 50
                                  : 30,
                              fontWeight: FontWeight.bold,
                              color: Color(int.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_color"].toString()))),

                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        // Text(
                        //   "The best-converting checkout on the planet",
                        //   style: AppTextStyle.regular700.copyWith(
                        //       fontSize: 32, color: AppColors.blackColor),
                        // ),


                        /// Changes in this section
                        Text(
                          editController.allDataResponse[0]["checkout_details"][0]["checkout_title"]
                              .toString(),
                          style: GoogleFonts.getFont(editController.allDataResponse[0]["checkout_details"][0]["checkout_title_font"].toString()).copyWith(
                              fontSize: editController.allDataResponse[0]["checkout_details"][0]["checkout_title_size"].toString() !=""
                                  ? double.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_title_size"].toString())
                                  : Get.width > 1000
                                  ? 50
                                  : 30,
                              fontWeight: FontWeight.bold,
                              color: Color(int.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_title_color"].toString()))),

                          // style: GoogleFonts.getFont(selectedFont).copyWith(
                          //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        /// Changes in this section
                        Text(
                          editController.allDataResponse[0]["checkout_details"][0]["checkout_description"]
                              .toString(),
                          style: GoogleFonts.getFont(editController.allDataResponse[0]["checkout_details"][0]["checkout_description_font"].toString()).copyWith(
                              fontSize: editController.allDataResponse[0]["checkout_details"][0]["checkout_description_size"].toString() !=""
                                  ? double.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_description_size"].toString())
                                  : Get.width > 1000
                                  ? 50
                                  : 30,
                              fontWeight: FontWeight.bold,
                              color: Color(int.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_description_color"].toString()))),

                          // style: GoogleFonts.getFont(selectedFont).copyWith(
                          //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: commonIconButton(
                                      onTap: appOpen,
                                      icon: Icons.phone_android,
                                      title: "Create Your App",
                                      btnColor:
                                      Colors.redAccent.withOpacity(0.7),
                                      txtColor: Colors.white),
                                )
                                ,
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.remove_red_eye_rounded),
                                      const SizedBox(width: 8),
                                      Obx(()=> webLandingPageController.appLiveCount.value.isEmpty?const SizedBox()
                                          : Text("${webLandingPageController.appLiveCount.value} people creating App")),                                            ],
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
                                      onTap: websiteOpen,
                                      icon: Icons.language,
                                      title: "Create Your Website",
                                      btnColor: Colors.green.withOpacity(0.7),
                                      txtColor: Colors.white),
                                )
                                ,
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.remove_red_eye_rounded),
                                      const SizedBox(width: 8),
                                      Obx(()=> webLandingPageController.webLiveCount.value.isEmpty?const SizedBox()
                                          : Text("${webLandingPageController.webLiveCount.value} people creating Website")),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  )
                ],
              )
                  :Column(
                children: [
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   "FAST, RELIABLE CHECKOUT",
                      //   style: AppTextStyle.regular400.copyWith(
                      //       fontSize: 14, color: AppColors.blackColor),
                      // ),
                      Text(
                        editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline"]
                            .toString(),
                        style: GoogleFonts.getFont(editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_font"].toString()).copyWith(
                            fontSize: editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_size"].toString() !=""
                                ? double.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_size"].toString())
                                : Get.width > 1000
                                ? 50
                                : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_tagline_color"].toString()))),

                        // style: GoogleFonts.getFont(selectedFont).copyWith(
                        //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // Text(
                      //   "The best-converting checkout on the planet",
                      //   style: AppTextStyle.regular700.copyWith(
                      //       fontSize: 22, color: AppColors.blackColor),
                      // ),
                      Text(
                        editController.allDataResponse[0]["checkout_details"][0]["checkout_title"]
                            .toString(),
                        style: GoogleFonts.getFont(editController.allDataResponse[0]["checkout_details"][0]["checkout_title_font"].toString()).copyWith(
                            fontSize: editController.allDataResponse[0]["checkout_details"][0]["checkout_title_size"].toString() !=""
                                ? double.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_title_size"].toString())
                                : Get.width > 1000
                                ? 50
                                : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_title_color"].toString()))),

                        // style: GoogleFonts.getFont(selectedFont).copyWith(
                        //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // Text(
                      //   "Back your business with Shop Pay—the one-click checkout that's built to convert.",
                      //   style: AppTextStyle.regular400.copyWith(
                      //       fontSize: 14, color: AppColors.blackColor),
                      // )

                      Text(
                        editController.allDataResponse[0]["checkout_details"][0]["checkout_description"]
                            .toString(),
                        style: GoogleFonts.getFont(editController.allDataResponse[0]["checkout_details"][0]["checkout_description_font"].toString()).copyWith(
                            fontSize: editController.allDataResponse[0]["checkout_details"][0]["checkout_description_size"].toString() !=""
                                ? double.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_description_size"].toString())
                                : Get.width > 1000
                                ? 50
                                : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse(editController.allDataResponse[0]["checkout_details"][0]["checkout_description_color"].toString()))),

                        // style: GoogleFonts.getFont(selectedFont).copyWith(
                        //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                        height: Get.width * 0.6,
                        width: Get.width * 0.6,
                        child: buildMediaWidget()

                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: WrapCrossAlignment.start,
                    // alignment: WrapAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Get.width > 400 ? commonIconButton(
                                onTap: appOpen,
                                icon: Icons.phone_android,
                                title: "Create Your App",
                                btnColor:
                                Colors.redAccent.withOpacity(0.7),
                                txtColor: Colors.white)
                      :commonIconButtonMedium(
                                onTap: appOpen,
                                icon: Icons.phone_android,
                                title: "Create Your App",
                                btnColor:
                                Colors.redAccent.withOpacity(0.7),
                                txtColor: Colors.white),
                          )
                          ,
                          SizedBox(
                            width: 250,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.remove_red_eye_rounded),
                                const SizedBox(width: 8),
                                Obx(()=> webLandingPageController.appLiveCount.value.isEmpty?const SizedBox()
                                    : Text("${webLandingPageController.appLiveCount.value} people creating App")),
                              ],
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
                            child: Get.width > 400 ? commonIconButton(
                                onTap: websiteOpen,
                                icon: Icons.language,
                                title: "Create Your Website",
                                btnColor: Colors.green.withOpacity(0.7),
                                txtColor: Colors.white)
                            :commonIconButtonMedium(
                                onTap: websiteOpen,
                                icon: Icons.language,
                                title: "Create Your Website",
                                btnColor: Colors.green.withOpacity(0.7),
                                txtColor: Colors.white),
                          ),
                          SizedBox(
                            width: 250,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.remove_red_eye_rounded),
                                const SizedBox(width: 8),
                                Obx(()=> webLandingPageController.webLiveCount.value.isEmpty?const SizedBox()
                                    : Text("${webLandingPageController.webLiveCount.value} people creating Website")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        );
      },
    );
  }
  Widget buildMediaWidget() {
    if (editController.allDataResponse[0]["checkout_details"][0]["checkout_file_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["checkout_details"][0]["checkout_file"].toString(),
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
            // decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)
        ),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );
      // return CachedNetworkImage(
      //   imageUrl: widget.introBotFile,
      //   placeholder: (context, url) => const CircularProgressIndicator(),
      //   errorWidget: (context, url, error) => const Icon(Icons.error),
      // );
    }
    else if (editController.allDataResponse[0]["checkout_details"][0]["checkout_file_mediatype"].toString().toLowerCase() == "video") {
      return Obx(() {
        return
          editCheckOutController.isCheckVideoInitialized.value
              ? AspectRatio(
            aspectRatio: editCheckOutController.checkVideoController.value.aspectRatio,
            child: VideoPlayer(editCheckOutController.checkVideoController),
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
    else if (editController.allDataResponse[0]["checkout_details"][0]["checkout_file_mediatype"].toString().toLowerCase() == "gif") {
      if(editController.allDataResponse[0]["checkout_details"][0]["checkout_file"].toString().toLowerCase().toString().endsWith(".mp4")){
        return editCheckOutController.isCheckVideoInitialized.value
            ? AspectRatio(
          aspectRatio: editCheckOutController.checkVideoController.value.aspectRatio,
          child: VideoPlayer(editCheckOutController.checkVideoController),
          // child:  Chewie(controller: mixBannerController.videoControllerChewie!),
        )
        // : const CircularProgressIndicator();
            : const Center(child: CircularProgressIndicator());
      }
      else{
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["checkout_details"][0]["checkout_file"].toString(),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        );
      }
      // return CachedNetworkImage(
      //   width: Get.width,
      //   imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file"].toString(),
      //   placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
      //   errorWidget: (context, url, error) =>
      //   const Icon(Icons.error),
      // );
      // return Image.network(APIString.mediaBaseUrl + editController.allDataResponse[0]["mix_banner_details"][0]["mix_banner_file"].toString());
    }
    else {
      return const Center(child: Text("bot"));
    }
  }
}



