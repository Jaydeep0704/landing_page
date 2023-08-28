import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:video_player/video_player.dart';

import '../view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'blog_controller.dart';

class BlogDetailsScreen extends StatefulWidget {
  final String id;
  final String name;
  final String title;
  final String content;
  final String blogType;
  final String bgColor;
  final String media;
  final String profileImg;
  final String mediaType;
  final List<Map<String, String>> blogDetails;
  const BlogDetailsScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.bgColor,
    required this.content,
    required this.title,
    required this.blogType,
    required this.profileImg,
    required this.mediaType,
    required this.media,
    required this.blogDetails,
  }) : super(key: key);

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  final editBlogController = Get.find<EditBlogController>();
  final detailCaseStudyController = Get.find<DetailCaseStudyController>();
  final editController = Get.find<EditController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      editBlogController.getBlogDetailsData(id: widget.id);
    });
    initializeVideo();

  }

  @override
  void dispose() {
    if(widget.mediaType == "video"){
      editBlogController.videoController.pause();
      editBlogController.videoController.dispose();
    }

    super.dispose();
  }

  void initializeVideo() async {
    if (widget.mediaType == "video") {

    editBlogController.videoController = VideoPlayerController.networkUrl(
        Uri.parse(APIString.mediaBaseUrl + widget.media));
    await editBlogController.videoController.initialize().whenComplete(() {
      editBlogController.videoController.setLooping(true);
      editBlogController.videoController.setVolume(0);
      editBlogController.isVideoInitialized.value = true;
      editBlogController.videoController.play();
      setState(() {});
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(color: AppColors.whiteColor, boxShadow: [
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.0),
                    blurRadius: 1,
                    spreadRadius: 2)
              ]),
              width: Get.width > 1200
                  ? 1100
                  : Get.width > 1000
                      ? 900
                      : Get.width > 800
                      ? 700
                      : Get.width > 600
                      ? 550
                      : Get.width-40,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Row(
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
                    ),
                    const SizedBox(height: 30),
                    //blogType
                    Container(
                        decoration: BoxDecoration(
                            color: AppColors.lightBlueColor,
                            border: Border.all(
                                color: AppColors.blueColor, width: 0.8),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Text(
                            widget.blogType,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                              color: AppColors.blueColor,
                            ),
                          ),
                        )),
                    const SizedBox(height: 20),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: CachedNetworkImage(
                                imageUrl: APIString.latestmediaBaseUrl +
                                    widget.profileImg,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(editController
                                        .appDemoBgColor.value
                                        .toString())),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      width: Get.width,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          child: widget.mediaType == "image" ||
                                  widget.mediaType == "gif"
                              ? CachedNetworkImage(
                                  imageUrl: APIString.latestmediaBaseUrl +
                                      widget.media,
                                  fit: BoxFit.fill,
                                  height: 300,
                                  width: Get.width,
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      color: Color(int.parse(editController
                                          .appDemoBgColor.value
                                          .toString())),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : buildMediaWidget(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      widget.content,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 2,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    Obx(() {
                      return editBlogController.blogDetails.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                           physics: const NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: editBlogController.blogDetails.length,
                           itemBuilder: (context, index) {
                           var data = editBlogController.blogDetails[index];
                            return Container(
                            width: Get.width,
                            margin: const EdgeInsets.only(bottom: 50),
                            child: Get.width>825  ? Row(
                              children: [
                                index.isEven ? const SizedBox():detailMediaComponent(media: data["media"].toString(),mediaType: data["mediaTypeKey"].toString()) ,
                                index.isEven ? const SizedBox():const SizedBox(width: 25),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      Text("${data["title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 24,color: AppColors.blackColor,height: 1.2),),
                                      const SizedBox(height: 15),
                                      Text("${data["description"]}",style: AppTextStyle.regular300.copyWith(fontSize: 20,color: AppColors.blackColor,height: 1.2),),
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
                                Text("${data["title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 24,color: AppColors.blackColor,height: 1.2),),
                                const SizedBox(height: 15),
                                Text("${data["description"]}",style: AppTextStyle.regular300.copyWith(fontSize: 20,color: AppColors.blackColor,height: 1.2),),
                              ],
                            ),
                          );
                        },
                      );
                    }),

                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }

  Widget buildMediaWidget() {
    return Obx(() {
      return editBlogController.isVideoInitialized.value
          ? AspectRatio(
              aspectRatio: editBlogController.videoController.value.aspectRatio,
              child: VideoPlayer(editBlogController.videoController),
            )
          : const Center(child: Text("no video"));
    });
  }





  Widget displayUploadedVideo(String videoUrl,{bool? isCurrent}) {
    log("url : ---- > ${APIString.latestmediaBaseUrl+videoUrl}");
    // VideoPlayerController controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(APIString.latestmediaBaseUrl+videoUrl));
    controller.initialize().then((value) {
      controller.setLooping(true);
      if(isCurrent == true)controller.play();
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
                    height:250,
                    width: 250,
                    decoration: const BoxDecoration(color: AppColors.whiteColor),
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
      width: 250,
      height:250,
      // height: 550,
      // height: 450,
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
              width: 250,
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
}
