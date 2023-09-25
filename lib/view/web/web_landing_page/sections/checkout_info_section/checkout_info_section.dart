import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:video_player/video_player.dart';
import '../../../../../config/api_string.dart';
import '../../../edit_web_landing_page/edit_controller/edit_controller.dart';
import '../../controller/landing_page_controller.dart';
import 'CheckOutInfoControllers.dart';

class CheckoutInfoSection extends StatefulWidget {
  const CheckoutInfoSection({Key? key}) : super(key: key);

  @override
  State<CheckoutInfoSection> createState() => _CheckoutInfoSectionState();
}

class _CheckoutInfoSectionState extends State<CheckoutInfoSection> {
  final checkoutInfocontroller = Get.find<CheckOutInfoController>();
  final landingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();

  // late VideoPlayerController _controller;
  // ScrollController _scrollController = ScrollController();
  // Timer? _autoScrollTimer;
  // bool isVideoInitialized = false;
  // Timer? _timer;
  int _currentIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   checkoutInfocontroller.getCheckOutApi();
    // });
  }

  @override
  void dispose() {
    // _timer?.cancel();
    // _autoScrollTimer?.cancel();
    // _scrollController.dispose();

    super.dispose();
  }

  // void startAutoScroll() {
  //   const autoScrollDuration = Duration(seconds: 5);
  //   const pixelsToScroll = 300.0;
  //
  //   _autoScrollTimer = Timer.periodic(autoScrollDuration, (_) {
  //     final maxScrollExtent = _scrollController.position.maxScrollExtent;
  //     final currentScrollOffset = _scrollController.offset;
  //     final newScrollOffset = currentScrollOffset + pixelsToScroll;
  //
  //     if (newScrollOffset <= maxScrollExtent) {
  //       _scrollController.animateTo(
  //         newScrollOffset,
  //         duration: autoScrollDuration,
  //         curve: Curves.linear,
  //       );
  //     } else {
  //       _scrollController.animateTo(
  //         0,
  //         duration: autoScrollDuration,
  //         curve: Curves.linear,
  //       );
  //     }
  //   });
  // }
  //
  // void startAutoScrolllist() {
  //   const autoScrollDuration = Duration(seconds: 5);
  //
  //   _autoScrollTimer = Timer.periodic(autoScrollDuration, (_) {
  //     final maxScrollExtent = _scrollController.position.maxScrollExtent;
  //     final currentScrollOffset = _scrollController.offset;
  //     final newScrollOffset = currentScrollOffset + 300.0; // Adjust the scroll distance as needed
  //
  //     if (newScrollOffset <= maxScrollExtent) {
  //       _scrollController.animateTo(
  //         newScrollOffset,
  //         duration: autoScrollDuration,
  //         curve: Curves.linear,
  //       );
  //     } else {
  //       _scrollController.animateTo(
  //         0,
  //         duration: autoScrollDuration,
  //         curve: Curves.linear,
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() =>
        editController.checkoutInfo.value == false ||
            editController.allDataResponse.isEmpty
            ? const SizedBox()
            : Container(
          // height: 700,
          padding: EdgeInsets.only(
              left: Get.width > 650 ? Get.width * 0.1 : Get.width * 0.05,
              right: Get.width > 650 ? Get.width * 0.1 : Get.width * 0.05),
          width: Get.width,
          decoration: editController
              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_color_switch"]
              .toString() == "1" &&
              editController
                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_image_switch"]
                  .toString() == "0"
              ? BoxDecoration(
            color: editController
                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_color"]
                .toString()
                .isEmpty
                ? Color(int.parse(
                editController.introBgColor.value.toString()))
                : Color(int.parse(editController
                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_color"]
                .toString())),
          )
              : BoxDecoration(
              image: DecorationImage(image: CachedNetworkImageProvider(
                APIString.mediaBaseUrl +
                    editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_bg_image"]
                        .toString(),
                errorListener: () => const Icon(Icons.error),),
                  fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              const SizedBox(height: 80),

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: Get.width * 0.1, right: Get.width * 0.1),
                child: Text(
                  editController
                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1"]
                      .toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(editController
                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_font"]
                      .toString()).copyWith(
                      fontSize: editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_size"]
                          .toString() != ""
                          ? double.parse(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_size"]
                          .toString())
                          : 32,
                      fontWeight: FontWeight.w800,
                      color: Color(int.parse(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_color"]
                          .toString()))),
                ),
              ),
              const SizedBox(height: 25),
              Get.width > 650
                  ? const SizedBox()
                  : Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: AppColors.yellowColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),


                child: Text(
                  editController
                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag"]
                      .toString(),
                  style: GoogleFonts.getFont(editController
                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_font"]
                      .toString()).copyWith(
                      fontSize: editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                          .toString() != ""
                          ? double.parse(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                          .toString())
                          : 14,
                      fontWeight: FontWeight.w300,
                      color: Color(int.parse(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_color"]
                          .toString()))),
                ),),
              const SizedBox(height: 25),

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: Get.width * 0.1,
                    right: Get.width * 0.1,
                    top: 16,
                    bottom: 16),
                child: Text(
                  editController
                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1"]
                      .toString(),
                  style: GoogleFonts.getFont(editController
                      .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_font"]
                      .toString()).copyWith(
                      fontSize: editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title1_size"]
                          .toString() != ""
                          ? double.parse(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_size"]
                          .toString())
                          : 14,
                      fontWeight: FontWeight.w400,
                      color: Color(int.parse(editController
                          .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description1_color"]
                          .toString()))),
                ),
              ),

              Get.width > 650
                  ? const SizedBox()
                  : Text(
                editController
                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2"]
                    .toString(),
                style: GoogleFonts.getFont(editController
                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_font"]
                    .toString()).copyWith(
                    fontSize: editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                        .toString() != ""
                        ? double.parse(editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                        .toString())
                        : 20,
                    fontWeight: FontWeight.bold,
                    color: Color(int.parse(editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_color"]
                        .toString()))),
              ),

              const SizedBox(height: 25),

              Get.width > 650
                  ? const SizedBox()
                  : Text(
                editController
                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2"]
                    .toString(),
                style: GoogleFonts.getFont(editController
                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_font"]
                    .toString()).copyWith(
                    fontSize: editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                        .toString() != ""
                        ? double.parse(editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                        .toString())
                        : 15,
                    fontWeight: FontWeight.w400,
                    color: Color(int.parse(editController
                        .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_color"]
                        .toString()))),
              ),

              const SizedBox(height: 32),

              Get.width > 650
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: AppColors.yellowColor,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          // child: Text(
                          //   "Grobiz Plus",
                          //   textAlign: TextAlign.center,
                          //   style: AppTextStyle.regular300
                          //       .copyWith(fontSize: 14),
                          // ),
                          child: Text(
                            editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag"]
                                .toString(),
                            style: GoogleFonts.getFont(editController
                                .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_font"]
                                .toString()).copyWith(
                                fontSize: editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                                    .toString() != ""
                                    ? double.parse(editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_size"]
                                    .toString())
                                    : 14,
                                fontWeight: FontWeight.w300,
                                color: Color(int.parse(editController
                                    .allDataResponse[0]["checkout_info_details"][0]["checkout_info_tag_color"]
                                    .toString()))),
                          ),),
                        const SizedBox(height: 15),
                        Text(
                          editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2"]
                              .toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_font"]
                              .toString()).copyWith(
                              fontSize: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                                  .toString() != ""
                                  ? double.parse(editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_size"]
                                  .toString())
                                  : 20,
                              fontWeight: FontWeight.bold,
                              color: Color(int.parse(editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_title2_color"]
                                  .toString()))),

                          // style: GoogleFonts.getFont(selectedFont).copyWith(
                          //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2"]
                              .toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(editController
                              .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_font"]
                              .toString()).copyWith(
                              fontSize: editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                                  .toString() != ""
                                  ? double.parse(editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_size"]
                                  .toString())
                                  : 15,
                              fontWeight: FontWeight.w400,
                              color: Color(int.parse(editController
                                  .allDataResponse[0]["checkout_info_details"][0]["checkout_info_description2_color"]
                                  .toString()))),

                          // style: GoogleFonts.getFont(selectedFont).copyWith(
                          //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        ///here need to change....
                        Obx(() {
                          return checkoutInfocontroller.checkInfoDataList
                              .isEmpty ?
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                'No Data...',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                              : SizedBox(
                            height: 600,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              // controller: _scrollController,
                              itemCount: checkoutInfocontroller
                                  .checkInfoDataList.length,
                              itemBuilder: (context, index) {
                                var data = checkoutInfocontroller
                                    .checkInfoDataList[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 2,
                                          margin: const EdgeInsets.only(
                                              right: 16),
                                          decoration: BoxDecoration(
                                            color: _currentIndex == index
                                                ? AppColors.blueColor
                                                : Colors.grey,
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                data["title"].toString(),
                                                style: AppTextStyle.regular700
                                                    .copyWith(fontSize: 22),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                data["description"].toString(),
                                                style: AppTextStyle.regular400
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              },
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(width: Get.width * 0.075),

                  ///slider code
                  Expanded(
                    child: Obx(() {
                      return checkoutInfocontroller.checkInfoDataList.isEmpty ?const SizedBox(): SizedBox(
                        height: 600,
                        width: Get.width,
                        child: CarouselSlider.builder(
                          carouselController: landingPageController
                              .appDetailsController,
                          options: CarouselOptions(
                            // enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            viewportFraction: 1.0,
                            // Set viewportFraction to 1.0
                            height: 630,
                          ),
                          itemCount: checkoutInfocontroller.checkInfoDataList
                              .length,
                          itemBuilder: (context, itemIndex, realIndex) {
                            var a = checkoutInfocontroller
                                .checkInfoDataList[itemIndex];
                            return _currentIndex == itemIndex
                                ? SizedBox(
                              width: Get.width > 500 ? Get.width * 0.5 : Get
                                  .width > 350 ? Get.width * 0.7 : Get.width *
                                  0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 550,
                                    // Increase the height of the image container
                                    width: Get.width * 0.9,
                                    // Increase the width of the image container
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: a["file_media_type"]
                                              .toString() == "image" ||
                                              a["file_media_type"].toString() ==
                                                  "gif"
                                              ? CachedNetworkImage(
                                            imageUrl: APIString
                                                .latestmediaBaseUrl +
                                                a["files"].toString(),
                                            placeholder: (context, url) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(int.parse(
                                                        editController
                                                            .appDemoBgColor
                                                            .value.toString())),
                                                  ),
                                                ),
                                            errorWidget: (context, url,
                                                error) =>
                                            const Icon(Icons.error),
                                            fit: BoxFit
                                                .cover, // Use cover to make the image fit the container
                                          )
                                              :
                                          //buildMediaWidget()
                                          displayUploadedVideo(
                                              a["files"].toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : Container();
                          },
                        ),
                      );
                    }),
                  ),
                ],
              )
                  : SizedBox(
                // height: Get.width * 0.7,
                width: Get.width * 0.7,
                child: Center(
                  child: CarouselSlider.builder(

                    carouselController: landingPageController
                        .appDetailsController,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      viewportFraction: 1.0,
                      // Set viewportFraction to 1.0
                      // height: 630,
                      height: 750,
                    ),
                    itemCount: checkoutInfocontroller.checkInfoDataList.length,
                    itemBuilder: (context, itemIndex, realIndex) {
                      var a = checkoutInfocontroller
                          .checkInfoDataList[itemIndex];
                      return _currentIndex == itemIndex
                          ? SizedBox(
                        width: Get.width > 500 ? Get.width * 0.5 : Get.width >
                            350 ? Get.width * 0.7 : Get.width * 0.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              height: 300,
                              // Increase the height of the image container
                              width: Get.width * 0.9,
                              // Increase the width of the image container
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: a["file_media_type"].toString() ==
                                        "image" ||
                                        a["file_media_type"].toString() == "gif"
                                        ? CachedNetworkImage(
                                      imageUrl: APIString.latestmediaBaseUrl +
                                          a["files"].toString(),
                                      placeholder: (context, url) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(
                                                  int.parse(editController
                                                      .appDemoBgColor.value
                                                      .toString())),
                                            ),
                                          ),
                                      errorWidget: (context, url,
                                          error) => const Icon(Icons.error),
                                      fit: BoxFit
                                          .cover, // Use cover to make the image fit the container
                                    )
                                        :
                                    //buildMediaWidget()
                                    displayUploadedVideo(a["files"].toString()),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 2,
                                      margin: const EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                        color: AppColors.blueColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            a["title"].toString(),
                                            style: AppTextStyle.regular700
                                                .copyWith(fontSize: 22),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            a["description"].toString(),
                                            style: AppTextStyle.regular400
                                                .copyWith(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),


                          ],
                        ),
                      )
                          : Container();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ));
      },
    );
  }


  ///video play after tab
  Widget displayUploadedVideo(String videoUrl) {
    VideoPlayerController vController = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));
    bool isVideoPlaying = false;

    // final double videoAspectRatio = /*_controller.value.aspectRatio > 0 ? _controller.value.aspectRatio :*/ 16 / 9;

    return InkWell(
      onTap: () {
        if (vController.value.isPlaying) {
          isVideoPlaying = false;
          vController.pause();
        } else {
          vController.play();
          isVideoPlaying = true;
        }
        // isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: vController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
                aspectRatio: vController.value.aspectRatio,
                //aspectRatio: 16/9,
                // aspectRatio: 1 / 6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(vController),
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


