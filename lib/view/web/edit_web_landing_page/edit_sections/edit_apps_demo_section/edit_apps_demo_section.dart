import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_apps_demo_section/add_latest_project/ProjectListScreen.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_apps_demo_section/add_latest_project/add_Project_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:video_player/video_player.dart';

class EditAppsDemoSection extends StatefulWidget {
  const EditAppsDemoSection({Key? key}) : super(key: key);

  @override
  State<EditAppsDemoSection> createState() => _EditAppsDemoSectionState();
}

class _EditAppsDemoSectionState extends State<EditAppsDemoSection> {
  final landingPageController = Get.find<WebLandingPageController>();
  final getLatestProject = Get.find<AddProjectController>();
  final editController = Get.find<EditController>();
  int _currentIndex = 0;

  void nextImage() {
    // carouselController.nextPage();
    landingPageController.appDetailsController.nextPage();
  }

  void previousImage() {
    // carouselController.previousPage();
    landingPageController.appDetailsController.previousPage();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getLatestProject.getProjectData();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Obx(() {
          return editController.homeComponentList.isEmpty && editController.allDataResponse.isEmpty
              ? const SizedBox()
              : editController.allDataResponse.isEmpty ? const SizedBox()
              : Container(
            // height: 600,
            width: Get.width,
            decoration: editController
                .allDataResponse[0]["apps_demo_details"][0]["apps_demo_bg_color_switch"]
                .toString() == "1" &&
                editController
                    .allDataResponse[0]["apps_demo_details"][0]["apps_demo_bg_image_switch"]
                    .toString() == "0"
                ? BoxDecoration(
              color: editController
                  .allDataResponse[0]["apps_demo_details"][0]["apps_demo_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(
                  int.parse(editController.appDemoBgColor.value.toString()))
                  : Color(int.parse(editController
                  .allDataResponse[0]["apps_demo_details"][0]["apps_demo_bg_color"]
                  .toString())),
            )
                : BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl + editController
                      .allDataResponse[0]["apps_demo_details"][0]["apps_demo_bg_image"]
                      .toString(),
                  errorListener: () => const Icon(Icons.error),),
                    fit: BoxFit.cover)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: editController.appsDemo
                              .value,
                          onChanged: (value) {
                            setState(() {
                              editController.appsDemo.value = value;
                              editController.showHideComponent(
                                  value: value == false
                                      ? "No"
                                      : "Yes",
                                  componentName: "apps_demo");
                            });
                          },
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  onPressed: () => Get.back(),
                                                  icon: const Icon(Icons.close)),
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      ColorPickDialog(
                                                        //imgSwitchValue
                                                        containerColor: Color(
                                                            int.parse(editController
                                                                .allDataResponse[0]["apps_demo_details"][0]["apps_demo_bg_color"]
                                                                .toString())),
                                                        keyNameClr: "apps_demo_bg_color",
                                                        clrSwitchValue: "1",
                                                        imgSwitchValue: "0",
                                                        switchKeyNameImg: "apps_demo_bg_image_switch",
                                                        switchKeyNameClr: "apps_demo_bg_color_switch",
                                                      ));
                                                },
                                                child: const Text(
                                                    "Pick Background Color")),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      ImgPickDialog(
                                                        keyNameImg: "apps_demo_bg_image",
                                                        switchKeyNameImg: "apps_demo_bg_image_switch",
                                                        switchKeyNameClr: "apps_demo_bg_color_switch",
                                                      ));
                                                },
                                                child: const Text(
                                                    "Pick Background Image"))
                                          ],
                                        )),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.colorize)),
                      ],
                    )),
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: Get.width,
                    child: InkWell(
                      onTap: () =>
                          Get.dialog(
                              TextEditModule(
                                textKeyName: "apps_demo_title",
                                colorKeyName: "apps_demo_title_color",
                                fontFamilyKeyName: "apps_demo_title_font",
                                textValue: editController
                                    .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title"]
                                    .toString(),
                                fontFamily: editController
                                    .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_font"]
                                    .toString(),
                                fontSize: editController
                                    .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_size"]
                                    .toString(),
                                textColor: Color(int.parse(editController
                                    .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_color"]
                                    .toString())),
                              )),
                      child: Text(
                        editController
                            .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title"]
                            .toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(editController
                            .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_font"]
                            .toString()).copyWith(
                            fontSize: editController
                                .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_size"]
                                .toString() != ""
                                ? double.parse(editController
                                .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_size"]
                                .toString())
                                : 40,
                            fontWeight: FontWeight.w700,
                            color: editController
                                .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_color"]
                                .toString()
                                .isEmpty
                                ? AppColors.blackColor
                                : Color(int.parse(editController
                                .allDataResponse[0]["apps_demo_details"][0]["apps_demo_title_color"]
                                .toString()))),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ProjectListScreen()))
                          .whenComplete(() {
                        getLatestProject.getProjectData();
                      });
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
                            Icon(Icons.edit),
                            SizedBox(width: 3),
                            Text("Edit App Demos")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),


                SizedBox(

                  ///here need to change
                  // height: 630,
                  height: 725,
                  width: Get.width,
                  child: Stack(
                    children: [

                      Obx(() {
                        return getLatestProject.getProjectList.isEmpty ?const SizedBox(): CarouselSlider.builder(
                          carouselController: landingPageController
                              .appDetailsController,
                          options: CarouselOptions(
                            initialPage: _currentIndex,
                            // autoPlayInterval: const Duration(seconds: 10),
                            onPageChanged: (index, reason) {
                              getLatestProject.isVideoPlaying.value == false;
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            viewportFraction: Get.width > 1500
                                ? 0.2
                                : Get.width > 1000
                                ? 0.23
                                : Get.width > 500
                                ? 0.26
                                : 0.5,
                            height: 725,
                            // autoPlay: true,
                          ),
                          itemCount: getLatestProject.getProjectList.length,
                          itemBuilder: (context, itemIndex, realIndex) {
                            var a = getLatestProject.getProjectList[itemIndex];
                            return SizedBox(
                              width: Get.width > 500
                                  ? Get.width * 0.5
                                  : Get.width > 350
                                  ? Get.width * 0.7
                                  : Get.width * 0.7,
                              // color: AppColors.blackColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _currentIndex != itemIndex
                                      ? Text("",
                                    style: AppTextStyle.regularBold.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 40),
                                  )
                                      : AnimatedTextKit(
                                    onTap: () {
                                      log(
                                          "tapped on edit font property ............");
                                      Get.dialog(
                                          TextEditModule(
                                            textValue: "",
                                            textKeyName: "",
                                            showTextField: false,
                                            colorKeyName: "selected_app_name_color",
                                            fontFamilyKeyName: "selected_app_name_font",
                                            fontFamily: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_font"]
                                                .toString(),
                                            fontSize: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_size"]
                                                .toString(),
                                            textColor: Color(
                                                int.parse(editController
                                                    .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_color"]
                                                    .toString())),
                                          ));
                                    },
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        a.appName,
                                        textAlign: TextAlign.center,

                                        textStyle: GoogleFonts.getFont(
                                            editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_font"]
                                                .toString()).copyWith(
                                            fontSize: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_size"]
                                                .toString() != ""
                                                ? double.parse(editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_size"]
                                                .toString())
                                                : 30,
                                            fontWeight: FontWeight.bold,
                                            color: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_color"]
                                                .toString()
                                                .isEmpty
                                                ? AppColors.blackColor
                                                : Color(int.parse(editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_name_color"]
                                                .toString()))),

                                        speed: const Duration(
                                            milliseconds: 3),
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                    pause: const Duration(milliseconds: 0),
                                    // displayFullTextOnTap: true,
                                    // stopPauseOnTap: true,
                                  ),
                                  const SizedBox(height: 25),
                                  // const SizedBox(height: 15),
                                  _currentIndex != itemIndex
                                      ? const Text("")
                                      : AnimatedTextKit(
                                    onTap: () {
                                      log(
                                          "tapped on edit font property ............");
                                      Get.dialog(
                                          TextEditModule(
                                            textValue: "",
                                            textKeyName: "",
                                            showTextField: false,
                                            colorKeyName: "selected_app_short_description_color",
                                            fontFamilyKeyName: "selected_app_short_description_font",
                                            fontFamily: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_font"]
                                                .toString(),
                                            fontSize: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_size"]
                                                .toString(),
                                            textColor: Color(
                                                int.parse(editController
                                                    .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_color"]
                                                    .toString())),
                                          ));
                                    },

                                    repeatForever: false,
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        a.appShortDescription,
                                        textAlign: TextAlign.center,
                                        // textStyle: AppTextStyle.regular300.copyWith(color: AppColors.whiteColor, fontSize: 14),
                                        textStyle: GoogleFonts.getFont(
                                            editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_font"]
                                                .toString()).copyWith(
                                            fontSize: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_size"]
                                                .toString() != ""
                                                ? double.parse(editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_size"]
                                                .toString())
                                                : 14,
                                            fontWeight: FontWeight.w300,
                                            color: editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_color"]
                                                .toString()
                                                .isEmpty
                                                ? AppColors.blackColor
                                                : Color(int.parse(editController
                                                .allDataResponse[0]["apps_demo_details"][0]["selected_app_short_description_color"]
                                                .toString()))),
                                        speed: const Duration(
                                            microseconds: 20),
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                    pause:
                                    const Duration(milliseconds: 0),
                                    // displayFullTextOnTap: true,
                                    // stopPauseOnTap: true,
                                  ),
                                  const SizedBox(height: 40),
                                  // const SizedBox(height: 10),
                                  _currentIndex == itemIndex
                                      ? FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Container(
                                      width: 250,
                                      // height: 550,
                                      height: 450,
                                      // decoration: BoxDecoration(color: AppColors.whiteColor),
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, top: 70),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(20)),
                                            child: a.appMediaFileType ==
                                                "image" ||
                                                a.appMediaFileType == "gif"
                                                ? CachedNetworkImage(
                                              // height: 550,
                                              // width: Get.width * 0.4,
                                              width: 250,
                                              // width: Get.width * 0.9,
                                              imageUrl: APIString
                                                  .latestmediaBaseUrl + a
                                                  .appMediaFile,
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
                                              fit: BoxFit.fill,
                                            )
                                                : displayUploadedVideo(
                                                a.appMediaFile,
                                                isCurrent: _currentIndex ==
                                                    itemIndex),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      : FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: SizedBox(
                                      height: 450,
                                      width: 250,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(20)),
                                            child: a.appMediaFileType ==
                                                "image" ||
                                                a.appMediaFileType == "gif"
                                                ? CachedNetworkImage(
                                              // width: Get.width * 0.4,
                                              width: 250,
                                              height: 450,
                                              imageUrl:
                                              APIString.latestmediaBaseUrl + a
                                                  .appMediaFile,
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
                                              fit: BoxFit.fill,
                                            )
                                            // : displayUploadedVideo(a.appMediaFile,isCurrent: _currentIndex == itemIndex),
                                                : CachedNetworkImage(
                                              // width: Get.width * 0.4,
                                              width: 250,
                                              height: 450,
                                              imageUrl:
                                              APIString.latestmediaBaseUrl + a
                                                  .videoThumbnail,
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
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                      Positioned(
                        left: 50,
                        top: 0, bottom: 0,
                        child: GestureDetector(
                            onTap: previousImage,
                            // onTap: () {
                            //   carouselController.previousPage();
                            // },
                            child: const CircleAvatar(radius: 15,
                              child: Icon(Icons.arrow_back_rounded),)),
                      ),
                      Positioned(
                        right: 50,
                        top: 0, bottom: 0,
                        child: GestureDetector(
                            onTap: nextImage,
                            // onTap: () {
                            //   carouselController.nextPage();
                            // },
                            child: const CircleAvatar(radius: 15,
                              child: Icon(Icons.arrow_forward_rounded),)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        });
      },
    );
  }


  Widget displayUploadedVideo(String videoUrl, {bool? isCurrent}) {
    log("url : ---- > ${APIString.latestmediaBaseUrl + videoUrl}");
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));
    controller.initialize().then((value) {
      controller.setLooping(true);
      if (isCurrent == true) controller.play();
    });

    return InkWell(
      onTap: () {
        if (controller.value.isPlaying) {
          getLatestProject.isVideoPlaying.value = false;
          controller.pause();
        } else {
          getLatestProject.isVideoPlaying.value = true;
          controller.play();
        }
      },
      child: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                    height: Get.width > 1000 ? 500 : 450,
                    width: 250,
                    decoration: const BoxDecoration(
                        color: AppColors.whiteColor),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(controller),
                        Positioned(
                          bottom: 25, right: 25,
                          child: Obx(() =>
                          getLatestProject.isVideoPlaying.value == false
                              ? const Icon(
                            Icons.play_circle_fill,
                            size: 30,
                            color: Colors.black,
                          )
                              : const Icon(
                            Icons.pause,
                            size: 30,
                            color: Colors.black,)),
                        ),
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
}
