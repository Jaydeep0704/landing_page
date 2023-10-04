// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/related_case_studies/types/cs_category_controller.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';
import 'package:video_player/video_player.dart';

class DetailCaseStudyScreen extends StatefulWidget {
  var mainData;
  DetailCaseStudyScreen({Key? key, this.mainData}) : super(key: key);

  @override
  State<DetailCaseStudyScreen> createState() => _DetailCaseStudyScreenState();
}

class _DetailCaseStudyScreenState extends State<DetailCaseStudyScreen> {
  final detailCaseStudyController = Get.find<DetailCaseStudyController>();
  final csCategoriesController = Get.find<CSCategoriesController>();
  final editController = Get.find<EditController>();
  late VideoPlayerController mediaController;
  bool mediaVideoLoaded = false;
  final ScrollController _scrollController = ScrollController();

  initializeMedia() async {
    if (widget.mainData != null) {
      if (widget.mainData["mediaTypeKey"].toString().isNotEmpty &&
          widget.mainData["media"].toString().isNotEmpty) {
        if (widget.mainData["mediaTypeKey"].toString().toLowerCase() ==
            "video") {
          mediaController = VideoPlayerController.networkUrl(Uri.parse(
              APIString.latestmediaBaseUrl + widget.mainData["media"]));
          await mediaController.initialize().whenComplete(
            () {
              log("data ------->    1");
              mediaController.setLooping(true);
              log("data ------->    2");
              mediaController.setVolume(0);
              log("data ------->    3");
              mediaVideoLoaded = true;
              log("data ------->    4");
              mediaController.play();
              log("data ------->    5");
              setState(() {});
              log("data ------->    6");
            },
          );
        } else {
          mediaVideoLoaded = false;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    mediaVideoLoaded = false;
    detailCaseStudyController.getCaseStudyData(
        caseStudyAutoId: widget.mainData["case_study_auto_id"]);
    initializeMedia();
    getRelatedData();
    KeyboardScroll.addScrollListener(_scrollController);
  }

  @override
  void dispose() {
    KeyboardScroll.removeScrollListener();
    _scrollController.dispose();
    super.dispose();
  }

  getRelatedData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      csCategoriesController.getRelatedCaseStudies(
        // case_study_id: case_study_auto_id,
        case_study_id: widget.mainData["case_study_auto_id"],
        // case_study_type: case_study_type,
        case_study_type: widget.mainData["case_study_type"],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Row(
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                // width: Get.width > 1200 ? 1100 : Get.width > 800 ? 700 : /*400*/Get.width-40,
                width: Get.width - Get.width * 0.2,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      caseStudyDetails(),
                      const SizedBox(width: 13),
                      const Divider(
                        color: AppColors.greyBorderColor,
                        thickness: 0.5,
                      ),
                      const SizedBox(width: 13),
                      relatedCaseStudy(),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },
    );
  }

  Column caseStudyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        InkWell(
            onTap: () => Get.back(),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Go back",
                    style: AppTextStyle.regular700.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Text(
                    "${widget.mainData["case_study_type"]}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: AppColors.whiteColor,
                    ),
                  ),
                )),
            const SizedBox(height: /* Get.width > 950 ? 0 :*/ 10),
            /*Get.width > 950 ? const SizedBox() : */ logo(),
            SizedBox(height: Get.width > 950 ? 25 : 10),
            Text("${widget.mainData["case_study_title"]}",
                style: AppTextStyle.regularBold.copyWith(
                    fontSize: Get.width > 950
                        ? 30
                        : Get.width > 650
                            ? 25
                            : 20,
                    color: AppColors.blackColor)),
            widget.mainData["case_study_detail_desciption"].toString().isEmpty
                ? const SizedBox()
                : const SizedBox(height: 25),
            widget.mainData["case_study_detail_desciption"].toString().isEmpty
                ? const SizedBox()
                : Text(
                    "${widget.mainData["case_study_detail_desciption"]}",
                    style: TextStyle(
                      fontSize: Get.width > 550 ? 24 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
            widget.mainData["case_study_detail_desciption"].toString().isEmpty
                ? const SizedBox()
                : const SizedBox(height: 8),
            widget.mainData["case_study_detail_desciption"].toString().isEmpty
                ? const SizedBox()
                : const Text(
                    "~ Author",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
            SizedBox(
                height: widget.mainData["mediaTypeKey"].toString().isEmpty &&
                        widget.mainData["media"].toString().isEmpty
                    ? 0
                    : 25),
            widget.mainData["mediaTypeKey"].toString().isEmpty &&
                    widget.mainData["media"].toString().isEmpty
                ? const SizedBox()
                : mediaComponent(
                    mediaType: widget.mainData["mediaTypeKey"],
                    media: widget.mainData["media"]),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text("${widget.mainData["case_study_short_desciption"]}",
                  style: AppTextStyle.regular500.copyWith(
                      fontSize: Get.width > 550 ? 22 : 18,
                      color: AppColors.blackColor)),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Obx(() {
          return detailCaseStudyController.caseStudyDetailsList.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      detailCaseStudyController.caseStudyDetailsList.length,
                  itemBuilder: (context, index) {
                    var data =
                        detailCaseStudyController.caseStudyDetailsList[index];
                    return Container(
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Get.width > 825
                          ? Row(
                              children: [
                                index.isEven
                                    ? const SizedBox()
                                    : detailMediaComponent(
                                        media: data["media"].toString(),
                                        mediaType:
                                            data["mediaTypeKey"].toString()),
                                index.isEven
                                    ? const SizedBox()
                                    : const SizedBox(width: 25),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Get.width > 825
                                          ? const SizedBox()
                                          : const SizedBox(height: 15),
                                      Text(
                                        "${data["title"]}",
                                        style: AppTextStyle.regularBold
                                            .copyWith(
                                                fontSize:
                                                    Get.width > 550 ? 24 : 20,
                                                color: AppColors.blackColor,
                                                height: 1.1),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "${data["description"]}",
                                        style: AppTextStyle.regular300.copyWith(
                                            fontSize: Get.width > 550 ? 20 : 16,
                                            color: AppColors.blackColor,
                                            height: 1.1),
                                      ),
                                    ],
                                  ),
                                ),
                                index.isOdd
                                    ? const SizedBox()
                                    : const SizedBox(width: 25),
                                index.isOdd
                                    ? const SizedBox()
                                    : detailMediaComponent(
                                        media: data["media"].toString(),
                                        mediaType:
                                            data["mediaTypeKey"].toString()),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                detailMediaComponent(
                                    media: data["media"].toString(),
                                    mediaType: data["mediaTypeKey"].toString()),
                                const SizedBox(height: 15),
                                Text(
                                  "${data["title"]}",
                                  style: AppTextStyle.regularBold.copyWith(
                                      fontSize: 24,
                                      color: AppColors.blackColor,
                                      height: 1.1),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "${data["description"]}",
                                  style: AppTextStyle.regular300.copyWith(
                                      fontSize: 20,
                                      color: AppColors.blackColor,
                                      height: 1.1),
                                ),
                              ],
                            ),
                    );
                  },
                );
        }),
        const SizedBox(height: 50),
      ],
    );
  }

  CachedNetworkImage logo() {
    return CachedNetworkImage(
      height: 50,
      width: 80,
      fit: BoxFit.cover,
      imageUrl: APIString.bannerMediaUrl +
          widget.mainData["case_study_image"].toString(),
      placeholder: (context, url) => Container(
        height: 50,
        width: 80,
        decoration: const BoxDecoration(
          color: AppColors.greyColor,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Container relatedCaseStudy() {
    return Container(
      // width: 400,
      margin: const EdgeInsets.only(top: 80, bottom: 40),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
      height: /*Get.width > 1000 ? Get.height * 1.31 : */ 495,
      decoration: BoxDecoration(color: AppColors.blackColor.withOpacity(0.05)),
      child: Obx(() {
        return csCategoriesController.relatedCaseStudies.isEmpty
            ? const SizedBox()
            : Column(
                mainAxisAlignment: /*Get.width > 1000
                    ? MainAxisAlignment.start
                    : */
                    MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Related Case Studies",
                      style: AppTextStyle.regular800.copyWith(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 400,
                    width: null,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      scrollDirection: /*Get.width > 1000 ? Axis.vertical :*/
                          Axis.horizontal,
                      itemCount:
                          csCategoriesController.relatedCaseStudies.length,
                      itemBuilder: (context, index) {
                        var data =
                            csCategoriesController.relatedCaseStudies[index];
                        return Container(
                          width: Get.width > 375 ? 350 : Get.width * 0.85,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                            color: AppColors
                                .whiteColor, /* border: Border.all(color: AppColors.blackColor)*/
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: Get.width > 375 ? 350 : Get.width * 0.85,
                                decoration: const BoxDecoration(
                                  // border: Border.all(color: AppColors.blackColor,width: 1),
                                  border: Border(
                                      right: BorderSide(
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
                                  // fit: BoxFit.cover,
                                  imageUrl: APIString.bannerMediaUrl +
                                      data["case_study_image"].toString(),
                                  placeholder: (context, url) => Container(
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
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.blackColor,
                                          width: 1.5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.lightBlueColor,
                                              border: Border.all(
                                                  color: AppColors.blueColor,
                                                  width: 0.8),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                          child: Text(
                                            "${data["case_study_type"]}",
                                            style: AppTextStyle.regularBold
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: AppColors.blueColor),
                                          )),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${data["case_study_title"]}",
                                        style: AppTextStyle.regularBold
                                            .copyWith(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${data["case_study_short_desciption"]}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 7,
                                        style: AppTextStyle.regular300
                                            .copyWith(fontSize: 14),
                                      ),
                                      const SizedBox(height: 10),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(() => DetailCaseStudyScreen(mainData: data));
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return DetailCaseStudyScreen(
                                                      mainData: data);
                                                },
                                              ));
                                            },
                                            child: Container(
                                              width: 175,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: AppColors.greenColor
                                                      .withOpacity(0.5)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              child: Center(
                                                  child: Text(
                                                "Read the case study",
                                                style: AppTextStyle.regular900,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Widget displayUploadedVideo(String videoUrl, {bool? isCurrent}) {
    log("url : ---- > ${APIString.latestmediaBaseUrl + videoUrl}");
    // VideoPlayerController controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));
    controller.initialize().then((value) {
      controller.setLooping(true);
      /*if(isCurrent == true)*/ controller.play();
    });

    return InkWell(
      // onTap: () {
      //   if (controller.value.isPlaying) {
      //     getLatestProject.isVideoPlaying.value = false;
      //     controller.pause();
      //   } else {
      //     getLatestProject.isVideoPlaying.value = true;
      //     controller.play();
      //   }
      // },
      child: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                    height:
                        Get.width > 825 ? Get.width * 0.25 : Get.width * 0.6,
                    width: Get.width > 825 ? Get.width * 0.35 : Get.width * 0.6,
                    decoration:
                        const BoxDecoration(color: AppColors.whiteColor),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(controller),
                      ],
                    )),
              ),
            );
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

  detailMediaComponent({String? mediaType, String? media}) {
    return Container(
      // width: 250,
      // height:250,
      height: Get.width > 825 ? Get.width * 0.25 : Get.width * 0.6,
      width: Get.width > 825 ? Get.width * 0.35 : Get.width * 0.6,
      // width: Get.width * 0.35,
      margin: const EdgeInsets.only(left: 5, right: 5, top: 70),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: mediaType == "image" || mediaType == "gif"
                ? CachedNetworkImage(
                    height:
                        Get.width > 825 ? Get.width * 0.25 : Get.width * 0.6,
                    width: Get.width > 825 ? Get.width * 0.35 : Get.width * 0.6,
                    imageUrl: APIString.latestmediaBaseUrl + media!,
                    placeholder: (context, url) => Container(
                      decoration:
                          const BoxDecoration(color: AppColors.greyColor),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.fill,
                  )
                : displayUploadedVideo(media!),
          ),
        ),
      ),
    );
  }

  mediaComponent({String? mediaType, String? media}) {
    return Container(
      height: 300,
      width: Get.width,
      margin: const EdgeInsets.only(left: 5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: mediaType == "image" || mediaType == "gif"
                ? CachedNetworkImage(
                    height: 350,
                    width: Get.width > 850 ? 750 : Get.width,
                    imageUrl: APIString.latestmediaBaseUrl + media!,
                    placeholder: (context, url) => Container(
                      decoration:
                          const BoxDecoration(color: AppColors.greyColor),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.fill,
                  )
                : mediaType == "video" && mediaVideoLoaded == false
                    ? const SizedBox()
                    : VideoPlayer(mediaController),
          ),
        ),
      ),
    );
  }
}
