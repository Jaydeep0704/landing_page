import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';

import 'dart:math' as math;
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TestimonialsSection extends StatefulWidget {
  final VoidCallback? scrollToPricingSection;
  const TestimonialsSection({Key? key, this.scrollToPricingSection}) : super(key: key);

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> with SingleTickerProviderStateMixin {
  final webLandingPageController = Get.find<WebLandingPageController>();

  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _rotationAnimation1;
  final editController = Get.find<EditController>();
  final testimonalcontroller = Get.find<EditTestimonalController>();




  oneTimeAnimation() {
    _animationController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      _animationController.reverse(from: 1);
    });
  }


  @override
  void initState() {
    super.initState();
     _animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this,);

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.785398).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ),);
    _rotationAnimation1 = Tween<double>(begin: -1, end: 0.785398).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ),);

    oneTimeAnimation();
  }

  @override
  void dispose() {
    _disposeAnimationController();
    // _animationController.dispose();
    super.dispose();
  }
  void _disposeAnimationController() {
    _animationController.dispose();
  }


  bool change = false;
  bool stop = false;

  final landingPageController = Get.find<WebLandingPageController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return  editController.testimonials.value == false ||   editController.allDataResponse.isEmpty
              ?const SizedBox()
              :Container (
            width: Get.width,
            child: Column(
              children: [
                editController.allDataResponse[0]["testimonials_details"][0]["testimonial2_visible"] == "hide"
                    ? const SizedBox()
                    :Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width > 1500
                          ? 60
                          : Get.width > 1000
                          ? 22
                          : Get.width > 600
                          ? 15
                          : 15),
                  child: Row(
                    children: [
                      Get.width > 500 ? const SizedBox( )
                          :const SizedBox(width:  10),
                      Expanded(
                        child: Center(
                          child: Text(
                            editController.allDataResponse[0]["testimonials_details"][0]["testimonials2_title"]
                                .toString(),
                            style: GoogleFonts.getFont(editController.allDataResponse[0]["testimonials_details"][0]["testimonials2_title_font"].toString()).copyWith(
                                fontSize: editController.allDataResponse[0]["testimonials_details"][0]["testimonials2_title_size"].toString() !=""
                                    ? double.parse(editController.allDataResponse[0]["testimonials_details"][0]["testimonials2_title_size"].toString())
                                    : Get.width > 1000
                                    ? 50
                                    : 30,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(editController.allDataResponse[0]["testimonials_details"][0]["testimonials2_title_color"].toString()))),
                            textAlign: TextAlign.center,
                            // style: GoogleFonts.getFont(selectedFont).copyWith(
                            //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                          ),
                        ),
                      ),
                      Get.width > 500 ? const SizedBox( )
                          :const SizedBox(width:  10),
                    ],
                  ),
                ),
                editController.allDataResponse[0]["testimonials_details"][0]["testimonial2_visible"] == "hide"
                    ? const SizedBox()
                    :const SizedBox(height: 40),

                editController.allDataResponse[0]["testimonials_details"][0]["testimonial2_visible"] == "hide"
                    ? const SizedBox()
                    : Obx(() {
                  return webLandingPageController.aboveCardIndex.value
                      .toString()
                      .isEmpty
                      ? const SizedBox()
                      : Container(
                    // height: 500,
                    // width: Get.width>1500 ?800:Get.width>1000?600:Get.width>600 ?450:450,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2)),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)),
                              child: Container(
                                height: 400,
                                // height: 300,
                                // width: Get.width > 1500 ? 175
                                //     : Get.width > 1000 ? 175
                                //     : Get.width > 600 ? 200 : 200,
                                // width: Get.width > 1500 ? 300
                                //     : Get.width > 1000 ? 300
                                //     :  325,
                                // child: Image.asset(
                                //   "assets/nature.jpeg",
                                //   fit: BoxFit.cover,
                                // ),
                                // margin: const EdgeInsets.only(left: 50,top: 10),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 40),
                                      child: AnimatedBuilder(
                                        animation: _rotationAnimation,
                                        builder: (context, child) {
                                          return Transform.rotate(
                                            angle: _rotationAnimation
                                                .value *
                                                0.33,
                                            transformHitTests: true,
                                            child: Transform.rotate(
                                              angle: -math.pi / 15,
                                              child: Container(
                                                  height: 350,
                                                  width: Get.width >
                                                      1500
                                                      ? 175
                                                      : Get.width > 1000
                                                      ? 175
                                                      : Get.width >
                                                      600
                                                      ? 200
                                                      : 200,
                                                  decoration: const BoxDecoration(
                                                    // color: Colors.blue,
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(5))),
                                                  child:buildMediaWidget(
                                                      testimonalcontroller.getTestimonal[webLandingPageController.belowCardIndex.value]['banner_mediatype'].toString(),
                                                      testimonalcontroller.getTestimonal[webLandingPageController.belowCardIndex.value]['banner'].toString())
                                                // ClipRRect(
                                                //   borderRadius:
                                                //   const BorderRadius.all(Radius.circular(20)),
                                                //
                                                //   child:  testimonalcontroller.getTestimonal[webLandingPageController.belowCardIndex.value]['banner_mediatype'] == "image" ||
                                                //       testimonalcontroller.getTestimonal[webLandingPageController.belowCardIndex.value]['banner_mediatype'] == "gif"
                                                //       ? CachedNetworkImage(
                                                //     fit: BoxFit
                                                //         .cover,
                                                //     width: Get.width * 0.9,
                                                //     imageUrl:
                                                //     APIString.latestmediaBaseUrl +  testimonalcontroller.getTestimonal[webLandingPageController.belowCardIndex.value]['banner'].toString(),
                                                //     placeholder: (context, url) => Container(
                                                //       decoration: BoxDecoration(
                                                //         color: Color(int.parse(editController
                                                //             .appDemoBgColor.value
                                                //             .toString())),
                                                //       ),
                                                //     ),
                                                //     errorWidget: (context, url, error) =>
                                                //     const Icon(Icons.error),
                                                //
                                                //   )
                                                //       : displayUploadedVideo( testimonalcontroller.getTestimonal[webLandingPageController.belowCardIndex.value]['banner'].toString()),
                                                // )
                                                // Image.asset("${featuredImage["image"]}"
                                                // )
                                              ),
                                              // Container(
                                              //   height: 350,
                                              //   width: Get.width >
                                              //       1500
                                              //       ? 175
                                              //       : Get.width > 1000
                                              //       ? 175
                                              //       : Get.width >
                                              //       600
                                              //       ? 200
                                              //       : 200,
                                              //   decoration:
                                              //   BoxDecoration(
                                              //     color: Colors.blue,
                                              //     image: DecorationImage(
                                              //         image: AssetImage(clientsTestimonial[
                                              //         webLandingPageController
                                              //             .belowCardIndex
                                              //             .value]
                                              //         [
                                              //         "clientImage"]),
                                              //         fit: BoxFit
                                              //             .cover),
                                              //     borderRadius:
                                              //     BorderRadius
                                              //         .circular(
                                              //         10),
                                              //   ),
                                              // ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 10,
                                      child: Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            vertical: 20,
                                            horizontal: 40),
                                        child: AnimatedBuilder(
                                          animation:
                                          _rotationAnimation1,
                                          builder: (context, child) {
                                            return Transform.rotate(
                                              origin: const Offset(
                                                  0, 100),
                                              angle:
                                              -_rotationAnimation
                                                  .value *
                                                  0.2,
                                              child:  Container(
                                                  height: 350,
                                                  width: Get.width >
                                                      1500
                                                      ? 175
                                                      : Get.width > 1000
                                                      ? 175
                                                      : Get.width >
                                                      600
                                                      ? 200
                                                      : 200,
                                                  decoration: const BoxDecoration(
                                                    // color: Colors.blue,
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(5))),
                                                  child: buildMediaWidget(
                                                      testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['banner_mediatype'].toString(),
                                                      testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['banner'].toString())
                                                // ClipRRect(
                                                //   borderRadius:
                                                //   const BorderRadius.all(Radius.circular(20)),
                                                //
                                                //   child:  testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['banner_mediatype'] == "image" ||
                                                //       testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['banner_mediatype'] == "gif"
                                                //       ? CachedNetworkImage(
                                                //     fit: BoxFit
                                                //         .cover,
                                                //     width: Get.width * 0.9,
                                                //     imageUrl:
                                                //     APIString.latestmediaBaseUrl +  testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['banner'].toString(),
                                                //     placeholder: (context, url) => Container(
                                                //       decoration: BoxDecoration(
                                                //         color: Color(int.parse(editController
                                                //             .appDemoBgColor.value
                                                //             .toString())),
                                                //       ),
                                                //     ),
                                                //     errorWidget: (context, url, error) =>
                                                //     const Icon(Icons.error),
                                                //
                                                //   )
                                                //       : displayUploadedVideo( testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['banner'].toString()),
                                                // )
                                                // Image.asset("${featuredImage["image"]}"
                                                // )
                                              ),

                                              // Container(
                                              //   height: 350,
                                              //   width: Get.width >
                                              //       1500
                                              //       ? 175
                                              //       : Get.width > 1000
                                              //       ? 175
                                              //       : Get.width >
                                              //       600
                                              //       ? 200
                                              //       : 200,
                                              //   decoration: BoxDecoration(
                                              //       color:
                                              //       Colors.black,
                                              //       image: DecorationImage(
                                              //           image: AssetImage(clientsTestimonial[webLandingPageController
                                              //               .aboveCardIndex
                                              //               .value]
                                              //           [
                                              //           "clientImage"]),
                                              //           fit: BoxFit
                                              //               .cover),
                                              //       borderRadius:
                                              //       BorderRadius
                                              //           .circular(
                                              //           10)),
                                              // ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // StaticString.loremIpsum,
                          "${testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['Description']}",
                          maxLines: 13,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // "ABC & Co.",
                          "${testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]["company_name"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children:  [
                            Text(
                              // "Mr Gary",
                              "${testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['user_name']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text(
                              " - ${testimonalcontroller.getTestimonal[webLandingPageController.aboveCardIndex.value]['Position']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(children: [
                          InkWell(
                            onTap: () {
                              if (webLandingPageController
                                  .aboveCardIndex.value >
                                  0) {
                                webLandingPageController
                                    .belowCardIndex.value =
                                    webLandingPageController
                                        .aboveCardIndex.value;
                                webLandingPageController
                                    .aboveCardIndex.value--;
                              } else {
                                // print("${webLandingPageController
                                //     .belowCardIndex.value}");
                                webLandingPageController
                                    .belowCardIndex.value = 0;
                                // webLandingPageController.aboveCardIndex.value = clientsTestimonial.length - 1;
                                // if(webLandingPageController
                                //     .aboveCardIndex.value!=0){
                                webLandingPageController.aboveCardIndex.value = testimonalcontroller.getTestimonal.length - 1;
                                // }
                              }
                              setState(() {});
                              _animationController.reset();
                              Future.delayed(
                                  const Duration(seconds: 0), () {
                                _animationController
                                    .forward(from: 0)
                                    .whenComplete(() {
                                  _animationController.reverse(
                                    from: 1,
                                  );
                                  // stop = false;
                                });
                              });
                            },
                            child: const Icon(
                              Icons.arrow_circle_left_outlined,
                              size: 50,
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              print(
                                  "1111111111111${webLandingPageController.aboveCardIndex.value}");
                              // if (webLandingPageController.aboveCardIndex.value < clientsTestimonial.length - 1) {
                              if (webLandingPageController.aboveCardIndex.value < testimonalcontroller.getTestimonal.length - 1) {
                                webLandingPageController
                                    .belowCardIndex.value =
                                    webLandingPageController
                                        .aboveCardIndex.value;
                                webLandingPageController
                                    .aboveCardIndex.value++;
                              } else {
                                // webLandingPageController.belowCardIndex.value = clientsTestimonial.length - 1;
                                webLandingPageController.belowCardIndex.value = testimonalcontroller.getTestimonal.length - 1;
                                webLandingPageController.aboveCardIndex.value = 0;
                              }
                              setState(() {});
                              _animationController.reset();
                              Future.delayed(
                                  const Duration(seconds: 0), () {
                                _animationController
                                    .forward(from: 0)
                                    .whenComplete(() {
                                  _animationController.reverse(
                                    from: 1,
                                  );
                                  // stop = false;
                                });
                              });
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 50,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  );
                }),

              ],
            ),
          );

        });
      },
    );
  }
  Widget displayUploadedVideo(String videoUrl) {
    VideoPlayerController _controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    bool isVideoPlaying = false;

    final double videoAspectRatio = /*_controller.value.aspectRatio > 0 ? _controller.value.aspectRatio :*/ 16 / 9;

    return InkWell(
      onTap: () {
        if (_controller.value.isPlaying) {
          isVideoPlaying=false;
          _controller.pause();
        } else {
          _controller.play();
          isVideoPlaying=true;
        }
        // isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return /*AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
              aspectRatio: 16/9,
              // aspectRatio: 1 / 6,
              child:*/ Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller),
                if (!isVideoPlaying)
                  Icon(
                    Icons.play_circle_fill,
                    size: 60,
                    color: Colors.white.withOpacity(0.7),
                  ),
              ],
            );
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
  Widget buildMediaWidget( String bannerMediaType, String bannerMedia) {

    if (bannerMediaType == "image" || bannerMediaType == "gif") {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: Get.width * 0.9,
          imageUrl: APIString.latestmediaBaseUrl + bannerMedia,
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              color: Color(int.parse(editController.appDemoBgColor.value.toString())),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    } else if(bannerMediaType == "video"){
      return displayUploadedVideo(bannerMedia);
    }else{
      return
        Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
                Radius.circular(7)),
            child: SizedBox(
              width: Get.width * 0.9,
              height: 600,
              child: Image.asset("assets/yt_logo.png",
                  fit: BoxFit.cover),
            ),
          ),
        );
    }

  }
}