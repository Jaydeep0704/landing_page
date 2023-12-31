// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/updateTestiMonalScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../../../edit_web_landing_page/edit_controller/edit_controller.dart';
import 'addTestimonalScreen.dart';

class EditTestimonalScreenList extends StatefulWidget {
  const EditTestimonalScreenList({Key? key}) : super(key: key);

  @override
  State<EditTestimonalScreenList> createState() =>
      _EditTestimonalScreenListState();
}

class _EditTestimonalScreenListState extends State<EditTestimonalScreenList> {
  final testimonalcontroller = Get.find<EditTestimonialController>();
  final editController = Get.find<EditController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      testimonalcontroller.GetTestimonal();
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
          title: Text("Edit Testimonal",
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
                                builder: (context) =>
                                    const AddNewTestimonalScreen()));
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
                              Text("Add New Testimonial")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Obx(() {
                      if (testimonalcontroller.getTestimonial.isNotEmpty) {
                        return SizedBox(
                            height: Get.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  testimonalcontroller.getTestimonial.length,
                              itemBuilder: (context, index) {
                                var data =
                                    testimonalcontroller.getTestimonial[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${data["user_name"]} ,${data["Position"]}",
                                                style: AppTextStyle.regularBold
                                                    .copyWith(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateTestimonial(
                                                    id: data["_id"].toString(),
                                                    name: data["user_name"]
                                                        .toString(),
                                                    bannerfile: data["banner"]
                                                        .toString(),
                                                    bannerfiletype:
                                                        data["banner_mediatype"]
                                                            .toString(),
                                                    description:
                                                        data["Description"]
                                                            .toString(),
                                                    position: data["Position"]
                                                        .toString(),
                                                    medialink:
                                                        data["media_link"]
                                                            .toString(),
                                                    mediatype:
                                                        data["media_type"]
                                                            .toString(),
                                                    companyName:
                                                        data["company_name"]
                                                            .toString(),
                                                    profilimg:
                                                        data["user_image"]
                                                            .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data["company_name"].toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w100,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              testimonalcontroller
                                                  .deleteTestiMonalApi(
                                                      id: data["_id"]
                                                          .toString());
                                            },
                                            icon: const Icon(
                                                Icons.delete_forever),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            child: CachedNetworkImage(
                                              imageUrl: APIString
                                                      .latestmediaBaseUrl +
                                                  data["user_image"].toString(),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                              placeholder: (context, url) =>
                                                  Container(
                                                decoration: BoxDecoration(
                                                  color: Color(int.parse(
                                                      editController
                                                          .appDemoBgColor.value
                                                          .toString())),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
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
