import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/related_blog/types/blog_category_controller.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';
import 'package:video_player/video_player.dart';
import 'blog_controller.dart';

class BlogDetailsScreen extends StatefulWidget {
  final String id;
  final String blogTypeKey;
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
    required this.blogTypeKey,
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
  final blogCategoriesController = Get.find<BlogCategoriesController>();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      editBlogController.getBlogDetailsData(id: widget.id);
    });
    initializeVideo();
    getRelatedData();
    KeyboardScroll.addScrollListener(_controller);
  }

  getRelatedData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      blogCategoriesController.getRelatedBlogs(
          blog_id: widget.id, blogTypeKey: widget.blogTypeKey);
    });
  }

  @override
  void dispose() {
    if (widget.mediaType == "video") {
      editBlogController.videoController.pause();
      editBlogController.videoController.dispose();
    }
    KeyboardScroll.removeScrollListener();
    _controller.dispose();
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
              width: Get.width > 550 ? Get.width - Get.width * 0.2 : Get.width,
              child: ListView(
                controller: _controller,
                children: [
                  blogData(),
                  const SizedBox(width: 13),
                  const Divider(
                    color: AppColors.greyBorderColor,
                    thickness: 0.5,
                  ),
                  const SizedBox(width: 13),
                  relatedBlogs(),
                ],
              ),

              // child: SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   child: Column(
              //     children: [
              //       blogData(),
              //       const SizedBox(width: 13),
              //       const Divider(
              //         color: AppColors.greyBorderColor,
              //         thickness: 0.5,
              //       ),
              //       const SizedBox(width: 13),
              //       relatedBlogs(),
              //     ],
              //   ),
              // ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }

  Column blogData() {
    return Column(
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
            decoration: const BoxDecoration(
                color: AppColors.lightBlueColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(
                widget.blogType,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                  color: AppColors.whiteColor,
                ),
              ),
            )),
        const SizedBox(height: 20),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: Get.width > 550 ? 50 : 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: APIString.latestmediaBaseUrl + widget.profileImg,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        color: Color(int.parse(
                            editController.appDemoBgColor.value.toString())),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widget.name.isEmpty ? 0 : 15,
            ),
            widget.name.isEmpty
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: Get.width > 550 ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "~ Author",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
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
              child: widget.mediaType == "image" || widget.mediaType == "gif"
                  ? CachedNetworkImage(
                      imageUrl: APIString.latestmediaBaseUrl + widget.media,
                      fit: BoxFit.fill,
                      height: 350,
                      width: Get.width > 850 ? 750 : Get.width,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Color(int.parse(
                              editController.appDemoBgColor.value.toString())),
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
        const SizedBox(height: 80),
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
                      margin: const EdgeInsets.only(bottom: 80),
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
                                      const SizedBox(height: 15),
                                      Text(
                                        "${data["title"]}",
                                        style: AppTextStyle.regularBold
                                            .copyWith(
                                                fontSize: 24,
                                                color: AppColors.blackColor,
                                                height: 2),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "${data["description"]}",
                                        style: AppTextStyle.regular300.copyWith(
                                            fontSize: 20,
                                            color: AppColors.blackColor,
                                            height: 2),
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
                                      height: 2),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "${data["description"]}",
                                  style: AppTextStyle.regular300.copyWith(
                                      fontSize: 20,
                                      color: AppColors.blackColor,
                                      height: 2),
                                ),
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
    );
  }

  Container relatedBlogs() {
    return Container(
      // width: 400,
      margin: const EdgeInsets.only(top: 80, bottom: 40),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
      height: /*Get.width > 1000 ? Get.height * 1.31 : */ 495,
      decoration: BoxDecoration(color: AppColors.blackColor.withOpacity(0.05)),
      child: Obx(() {
        return blogCategoriesController.relatedBlogs.isEmpty
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
                      "Related Blogs",
                      style: AppTextStyle.regular800.copyWith(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    // height: Get.height * 1.2,
                    height: /*Get.width > 1000 ? Get.height * 1.2 :*/ 400,
                    width: /*Get.width > 1000 ? 400 : */ null,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      scrollDirection: /*Get.width > 1000 ? Axis.vertical :*/
                          Axis.horizontal,
                      itemCount: blogCategoriesController.relatedBlogs.length,
                      itemBuilder: (context, index) {
                        var data = blogCategoriesController.relatedBlogs[index];
                        return GestureDetector(
                          onTap: () {
                            // Get.to(() => BlogDetailsScreen(
                            //       id: data["blog_auto_id"],
                            //       blogTypeKey: data["blogTypeKey"],
                            //       title: data["title"],
                            //       content: data["content"],
                            //       name: data["userName"],
                            //       media: data["media"],
                            //       blogType: data["blogTypeKey"],
                            //       mediaType: data["media_type"],
                            //       profileImg: data["userImage"],
                            //       bgColor: data["blogs_section_color"],
                            //       blogDetails: List<Map<String, String>>.from(
                            //           data["blog_details"].map((detail) =>
                            //               Map<String, String>.from(detail))),
                            //     ));

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return BlogDetailsScreen(
                                  id: data["blog_auto_id"],
                                  blogTypeKey: data["blogTypeKey"],
                                  title: data["title"],
                                  content: data["content"],
                                  name: data["userName"],
                                  media: data["media"],
                                  blogType: data["blogTypeKey"],
                                  mediaType: data["media_type"],
                                  profileImg: data["userImage"],
                                  bgColor: data["blogs_section_color"],
                                  blogDetails: List<Map<String, String>>.from(
                                      data["blog_details"].map((detail) =>
                                          Map<String, String>.from(detail))),
                                );
                              },
                            ));
                          },
                          child: Container(
                            height: 400,
                            width: 400,
                            decoration: BoxDecoration(
                                // color: Colors.green,
                                color: AppColors.whiteColor.withOpacity(0.8),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            margin: const EdgeInsets.only(
                                right: 5, left: 5, bottom: 25),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  "${data["title"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 15),
                                Expanded(
                                    child: Text(
                                  "${data["content"]}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: Get.width > 1000 ? 13 : 8,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200),
                                )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8, right: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50)),
                                                child: CachedNetworkImage(
                                                  imageUrl: APIString
                                                          .latestmediaBaseUrl +
                                                      data["userImage"]
                                                          .toString(),
                                                  fit: BoxFit.cover,
                                                  width: 30,
                                                  height: 30,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(int.parse(
                                                          editController
                                                              .appDemoBgColor
                                                              .value
                                                              .toString())),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: Text("${data["userName"]}"),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Read more",
                                        style: AppTextStyle.regular400.copyWith(
                                            color: AppColors.blueColor),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

  Widget displayUploadedVideo(String videoUrl, {bool? isCurrent}) {
    log("url : ---- > ${APIString.latestmediaBaseUrl + videoUrl}");
    // VideoPlayerController controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));
    controller.initialize().then((value) {
      controller.setLooping(true);
      /*if(isCurrent == true)*/
      controller.play();
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

  detailMediaComponent({String? mediaType, String? media}) {
    return Container(
      // width: 250,
      // height:250,
      height: Get.width > 825 ? Get.width * 0.25 : Get.width * 0.6,
      width: Get.width > 825 ? Get.width * 0.35 : Get.width * 0.6,
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
}
