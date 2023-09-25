// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../../../edit_web_landing_page/edit_controller/edit_controller.dart';
import 'AddCheckInfoScreen.dart';
import 'CheckOutInfoControllers.dart';
import 'EditCheckInfoScreen.dart';

class CheckOutList extends StatefulWidget {
  const CheckOutList({Key? key}) : super(key: key);

  @override
  State<CheckOutList> createState() => _CheckOutListState();
}

class _CheckOutListState extends State<CheckOutList> {
  final checkoutInfocontroller = Get.find<CheckOutInfoController>();
  final editController = Get.find<EditController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkoutInfocontroller.getCheckOutApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: const BackButton(
            color: AppColors.blackColor,
          ),
          title: Text("Edit CheckOut Info",
              style: AppTextStyle.regularBold
                  .copyWith(color: AppColors.blackColor, fontSize: 18)),
          centerTitle: true,
        ),
        body: Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              decoration:
                  BoxDecoration(color: AppColors.whiteColor, boxShadow: [
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.0),
                    blurRadius: 1,
                    spreadRadius: 2)
              ]),
              width: Get.width > 800 ? 700 : 400,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddCheckInfo()))
                            .whenComplete(
                                () => checkoutInfocontroller.getCheckOutApi());
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: AppColors.greyColor.withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: const [
                              Icon(Icons.add),
                              SizedBox(width: 3),
                              Text("Add New Text")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Obx(() {
                      if (checkoutInfocontroller.checkInfoDataList.isNotEmpty) {
                        return SizedBox(
                            height: Get.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: checkoutInfocontroller
                                  .checkInfoDataList.length,
                              itemBuilder: (context, index) {
                                var data = checkoutInfocontroller
                                    .checkInfoDataList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              data["title"].toString(),
                                              style: AppTextStyle.regularBold
                                                  .copyWith(fontSize: 20),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditCheckOutInfo(
                                                    id: data["_id"].toString(),
                                                    title: data["title"]
                                                        .toString(),
                                                    description:
                                                        data["description"]
                                                            .toString(),
                                                    fileData: data["files"]
                                                        .toString(),
                                                    filetype:
                                                        data["file_media_type"]
                                                            .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              data["description"].toString(),
                                              style: AppTextStyle.regular300
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              checkoutInfocontroller
                                                  .deleteCheckOutDataApi(
                                                      id: data["_id"]
                                                          .toString());
                                            },
                                            icon: const Icon(
                                                Icons.delete_forever),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 250,
                                        width: 250,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: data["file_media_type"]
                                                          .toString() ==
                                                      "image" ||
                                                  data["file_media_type"]
                                                          .toString() ==
                                                      "gif"
                                              ? CachedNetworkImage(
                                                  imageUrl: APIString
                                                          .latestmediaBaseUrl +
                                                      data["files"].toString(),
                                                  fit: BoxFit.contain,
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
                                                )
                                              : displayUploadedVideo(
                                                  data["files"].toString()),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.8,
                                        color: AppColors.blackColor
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ));
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
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }

  Widget buildMediaWidget(String filetype, String fileData) {
    if (filetype == "image") {
      return CachedNetworkImage(
        width: Get.width,
        imageUrl: APIString.mediaBaseUrl + fileData,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
            decoration: BoxDecoration(
          color:
              Color(int.parse(editController.appDemoBgColor.value.toString())),
        )),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else if (filetype == "video") {
      return Obx(() {
        return checkoutInfocontroller.isVideoInitialized.value
            ? AspectRatio(
                aspectRatio:
                    checkoutInfocontroller.videoController.value.aspectRatio,
                child: VideoPlayer(checkoutInfocontroller.videoController),
              )
            // : const CircularProgressIndicator();
            : const Center(child: CircularProgressIndicator());
      });
    } else if (filetype == "gif") {
      if (fileData.endsWith(".mp4")) {
        return checkoutInfocontroller.isVideoInitialized.value
            ? AspectRatio(
                aspectRatio:
                    checkoutInfocontroller.videoController.value.aspectRatio,
                child: VideoPlayer(checkoutInfocontroller.videoController),
                // child:  Chewie(controller: mixBannerController.videoControllerChewie!),
              )
            // : const CircularProgressIndicator();
            : const Center(child: CircularProgressIndicator());
      } else {
        return CachedNetworkImage(
          // width: Get.width,
          imageUrl: APIString.mediaBaseUrl + fileData,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
              decoration: BoxDecoration(
            color: Color(
                int.parse(editController.appDemoBgColor.value.toString())),
          )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
    } else {
      return const Center(child: Text("bot"));
    }
  }

  Widget displayUploadedVideo(String videoUrl) {
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));
    bool isVideoPlaying = false;

    return InkWell(
      onTap: () {
        if (controller.value.isPlaying) {
          isVideoPlaying = false;
          controller.pause();
        } else {
          controller.play();
          isVideoPlaying = true;
        }
        // isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                //aspectRatio: 16/9,
                // aspectRatio: 1 / 6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(controller),
                    if (!isVideoPlaying)
                      Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white.withOpacity(0.7),
                      ),
                  ],
                ));
            // );
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
}
