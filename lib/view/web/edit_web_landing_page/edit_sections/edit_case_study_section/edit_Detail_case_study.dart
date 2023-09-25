// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, non_constant_identifier_names, file_names

import 'dart:developer';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/add_update_detail_case_study.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:video_player/video_player.dart';

class EditDetailCaseStudyPage extends StatefulWidget {
  var shortDescription;
  EditDetailCaseStudyPage({Key? key, this.shortDescription}) : super(key: key);

  @override
  State<EditDetailCaseStudyPage> createState() =>
      _EditDetailCaseStudyPageState();
}

class _EditDetailCaseStudyPageState extends State<EditDetailCaseStudyPage> {
  final editPartnerController = Get.find<EditCaseStudyController>();

  final detailCaseStudyController = Get.find<DetailCaseStudyController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailCaseStudyController.getCaseStudyData(
        caseStudyAutoId: widget.shortDescription["case_study_auto_id"]);
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
                width: Get.width > 1200
                    ? 1100
                    : Get.width > 800
                        ? 700
                        : 400,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            // showPopup(isEdit: false, caseStudyAutoId: widget.shortDescription["case_study_auto_id"],);
                            Get.to(() => AddUpdateCaseStudyDetails(
                                      isEdit: false,
                                      caseStudyAutoId: widget.shortDescription[
                                          "case_study_auto_id"],
                                    ))!
                                .whenComplete(() =>
                                    detailCaseStudyController.getCaseStudyData(
                                        caseStudyAutoId:
                                            widget.shortDescription[
                                                "case_study_auto_id"]));
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.withOpacity(0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.add),
                                  SizedBox(width: 3),
                                  Text("Add New Data")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.shortDescription["case_study_title"]}",
                                    style: AppTextStyle.regularBold.copyWith(
                                        fontSize: 40,
                                        color: AppColors.blackColor)),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: AppColors.yellowColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: Text(
                                            "${widget.shortDescription["case_study_category"]}",
                                            style: AppTextStyle.regularBold
                                                .copyWith(
                                                    fontSize: 15,
                                                    color:
                                                        AppColors.blackColor))),
                                    const SizedBox(width: 20),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: AppColors.yellowColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: Text(
                                            "${widget.shortDescription["case_study_type"]}",
                                            style: AppTextStyle.regularBold
                                                .copyWith(
                                                    fontSize: 15,
                                                    color:
                                                        AppColors.blackColor))),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                    "${widget.shortDescription["case_study_short_desciption"]}",
                                    style: AppTextStyle.regular500.copyWith(
                                        fontSize: 30,
                                        color: AppColors.blackColor)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          CachedNetworkImage(
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                            imageUrl: APIString.bannerMediaUrl +
                                widget.shortDescription["case_study_image"]
                                    .toString(),
                            placeholder: (context, url) => Container(
                              height: 200,
                              width: 200,
                              decoration: const BoxDecoration(
                                color: AppColors.greyColor,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Obx(() {
                        return detailCaseStudyController
                                .caseStudyDetailsList.isEmpty
                            ? const Center(child: Text("No Data"))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: detailCaseStudyController
                                    .caseStudyDetailsList.length,
                                itemBuilder: (context, index) {
                                  var data = detailCaseStudyController
                                      .caseStudyDetailsList[index];
                                  return Container(
                                    width: Get.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                Get.to(() =>
                                                        AddUpdateCaseStudyDetails(
                                                          isEdit: true,
                                                          caseStudyAutoId: data[
                                                              "case_study_auto_id"],
                                                          media: data["media"],
                                                          mediaTypeKey: data[
                                                              "mediaTypeKey"],
                                                          caseStudyDetailsAutoId:
                                                              data["_id"],
                                                          title: data["title"],
                                                          description: data[
                                                              "description"],
                                                        ))!
                                                    .whenComplete(() =>
                                                        detailCaseStudyController
                                                            .getCaseStudyData(
                                                                caseStudyAutoId:
                                                                    widget.shortDescription[
                                                                        "case_study_auto_id"]));
                                              },
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .whiteColor
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Row(
                                                    children: const [
                                                      Icon(Icons.edit),
                                                      SizedBox(width: 3),
                                                      Text("Edit")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () async {
                                                detailCaseStudyController
                                                    .deleteCaseStudyData(
                                                  caseStudyAutoId: data[
                                                      "case_study_auto_id"],
                                                  caseStudyDetailsAutoId:
                                                      data["_id"],
                                                );
                                              },
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .whiteColor
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Row(
                                                    children: const [
                                                      Icon(Icons.delete),
                                                      SizedBox(width: 3),
                                                      Text("Delete")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            index.isEven
                                                ? const SizedBox()
                                                : mediaComponent(
                                                    media: data["media"]
                                                        .toString(),
                                                    mediaType:
                                                        data["mediaTypeKey"]
                                                            .toString()),
                                            index.isEven
                                                ? const SizedBox()
                                                : const SizedBox(width: 25),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 15),
                                                  Text(
                                                    "${data["title"]}",
                                                    style: AppTextStyle
                                                        .regularBold
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .blackColor),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Text(
                                                    "${data["description"]}",
                                                    style: AppTextStyle
                                                        .regular300
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .blackColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            index.isOdd
                                                ? const SizedBox()
                                                : const SizedBox(width: 25),
                                            index.isOdd
                                                ? const SizedBox()
                                                : mediaComponent(
                                                    media: data["media"]
                                                        .toString(),
                                                    mediaType:
                                                        data["mediaTypeKey"]
                                                            .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                      }),
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

  Widget displayUploadedVideo(String videoUrl, {bool? isCurrent}) {
    log("url : ---- > ${APIString.latestmediaBaseUrl + videoUrl}");
    // VideoPlayerController controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));
    controller.initialize().then((value) {
      controller.setLooping(true);
      if (isCurrent == true) controller.play();
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
                    height: 250,
                    width: 250,
                    decoration:
                        const BoxDecoration(color: AppColors.whiteColor),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(controller),
                        // Positioned(
                        //   bottom: 25,right: 25,
                        //   child: Obx(() =>  getLatestProject.isVideoPlaying.value == false
                        //       ?const Icon(
                        //     Icons.play_circle_fill,
                        //     size: 30,
                        //     color: Colors.black,)
                        //       :const Icon(
                        //     Icons.pause,
                        //     size: 30,
                        //     color: Colors.black,)),
                        // ),
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

  mediaComponent({String? mediaType, String? media}) {
    return Container(
      width: 250,
      height: 250,
      // height: 550,
      // height: 450,
      margin: const EdgeInsets.only(left: 5, right: 5, top: 70),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: mediaType == "image" || mediaType == "gif"
                ? CachedNetworkImage(
                    width: 250,
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
}
