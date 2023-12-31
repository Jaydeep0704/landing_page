import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/edit_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:video_player/video_player.dart';

import '../../../../../config/api_string.dart';
import '../../../edit_web_landing_page/edit_controller/edit_controller.dart';

class BenefitBannerSection extends StatefulWidget {
  const BenefitBannerSection({Key? key}) : super(key: key);

  @override
  State<BenefitBannerSection> createState() => _BenefitBannerSectionState();
}

class _BenefitBannerSectionState extends State<BenefitBannerSection> {
  WebLandingPageController webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final benefitBannerController = Get.find<BenefitBannerController>();
  List<bool>? bannerInfoReadMoreList ;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.benefitBanner.value == false ||  editController.allDataResponse.isEmpty ? const SizedBox() :
          Container(
            width: Get.width,
            decoration:editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_bg_color_switch"].toString() == "1" &&
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
            child: Get.width > 1000
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 20,
                  horizontal: Get.width > 1000 ? Get.width * 0.05 : 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///here need to change
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 80,),
                              Text(
                                editController
                                    .allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_title"]
                                    .toString(),
                                textAlign: TextAlign.center,
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
                              const SizedBox(height: 30),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    child: SizedBox(
                                        height:Get.width >1500 ? 700 :  550,
                                        width: Get.width >1500 ? 700 :  550,
                                        child: buildMediaWidget()
                                    ),
                                  ),

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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                      onTap: appOpen,
                                      icon: Icons.phone_android,
                                      margin: EdgeInsets.zero,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 5),
                                      fontSize: 12,
                                      title: "Create Your App",
                                      btnColor: Colors.redAccent.withOpacity(0.7),
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
                                      onTap: websiteOpen,
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
                          ],
                        ),
                        const SizedBox(height: 25),
                        Obx(() {
                          if (benefitBannerController.dataList.isNotEmpty) {
                            return
                              SizedBox(
                                  height: benefitBannerController.dataList.length <3?450:600,
                                  child:
                                  Scrollbar(
                                    controller: scrollController,
                                    child: ListView.builder(
                                      controller: scrollController,
                                      scrollDirection: Axis.vertical,
                                      itemCount: benefitBannerController.dataList.length,
                                      itemBuilder: (context, index) {
                                        var data = benefitBannerController.dataList[index];
                                        var boolValue = benefitBannerController.bannerInfoReadMore[index];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor: AppColors.blueColor
                                                        .withOpacity(0.1),
                                                    child: const Center(
                                                        child: Icon(
                                                          Icons.radio_button_checked_rounded,
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
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                  data["description"].toString(),
                                                  style: AppTextStyle.regular300
                                                      .copyWith(fontSize: 14),
                                                textAlign: TextAlign.start,
                                                maxLines: boolValue ? 10 : 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
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
                                            // SizedBox(height: Get.width * 0.02),
                                            const SizedBox(height: 10), Divider(
                                              thickness: 0.8,
                                              color: AppColors.blackColor.withOpacity(0.5),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
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
                  )
                ],
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///here need to change
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80,),

                            Text(
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
                            const SizedBox(height: 15),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                                  child: SizedBox(
                                      height: Get.width >450 ? 400 : null,
                                      width:  Get.width >450 ? 400 : null,
                                      child: buildMediaWidget()
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                commonIconButtonSmall(
                                    onTap: appOpen,
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
                                        .center,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                commonIconButtonSmall(
                                    onTap: websiteOpen,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Obx(() {
                    if (benefitBannerController.dataList.isNotEmpty) {
                      return
                        SizedBox(
                            // height: 400,
                            height: benefitBannerController.dataList.length < 3? 300:500,
                            width: Get.width > 650 ? 600: Get.width,
                            child:
                            Scrollbar(
                              controller: scrollController,
                              child: ListView.builder(
                                controller: scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: benefitBannerController.dataList.length,
                                reverse: false,
                                itemBuilder: (context, index) {
                                  var data = benefitBannerController.dataList[index];
                                  var boolValue = benefitBannerController.bannerInfoReadMore[index];
                                  return Container(
                                        width: Get.width > 650 ? 600: Get.width,
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                                radius: 10,
                                                backgroundColor: AppColors.blueColor.withOpacity(0.1),
                                                child: const Center(
                                                    child: Icon(
                                                      Icons.radio_button_checked_rounded,
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
                                        // SizedBox(height: Get.width * 0.02),
                                        const SizedBox(height: 10),
                                        Divider(
                                          thickness: 0.8,
                                          color: AppColors.blackColor.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
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
          );

        }  );
      },
    );

  }

  ///
  Widget buildMediaWidget() {
    if (editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file_mediatype"].toString().toLowerCase() == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + editController.allDataResponse[0]["benefit_banner_details"][0]["benefit_banner_file"].toString(),
        // fit: BoxFit.cover,
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Color(int.parse(editController.appDemoBgColor.value.toString())),)),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
      );

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


