// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:video_player/video_player.dart';

class DetailCaseStudyScreen extends StatefulWidget {
  var mainData;
  DetailCaseStudyScreen({Key? key,this.mainData}) : super(key: key);

  @override
  State<DetailCaseStudyScreen> createState() => _DetailCaseStudyScreenState();
}

class _DetailCaseStudyScreenState extends State<DetailCaseStudyScreen> {

  final detailCaseStudyController = Get.find<DetailCaseStudyController>();
  late VideoPlayerController mediaController ;
  bool mediaVideoLoaded = false ;

  initializeMedia() async {
    if (widget.mainData != null) {
      if (widget.mainData["mediaTypeKey"].toString().toLowerCase() == "video") {
        mediaController = VideoPlayerController.networkUrl(Uri.parse(APIString.latestmediaBaseUrl + widget.mainData["media"]));
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


  @override
  void initState() {
    super.initState();
    mediaVideoLoaded = false;
    detailCaseStudyController.getCaseStudyData(caseStudyAutoId: widget.mainData["case_study_auto_id"]);
    initializeMedia();
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
                width: Get.width-Get.width*0.2,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const SizedBox(height: 25),
                      InkWell(
                          onTap: () => Get.back(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.arrow_back_sharp,color: AppColors.blackColor,),
                                const SizedBox(width: 5),
                                Text("Go back",style: AppTextStyle.regular700.copyWith(fontSize: 16,),),
                              ],
                            ),
                          )),
                      const SizedBox(height: 25),
                      Get.width>825
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${widget.mainData["case_study_title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 55,color: AppColors.blackColor)),
                              const SizedBox(width: 15),
                              CachedNetworkImage(
                                height: 50,
                                width: 150,
                                fit: BoxFit.cover,
                                imageUrl: APIString.bannerMediaUrl +
                                    widget.mainData["case_study_image"].toString(),
                                placeholder: (context, url) =>
                                    Container(
                                      height: 50,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // const SizedBox(height: 40),

                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: AppColors.yellowColor.withOpacity(0.2),
                                                borderRadius: const BorderRadius.all(Radius.circular(15))
                                            ),
                                            child: Text("${widget.mainData["case_study_category"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Text("${widget.mainData["case_study_short_desciption"]}",style: AppTextStyle.regular500.copyWith(fontSize: 22,color: AppColors.blackColor)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 30),
                              mediaComponent(mediaType: widget.mainData["mediaTypeKey"],media: widget.mainData["media"])
                            ],
                          ),
                        ],
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.mainData["case_study_title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 55,color: AppColors.blackColor)),
                          const SizedBox(height: 10),
                          CachedNetworkImage(
                            height: 50,
                            width: 150,
                            fit: BoxFit.cover,
                            imageUrl: APIString.bannerMediaUrl +
                                widget.mainData["case_study_image"].toString(),
                            placeholder: (context, url) =>
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColors.yellowColor.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(Radius.circular(15))
                                  ),
                                  child: Text("${widget.mainData["case_study_category"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Align(
                            alignment: Alignment.center,
                            child: mediaComponent(mediaType: widget.mainData["mediaTypeKey"],media: widget.mainData["media"]),
                          ),
                          const SizedBox(height: 20),
                          Text("${widget.mainData["case_study_short_desciption"]}",

                              style: AppTextStyle.regular500.copyWith(fontSize: 22,color: AppColors.blackColor,height: 1.2)),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text("${widget.mainData["case_study_detail_desciption"]}",style: AppTextStyle.regular500.copyWith(fontSize: 22,color: AppColors.blackColor,height: 1.2)),

                      const SizedBox(height: 40),
                      Obx(() {
                        return detailCaseStudyController.caseStudyDetailsList.isEmpty
                            ? const SizedBox()
                            : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: detailCaseStudyController.caseStudyDetailsList.length,
                            itemBuilder: (context, index) {
                            var data = detailCaseStudyController.caseStudyDetailsList[index];
                             return Container(
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 25),
                              child: Get.width>825  ? Row(
                                children: [
                                  index.isEven ? const SizedBox():detailMediaComponent(media: data["media"].toString(),mediaType: data["mediaTypeKey"].toString()) ,
                                  index.isEven ? const SizedBox():const SizedBox(width: 25),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Get.width>825  ?const SizedBox() : const SizedBox(height: 15),
                                        Text("${data["title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 24,color: AppColors.blackColor,height: 1.1),),
                                        const SizedBox(height: 15),
                                        Text("${data["description"]}",style: AppTextStyle.regular300.copyWith(fontSize: 20,color: AppColors.blackColor,height: 1.1),),
                                      ],
                                    ),
                                  ),
                                  index.isOdd ? const SizedBox():const SizedBox(width: 25),
                                  index.isOdd ? const SizedBox():detailMediaComponent(media: data["media"].toString(),mediaType: data["mediaTypeKey"].toString()),

                                ],
                              )
                              :Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  detailMediaComponent(media: data["media"].toString(),mediaType: data["mediaTypeKey"].toString()) ,
                                  const SizedBox(height: 15),
                                  Text("${data["title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 24,color: AppColors.blackColor,height: 1.1),),
                                  const SizedBox(height: 15),
                                  Text("${data["description"]}",style: AppTextStyle.regular300.copyWith(fontSize: 20,color: AppColors.blackColor,height: 1.1),),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                      const SizedBox(height: 50),

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


  Widget displayUploadedVideo(String videoUrl,{bool? isCurrent}) {
    log("url : ---- > ${APIString.latestmediaBaseUrl+videoUrl}");
    // VideoPlayerController controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(APIString.latestmediaBaseUrl+videoUrl));
    controller.initialize().then((value) {
      controller.setLooping(true);
      /*if(isCurrent == true)*/controller.play();
    });

    return  InkWell(
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
                    height: Get.width>825 ?Get.width * 0.25: Get.width*0.6,
                    width: Get.width>825 ?Get.width * 0.35: Get.width*0.6,
                    decoration: const BoxDecoration(color: AppColors.whiteColor),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(controller),
                      ],
                    )
                ),
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

