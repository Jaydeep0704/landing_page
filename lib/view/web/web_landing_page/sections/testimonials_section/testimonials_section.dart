// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/pricing_section/pricing_section.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_details_screen.dart';

import 'dart:math' as math;
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../config/app_string.dart';
import '../../../../../widget/common_button.dart';
import '../../../edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import '../../../edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';

class TestimonialsSection extends StatefulWidget {
  final VoidCallback? scrollToPricingSection;

  const TestimonialsSection({Key? key, this.scrollToPricingSection})
      : super(key: key);

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with SingleTickerProviderStateMixin {
  final webLandingPageController = Get.find<WebLandingPageController>();

  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _rotationAnimation1;

  // Animation<double>? _animation;
  final editIntroController = Get.find<EditIntroController>();
  final editController = Get.find<EditController>();
  final testimonialController = Get.find<EditTestimonialController>();
  final blogController = Get.find<EditBlogController>();


  oneTimeAnimation() {
    if (mounted) {
      _animationController.forward();
      Future.delayed(const Duration(seconds: 1), () {
        _animationController.reverse(from: 1);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   testimonalcontroller.GetAppLogoes();
    //   testimonalcontroller.GetTestimonal().then((value) {
    //     webLandingPageController.belowCardIndex.value = testimonalcontroller.getTestimonal.length - 1;
    //   });
    //   blog_controller.GetBlogData();
    // });

    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this,);

    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 0.785398).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
        ),);
    _rotationAnimation1 =
        Tween<double>(begin: -1, end: 0.785398).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
        ),);

    oneTimeAnimation();
  }

  @override
  void dispose() {
    // _animationController.dispose();
    _disposeAnimationController();
    super.dispose();
  }

  void _disposeAnimationController() {
    _animationController.dispose();
  }

  //  late AnimationController _animationController;
  //   late Animation<double> _rotationAnimation;
  //   late Animation<double> _rotationAnimation1;

  bool change = false;
  bool stop = false;

  final landingPageController = Get.find<WebLandingPageController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.testimonials.value == false ||
              editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
            // decoration: BoxDecoration(color: AppColors.bgOrange.withOpacity(0.3)),
            width: Get.width,


            decoration: editController
                .allDataResponse[0]["testimonials_details"][0]["testimonials_bg_color_switch"]
                .toString() == "1" &&
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonials_bg_image_switch"]
                    .toString() == "0"
                ? BoxDecoration(
              color: editController.allDataResponse[0]
              ["testimonials_details"][0]["testimonials_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(int.parse(
                  editController.introBgColor.value.toString()))
                  : Color(int.parse(editController.allDataResponse[0]
              ["testimonials_details"][0]["testimonials_bg_color"]
                  .toString())),
            )
                : BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl +
                      editController.allDataResponse[0]["testimonials_details"]
                      [0]["testimonials_bg_image"]
                          .toString(),
                  errorListener: () => const Icon(Icons.error),),
                    fit: BoxFit.cover)
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : Row(
                  children: [
                    Get.width > 500 ? const SizedBox()
                        : const SizedBox(width: 10),
                    Expanded(
                      child: Center(
                        child: Text(
                          editController
                              .allDataResponse[0]["testimonials_details"][0]["testimonials_title1"]
                              .toString(),
                          style: GoogleFonts.getFont(editController
                              .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_font"]
                              .toString()).copyWith(
                              fontSize: editController
                                  .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_size"]
                                  .toString() != ""
                                  ? double.parse(editController
                                  .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_size"]
                                  .toString())
                                  : Get.width > 1000
                                  ? 50
                                  : 30,
                              fontWeight: FontWeight.bold,
                              color: Color(int.parse(editController
                                  .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_color"]
                                  .toString()))),

                          textAlign: TextAlign.center,
                          // style: GoogleFonts.getFont(selectedFont).copyWith(
                          //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                        ),
                      ),
                    ),
                    Get.width > 500 ? const SizedBox()
                        : const SizedBox(width: 10),

                    // Get.width > 500 ? const Expanded(child: SizedBox( ))
                    //     :SizedBox(width:  Get.width * 0.05),
                  ],
                ),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : const SizedBox(height: 40),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 3, child: SizedBox()),
                    // SizedBox(width: Get.width * 0.08),
                    Expanded(
                      flex: 6,
                      child: Align(
                        alignment: Alignment.center,
                        child: Obx(() {
                          return testimonialController.appLogoList.isEmpty
                              ? const Center(child: Text("No Data"))
                              : GridView.builder(
                            padding: const EdgeInsets.all(25),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 100,
                                mainAxisSpacing: 10),
                            shrinkWrap: true,
                            itemCount: testimonialController.appLogoList.length,
                            itemBuilder: (context, index) {
                              var data = testimonialController
                                  .appLogoList[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                // Adjust the radius to your preference
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: APIString.bannerMediaUrl +
                                        data["images"].toString(),
                                    placeholder: (context, url) =>
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                    // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    //     CircularProgressIndicator(value: downloadProgress.progress),
                                    errorWidget: (context, url,
                                        error) => const Icon(Icons.error),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                    const Expanded(flex: 3, child: SizedBox()),
                    // SizedBox(width: Get.width * 0.08)
                  ],
                ),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : const SizedBox(height: 40),

                ///our testimonial

                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : Padding(
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
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                      Expanded(
                        child:

                        Center(
                          child: Text(
                            editController
                                .allDataResponse[0]["testimonials_details"][0]["testimonials1_title"]
                                .toString(),
                            style: GoogleFonts.getFont(editController
                                .allDataResponse[0]["testimonials_details"][0]["testimonials1_title_font"]
                                .toString()).copyWith(
                                fontSize: editController
                                    .allDataResponse[0]["testimonials_details"][0]["testimonials1_title_size"]
                                    .toString() != ""
                                    ? double.parse(editController
                                    .allDataResponse[0]["testimonials_details"][0]["testimonials1_title_size"]
                                    .toString())
                                    : Get.width > 1000
                                    ? 50
                                    : 30,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(editController
                                    .allDataResponse[0]["testimonials_details"][0]["testimonials1_title_color"]
                                    .toString()))),
                            textAlign: TextAlign.center,
                            // style: GoogleFonts.getFont(selectedFont).copyWith(
                            //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                          ),
                        ),
                      ),
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                    ],
                  ),
                ),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : const SizedBox(height: 40),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Get.width > 505
                        ? IconButton(
                      onPressed: () {
                        // Use the controller to change the current page
                        landingPageController.reviewCarouselController
                            .previousPage();
                      },
                      icon: const Icon(Icons.arrow_back),
                    )
                        : const SizedBox(),
                    Container(
                      // height: ,
                      width: Get.width > 1500
                          ? Get.width - Get.width * 0.16
                          : Get.width > 1000
                          ? Get.width - Get.width * 0.15
                          : Get.width > 500
                          ? Get.width - Get.width * 0.2
                          : Get.width - 50,
                      alignment: Alignment.center,
                      child: CarouselSlider(
                        carouselController:
                        landingPageController.reviewCarouselController,
                        // Give the controller
                        options: CarouselOptions(
                          // aspectRatio: 16/12,
                          height: Get.width > 1500
                              ? 250
                              : Get.width > 1000
                              ? 250
                              : Get.width < 500
                              ? 250
                              : 230,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          // viewportFraction: 0.4,
                          viewportFraction: Get.width > 1500
                              ? 0.3
                              : Get.width > 1000
                              ? 0.33
                              : Get.width > 700
                              ? 0.5
                              : 0.90,
                          autoPlay: true,
                        ),
                        items: testimonialController.getTestimonial.map((
                            featuredImage) {
                          return Container(
                            // height: 300,
                            width: Get.width > 700 ? 600 : 450,
                            decoration: BoxDecoration(
                              // color: Colors.yellow,
                                color: AppColors.redColor.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                ytMediaWidget(
                                  featuredImage['media_type'].toString(),
                                  featuredImage['banner_mediatype'].toString(),
                                  featuredImage['banner'].toString(),
                                  featuredImage['media_link'].toString(),),

                                // Center(
                                //   child: ClipRRect(
                                //     borderRadius: const BorderRadius.all(
                                //         Radius.circular(7)),
                                //     child: SizedBox(
                                //       height: 80,
                                //       width: 160,
                                //       child: Image.asset("assets/yt_logo.png",
                                //           fit: BoxFit.cover),
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(width: 3),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        right: Get.width > 500 ? 24 : 0,
                                        left: Get.width > 500 ? 24 : 0),
                                    child: Text(
                                      "${featuredImage['Description']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          child: CachedNetworkImage(
                                            imageUrl: APIString
                                                .latestmediaBaseUrl +
                                                featuredImage["user_image"]
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
                                                            .value.toString())),
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
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                          "${featuredImage["user_name"]}"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    Get.width > 505
                        ? IconButton(
                      onPressed: () {
                        // Use the controller to change the current page
                        landingPageController.reviewCarouselController
                            .nextPage();
                      },
                      icon: const Icon(Icons.arrow_forward),
                    )
                        : const SizedBox(),
                  ],
                ),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : Get.width > 505
                    ? const SizedBox()
                    : Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Use the controller to change the current page
                          landingPageController.reviewCarouselController
                              .previousPage();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      IconButton(
                        onPressed: () {
                          // Use the controller to change the current page
                          landingPageController.reviewCarouselController
                              .nextPage();
                        },
                        icon: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                ),

                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial1_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : const SizedBox(height: 40),

                ///inspired testimonial
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial2_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : Padding(
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
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                      Expanded(
                        child: Center(
                          child: Text(
                            editController
                                .allDataResponse[0]["testimonials_details"][0]["testimonials2_title"]
                                .toString(),
                            style: GoogleFonts.getFont(editController
                                .allDataResponse[0]["testimonials_details"][0]["testimonials2_title_font"]
                                .toString()).copyWith(
                                fontSize: editController
                                    .allDataResponse[0]["testimonials_details"][0]["testimonials2_title_size"]
                                    .toString() != ""
                                    ? double.parse(editController
                                    .allDataResponse[0]["testimonials_details"][0]["testimonials2_title_size"]
                                    .toString())
                                    : Get.width > 1000
                                    ? 50
                                    : 30,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(editController
                                    .allDataResponse[0]["testimonials_details"][0]["testimonials2_title_color"]
                                    .toString()))),
                            textAlign: TextAlign.center,
                            // style: GoogleFonts.getFont(selectedFont).copyWith(
                            //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                          ),
                        ),
                      ),
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                    ],
                  ),
                ),
                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial2_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : const SizedBox(height: 40),

                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial2_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : Get.width > 800
                    ? Container(
                  // height: 600,
                  height: 600,
                  width: Get.width > 1500
                      ? 900
                      : Get.width > 1000
                      ? 1000
                      : Get.width > 800
                      ? 750
                      : Get.width > 600
                      ? 500
                      : 450,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2)),
                  padding: const EdgeInsets.all(25),
                  child: Obx(() {
                    return webLandingPageController.aboveCardIndex.value
                        .toString().isEmpty || testimonialController.getTestimonial.isEmpty
                        ? const SizedBox()
                        : Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${testimonialController
                                        .getTestimonial[webLandingPageController
                                        .aboveCardIndex.value]['Description']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  // const Spacer(),
                                  const SizedBox(height: 100),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Company : ${testimonialController
                                            .getTestimonial[webLandingPageController
                                            .aboveCardIndex
                                            .value]['company_name']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Name : ${testimonialController
                                            .getTestimonial[webLandingPageController
                                            .aboveCardIndex
                                            .value]['user_name']}",
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      Text(
                                        " - ${testimonialController
                                            .getTestimonial[webLandingPageController
                                            .aboveCardIndex
                                            .value]['Position']}",
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.w400,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (webLandingPageController
                                              .aboveCardIndex
                                              .value >
                                              0) {
                                            webLandingPageController
                                                .belowCardIndex
                                                .value =
                                                webLandingPageController
                                                    .aboveCardIndex
                                                    .value;
                                            webLandingPageController
                                                .aboveCardIndex
                                                .value--;
                                          } else {
                                            webLandingPageController
                                                .belowCardIndex
                                                .value = 0;
                                            webLandingPageController
                                                .aboveCardIndex
                                                .value =
                                                testimonialController
                                                    .getTestimonial
                                                    .length -
                                                    1;
                                          }
                                          setState(() {});
                                          _animationController
                                              .reset();
                                          Future.delayed(
                                              const Duration(
                                                  seconds: 0), () {
                                            _animationController
                                                .forward(from: 0)
                                                .whenComplete(() {
                                              _animationController
                                                  .reverse(
                                                from: 1,
                                              );
                                              // stop = false;
                                            });
                                          });
                                        },
                                        child: const Icon(
                                          Icons
                                              .arrow_circle_left_outlined,
                                          size: 50,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      InkWell(
                                        onTap: () {
                                          if (webLandingPageController
                                              .aboveCardIndex
                                              .value <
                                              testimonialController
                                                  .getTestimonial
                                                  .length -
                                                  1) {
                                            webLandingPageController
                                                .belowCardIndex
                                                .value =
                                                webLandingPageController
                                                    .aboveCardIndex
                                                    .value;
                                            webLandingPageController
                                                .aboveCardIndex
                                                .value++;
                                          } else {
                                            webLandingPageController
                                                .belowCardIndex
                                                .value =
                                                testimonialController
                                                    .getTestimonial
                                                    .length -
                                                    1;
                                            webLandingPageController
                                                .aboveCardIndex
                                                .value = 0;
                                          }
                                          setState(() {});
                                          _animationController
                                              .reset();
                                          Future.delayed(
                                              const Duration(
                                                  seconds: 0), () {
                                            _animationController
                                                .forward(from: 0)
                                                .whenComplete(() {
                                              _animationController
                                                  .reverse(
                                                from: 1,
                                              );
                                              // stop = false;
                                            });
                                          });
                                        },
                                        child: const Icon(
                                          Icons
                                              .arrow_circle_right_outlined,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: Get.width > 1500 ? 550 : 500,
                            // color: Colors.yellowAccent,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              Get.width > 1000 ? 42 : 37),
                                          child: AnimatedBuilder(
                                            animation: _rotationAnimation,
                                            builder: (context, child) {
                                              return Transform.rotate(
                                                angle: _rotationAnimation
                                                    .value * 0.33,
                                                transformHitTests: true,
                                                child: Transform.rotate(
                                                  angle: -math.pi / 15,
                                                  child: Container(
                                                      height: Get.width > 1500
                                                          ? 450
                                                          : Get.width > 1000
                                                          ? 400
                                                          : 400,
                                                      width: Get.width > 1500
                                                          ? 285
                                                          : Get.width > 1000
                                                          ? 250
                                                          : Get.width > 600
                                                          ? 250
                                                          : 200,
                                                      decoration: BoxDecoration(
                                                        // color: Colors.blue,
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .blackColor,
                                                              width: 1),
                                                          borderRadius: const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20))),
                                                      child: buildMediaWidget(
                                                          testimonialController
                                                              .getTestimonial[webLandingPageController
                                                              .belowCardIndex
                                                              .value]['banner_mediatype']
                                                              .toString(),
                                                          testimonialController
                                                              .getTestimonial[webLandingPageController
                                                              .belowCardIndex
                                                              .value]['banner']
                                                              .toString())

                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          left: 10,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                Get.width > 1000
                                                    ? 42
                                                    : 35),
                                            child: AnimatedBuilder(
                                              animation: _rotationAnimation1,
                                              builder: (context, child) {
                                                return Transform.rotate(
                                                  origin: const Offset(
                                                      0, 100),
                                                  angle: -_rotationAnimation
                                                      .value * 0.2,
                                                  child: Container(
                                                      height: Get.width > 1500
                                                          ? 450
                                                          : Get.width > 1000
                                                          ? 400
                                                          : 400,
                                                      // width: Get.width > 1500 ? 200
                                                      //     : Get.width > 1000 ? 200
                                                      //     : Get.width > 600 ? 200 : 200,
                                                      width: Get.width > 1500
                                                          ? 285
                                                          : Get.width > 1000
                                                          ? 250
                                                          : Get.width > 600
                                                          ? 250
                                                          : 200,
                                                      decoration: BoxDecoration(
                                                        // color: Colors.blue,
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .blackColor,
                                                              width: 1),
                                                          borderRadius: const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20))),
                                                      child: buildMediaWidget(
                                                          testimonialController
                                                              .getTestimonial[webLandingPageController
                                                              .aboveCardIndex
                                                              .value]['banner_mediatype']
                                                              .toString(),
                                                          testimonialController
                                                              .getTestimonial[webLandingPageController
                                                              .aboveCardIndex
                                                              .value]['banner']
                                                              .toString())

                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                )
                    : Obx(() {
                  return testimonialController.getTestimonial.isEmpty ||
                      webLandingPageController.aboveCardIndex.value
                          .toString()
                          .isEmpty
                      ? const SizedBox()
                      : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2)),
                    padding:  EdgeInsets.all(Get.width > 500 ?25:10),
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
                              child: SizedBox(
                                height: 400,
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
                                                  decoration: BoxDecoration(
                                                    // color: Colors.blue,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .blackColor,
                                                          width: 1),
                                                      borderRadius: const BorderRadius
                                                          .all(
                                                          Radius.circular(20))),
                                                  child: buildMediaWidget(
                                                      testimonialController
                                                          .getTestimonial[webLandingPageController
                                                          .belowCardIndex
                                                          .value]['banner_mediatype']
                                                          .toString(),
                                                      testimonialController
                                                          .getTestimonial[webLandingPageController
                                                          .belowCardIndex
                                                          .value]['banner']
                                                          .toString())
                                              ),
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
                                                  decoration: BoxDecoration(
                                                    // color: Colors.blue,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .blackColor,
                                                          width: 1),
                                                      borderRadius: const BorderRadius
                                                          .all(
                                                          Radius.circular(20))),
                                                  child: buildMediaWidget(
                                                      testimonialController
                                                          .getTestimonial[webLandingPageController
                                                          .aboveCardIndex
                                                          .value]['banner_mediatype']
                                                          .toString(),
                                                      testimonialController
                                                          .getTestimonial[webLandingPageController
                                                          .aboveCardIndex
                                                          .value]['banner']
                                                          .toString())

                                              ),


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
                        const SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                    webLandingPageController.aboveCardIndex.value =
                                        testimonialController.getTestimonial
                                            .length - 1;
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
                                  // if (webLandingPageController.aboveCardIndex.value < clientsTestimonial.length - 1) {
                                  if (webLandingPageController.aboveCardIndex
                                      .value <
                                      testimonialController.getTestimonial.length -
                                          1) {
                                    webLandingPageController
                                        .belowCardIndex.value =
                                        webLandingPageController
                                            .aboveCardIndex.value;
                                    webLandingPageController
                                        .aboveCardIndex.value++;
                                  } else {
                                    // webLandingPageController.belowCardIndex.value = clientsTestimonial.length - 1;
                                    webLandingPageController.belowCardIndex.value =
                                        testimonialController.getTestimonial
                                            .length - 1;
                                    webLandingPageController.aboveCardIndex.value =
                                    0;
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
                        const SizedBox(height: 15),
                        Text(
                          // StaticString.loremIpsum,
                          "${testimonialController
                              .getTestimonial[webLandingPageController
                              .aboveCardIndex.value]['Description']}",
                          maxLines: 13,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // "ABC & Co.",
                          "${testimonialController
                              .getTestimonial[webLandingPageController
                              .aboveCardIndex.value]["company_name"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${testimonialController
                                  .getTestimonial[webLandingPageController
                                  .aboveCardIndex.value]['user_name']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text(
                              " - ${testimonialController
                                  .getTestimonial[webLandingPageController
                                  .aboveCardIndex.value]['Position']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                }),

                editController
                    .allDataResponse[0]["testimonials_details"][0]["testimonial2_visible"] ==
                    "hide"
                    ? const SizedBox()
                    : const SizedBox(height: 40),

                ///Contact buttons
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Get.width > 400 ?  commonIconButton(
                            onTap: appOpen,
                            icon: Icons.phone_android,
                            title: "Create Your App",
                            btnColor:
                            Colors.redAccent.withOpacity(0.7),
                            txtColor: Colors.white)
                        :commonIconButtonMedium(
                            onTap: appOpen,
                            icon: Icons.phone_android,
                            title: "Create Your App",
                            btnColor:
                            Colors.redAccent.withOpacity(0.7),
                            txtColor: Colors.white),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(2)),
                              color: editController
                                  .allDataResponse[0]["live_app_count_bg"] ==
                                  "hide"
                                  ? AppColors.transparentColor
                                  : Color(int.parse(editController
                                  .allDataResponse[0]["live_app_count_bg_color"]
                                  .toString()),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_red_eye_rounded),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    Obx(() =>
                                        Text("${webLandingPageController
                                            .appLiveCount.value} ",
                                            style: GoogleFonts.getFont(
                                                editController
                                                    .allDataResponse[0]["live_app_count_font"]
                                                    .toString()).copyWith(
                                              // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                              //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                              //     : 14,
                                              // fontWeight: FontWeight.w400,
                                                color: Color(int.parse(
                                                    editController
                                                        .allDataResponse[0]["live_app_count_color"]
                                                        .toString()))))),
                                    // Obx(() => Text(" people creating App")),
                                    Text(
                                      editController
                                          .allDataResponse[0]["live_app_count_string"]
                                          .toString(),
                                      style: GoogleFonts.getFont(editController
                                          .allDataResponse[0]["live_app_count_font"]
                                          .toString()).copyWith(
                                        // fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                        //     ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                        //     : 14,
                                        // fontWeight: FontWeight.w400,
                                          color: Color(int.parse(editController
                                              .allDataResponse[0]["live_app_count_color"]
                                              .toString()))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(fit: BoxFit.scaleDown,
                          child: Get.width > 400 ? commonIconButton(
                              onTap: websiteOpen,
                              icon: Icons.language,
                              title: "Create Your Website",
                              btnColor: Colors.green.withOpacity(0.7),
                              txtColor: Colors.white)
                        :commonIconButtonMedium(
                              onTap: websiteOpen,
                              icon: Icons.language,
                              title: "Create Your Website",
                              btnColor: Colors.green.withOpacity(0.7),
                              txtColor: Colors.white),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(2)),
                              color: editController
                                  .allDataResponse[0]["live_web_count_bg"] ==
                                  "hide"
                                  ? AppColors.transparentColor
                                  : Color(int.parse(editController
                                  .allDataResponse[0]["live_web_count_bg_color"]
                                  .toString()),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_red_eye_rounded),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    Obx(() =>
                                        Text("${webLandingPageController
                                            .webLiveCount.value} ",
                                          style: GoogleFonts.getFont(
                                              editController
                                                  .allDataResponse[0]["live_web_count_font"]
                                                  .toString()).copyWith(
                                            // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                            //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                            //     : 14,
                                            // fontWeight: FontWeight.w400,
                                              color: Color(int.parse(
                                                  editController
                                                      .allDataResponse[0]["live_web_count_color"]
                                                      .toString()))),)),
                                    // Obx(() => Text(" people creating App")),
                                    Text(
                                      editController
                                          .allDataResponse[0]["live_web_count_string"]
                                          .toString(),
                                      style: GoogleFonts.getFont(editController
                                          .allDataResponse[0]["live_web_count_font"]
                                          .toString()).copyWith(
                                        // fontSize: editController.allDataResponse[0]["live_web_count_size"].toString() ==""
                                        //     ? double.parse(editController.allDataResponse[0]["live_web_count_size"].toString())
                                        //     : 14,
                                        // fontWeight: FontWeight.w400,
                                          color: Color(int.parse(editController
                                              .allDataResponse[0]["live_web_count_color"]
                                              .toString()))),
                                    ),

                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///Commented
                    // commonIconButton(
                    //     icon: Icons.perm_phone_msg_sharp,
                    //     title: "Chat to our expert",
                    //     btnColor: Colors.blue.withOpacity(0.7),
                    //     txtColor: Colors.white),

                    Get.width > 400 ? commonIconButton(
                        onTap: seePricingOnTap(context),
                        icon: Icons.currency_rupee_rounded,
                        title: "See Pricing Plans",
                        btnColor: Colors.green.withOpacity(0.7),
                        txtColor: Colors.white)
                    :commonIconButtonMedium(
                        onTap: seePricingOnTap(context),
                        icon: Icons.currency_rupee_rounded,
                        title: "See Pricing Plans",
                        btnColor: Colors.green.withOpacity(0.7),
                        txtColor: Colors.white),
                    // const SizedBox(width: 30,height: 30),
                  ],
                ),

                ///Blog Starts
                const SizedBox(height: 40),
                Padding(
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
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                      Expanded(
                        child:
                        Center(
                          child: Text(
                            editController
                                .allDataResponse[0]["testimonials_details"][0]["Blog_title"]
                                .toString(),
                            style: GoogleFonts.getFont(editController
                                .allDataResponse[0]["testimonials_details"][0]["Blog_title_font"]
                                .toString()).copyWith(
                                fontSize: editController
                                    .allDataResponse[0]["testimonials_details"][0]["Blog_title_size"]
                                    .toString() != ""
                                    ? double.parse(editController
                                    .allDataResponse[0]["testimonials_details"][0]["Blog_title_size"]
                                    .toString())
                                    : Get.width > 1000
                                    ? 50
                                    : Get.width > 550
                                    ? 30
                                    : 20,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(editController
                                    .allDataResponse[0]["testimonials_details"][0]["Blog_title_color"]
                                    .toString()))),
                            textAlign: TextAlign.center,

                            // style: GoogleFonts.getFont(selectedFont).copyWith(
                            //     color: Color(int.parse(introSecController.introMainTitleColor.value))),
                          ),
                        ),
                      ),
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                ///carousel
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Get.width < 504
                        ? const SizedBox()
                        : IconButton(
                      onPressed: () {
                        // Use the controller to change the current page
                        landingPageController.blogCarouselController
                            .previousPage();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),

                    Container(
                      height: Get.width > 1500
                          ? 300
                          : Get.width > 1000
                          ? 275
                          : Get.width > 600
                          ? 250
                          : 200,
                      width: Get.width > 1500
                          ? Get.width - Get.width * 0.16
                          : Get.width > 1000
                          ? Get.width - Get.width * 0.15
                          : Get.width > 500
                          ? Get.width - Get.width * 0.2
                          : Get.width - 50,

                      alignment: Alignment.center,

                      // padding: EdgeInsets.symmetric(vertical: 50),
                      child: CarouselSlider(
                        carouselController:
                        landingPageController.blogCarouselController,
                        // Give the controller
                        options: CarouselOptions(
                          height: Get.width > 1500
                              ? 325
                              : Get.width > 1000
                              ? 300
                              : Get.width > 600
                              ? 255
                              : 205,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          // viewportFraction: 0.4,
                          viewportFraction: Get.width > 1300
                              ? 0.3
                              : Get.width > 1000
                              ? 0.305
                              : Get.width > 700
                              ? 0.35
                              : Get.width < 500
                              ? 0.89
                              : 0.8,
                          autoPlay: true,
                        ),
                        items: blogController.blogdata.map((featuredImage) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      BlogDetailsScreen(
                                        id: featuredImage["blog_auto_id"],
                                        blogTypeKey: featuredImage["blogTypeKey"],
                                        title: featuredImage["title"],
                                        content: featuredImage["content"],
                                        name: featuredImage["userName"],
                                        media: featuredImage["media"],
                                        blogType: featuredImage["blogTypeKey"],
                                        mediaType: featuredImage["media_type"],
                                        profileImg: featuredImage["userImage"],
                                        bgColor: featuredImage["blogs_section_color"],
                                        blogDetails: List<
                                            Map<String, String>>.from(
                                            featuredImage["blog_details"]
                                                .map((detail) =>
                                            Map<String, String>.from(detail))),
                                      )));
                            },
                            child: Container(
                              // width: 400,
                              width: Get.width > 1500
                                  ? 400
                                  : Get.width > 1000
                                  ? 375
                                  // ? 400
                                  : Get.width > 700
                                  ? 375
                                  : Get.width < 500
                                  ? Get.width - 30
                                  : 400,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                  color: AppColors.whiteColor.withOpacity(0.8),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                              margin: const EdgeInsets.only(right: 5, left: 5),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${featuredImage["title"]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                      child: Text(
                                        "${featuredImage["content"]}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 8,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w200),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text("Read more",
                                      style: AppTextStyle.regular400
                                          .copyWith(
                                          color: AppColors.blueColor),),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius
                                                .all(
                                                Radius.circular(50)),
                                            child: CachedNetworkImage(
                                              imageUrl: APIString
                                                  .latestmediaBaseUrl +
                                                  featuredImage["userImage"]
                                                      .toString(),
                                              fit: BoxFit.cover,
                                              width: 30,
                                              height: 30,
                                              placeholder: (context,
                                                  url) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          int.parse(
                                                              editController
                                                                  .appDemoBgColor
                                                                  .value
                                                                  .toString())),
                                                    ),
                                                  ),
                                              errorWidget: (context,
                                                  url, error) =>
                                              const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0),
                                        child: Text(
                                            "${featuredImage["userName"]}",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Padding(
                                  //   padding:
                                  //   const EdgeInsets.only(left: 8.0, bottom: 8,right: 8.0),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment: MainAxisAlignment.start,
                                  //         children: [
                                  //           Container(
                                  //             height: 30,
                                  //             width: 30,
                                  //             child: Center(
                                  //               child: ClipRRect(
                                  //                 borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  //                 child: CachedNetworkImage(
                                  //                   imageUrl: APIString.latestmediaBaseUrl +featuredImage["userImage"].toString(),
                                  //                   fit: BoxFit.cover,
                                  //                   width: 30,
                                  //                   height: 30,
                                  //                   placeholder: (context, url) => Container(
                                  //                     decoration: BoxDecoration(
                                  //                       color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                  //                     ),
                                  //                   ),
                                  //                   errorWidget: (context, url, error) => const Icon(Icons.error),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //
                                  //           const SizedBox(width: 8),
                                  //
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(top: 0),
                                  //             child: Text("${featuredImage["userName"]}"),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       Text("Read more",style: AppTextStyle.regular400.copyWith(color: AppColors.blueColor),)
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Get.width < 504
                        ? const SizedBox()
                        : IconButton(
                      onPressed: () {
                        // Use the controller to change the current page
                        landingPageController.blogCarouselController
                            .nextPage();
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                Get.width > 504
                    ? const SizedBox()
                    : Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Use the controller to change the current page
                          landingPageController.blogCarouselController
                              .previousPage();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      IconButton(
                        onPressed: () {
                          // Use the controller to change the current page
                          landingPageController.blogCarouselController
                              .nextPage();
                        },
                        icon: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                ),

                ///Blog Ends
                const SizedBox(height: 80),
              ],
            ),
          );
        });
      },
    );
  }

   seePricingOnTap(BuildContext context) {
    return Get.width > 950 ? () {
                        if (widget.scrollToPricingSection != null) {
                          widget.scrollToPricingSection!();
                        }
                      }
                      :() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const Material(
                              child: PricingSection(),
                            );
                          },
                        )).whenComplete(() => {
                          Future.delayed(Duration.zero, () {
                            webLandingPageController
                                .getUserCount();
                          })
                        });
                      };
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
      },
      child: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
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

  Widget ytMediaWidget(String mediaType, String bannerMediaType,
      String bannerMedia, String youthtube) {
    if (mediaType == 'normal') {
      if (bannerMediaType == "image" || bannerMediaType == "gif") {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          child: ClipRect(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: 160,
              height: 80,
              imageUrl: APIString.latestmediaBaseUrl + bannerMedia,
              placeholder: (context, url) =>
                  Container(
                    decoration: BoxDecoration(
                      color: Color(int.parse(
                          editController.appDemoBgColor.value.toString())),
                    ),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      } else {
        return ytVideo(bannerMedia);
      }
    } else if (mediaType == 'youthtube') {
      return displayYoutubeVideo(youthtube);
    } else {
      return Container();
    }
  }

  Widget ytVideo(String videoUrl, {double width = 200}) {
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + videoUrl));
    bool isVideoPlaying = false;

    const double videoAspectRatio = 16 / 9;

    return InkWell(
      onTap: () {
        if (controller.value.isPlaying) {
          isVideoPlaying = false;
          controller.pause();
        } else {
          controller.play();
          isVideoPlaying = true;
        }
      },
      child: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final double height = width / videoAspectRatio;
            return SizedBox(
              width: width,
              height: height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(controller),
                  if (!isVideoPlaying)
                    Icon(
                      Icons.play_circle_fill,
                      size: 30,
                      color: Colors.white.withOpacity(0.7),
                    ),
                ],
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

  Widget displayYoutubeVideo(String videoUrl,) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: const YoutubePlayerFlags(
        loop: true,
        autoPlay: true,
        mute: false,
      ),
    );

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        width: 160,

      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget buildMediaWidget(String bannerMediaType, String bannerMedia) {
    if (bannerMediaType == "image" || bannerMediaType == "gif") {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: Get.width * 0.9,
          imageUrl: APIString.latestmediaBaseUrl + bannerMedia,
          placeholder: (context, url) =>
              Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(
                      editController.appDemoBgColor.value.toString())),
                ),
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    } else if (bannerMediaType == "video") {
      return displayUploadedVideo(bannerMedia);
    } else {
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