  detailMediaComponent({String? mediaType , String? media}){
    return Container(
      // width: 250,
      // height:250,
      height: Get.width>825 ?Get.width * 0.25: Get.width*0.6,
      width: Get.width>825 ?Get.width * 0.35: Get.width*0.6,
      // width: Get.width * 0.35,
      margin: const EdgeInsets.only(left: 5,right: 5,top: 70),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(20)),
            child: mediaType == "image" ||
                mediaType== "gif"
                ? CachedNetworkImage(
              height: Get.width>825 ?Get.width * 0.25: Get.width*0.6,
              width: Get.width>825 ?Get.width * 0.35: Get.width*0.6,
              imageUrl: APIString.latestmediaBaseUrl + media!,
              placeholder: (context, url) => Container(
                decoration: const BoxDecoration(color: AppColors.greyColor),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.fill,
            )
                : displayUploadedVideo(media!),
          ),
        ),
      ),
    );
  }


  mediaComponent({String? mediaType, String? media}){

    return Container(
      // width: Get.width > 1300 ?450: 350,
      // height: Get.width > 1300 ?450: 320,
      height: Get.width>825 ?Get.width * 0.25: Get.width*0.6,
      width: Get.width>825 ?Get.width * 0.35: Get.width*0.6,
      margin: const EdgeInsets.only(left: 5 ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(20)),
            child: mediaType == "image" ||
                mediaType== "gif"
                ? CachedNetworkImage(
              // height:  Get.width > 1300 ?450: 350,
              // width:  Get.width > 1300 ?450: 320,
              height: Get.width>825 ?Get.width * 0.25: Get.width*0.6,
              width: Get.width>825 ?Get.width * 0.35: Get.width*0.6,
                    imageUrl: APIString.latestmediaBaseUrl + media!,
                    placeholder: (context, url) => Container(
                      decoration: const BoxDecoration(color: AppColors.greyColor),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.fill,
                  )
                : mediaType == "video" && mediaVideoLoaded == false?const SizedBox(): VideoPlayer(mediaController),
          ),
        ),
      ),
    );
  }


}
