import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/all_blogs_list.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_details_screen.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
import 'dart:math' as math;
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../config/app_string.dart';
import '../../../../../widget/common_button.dart';
import '../../../../../widget/edit_text_dialog.dart';
import '../../edit_controller/edit_controller.dart';
import '../../edit_controller/intro_section_controller.dart';
import '../edit_intro_section/edit_intro_controller.dart';
import 'EditTestimonal.dart';
import 'edit_testimonalScreen.dart';


class EditTestimonialsSection extends StatefulWidget {
  const EditTestimonialsSection({Key? key}) : super(key: key);

  @override
  State<EditTestimonialsSection> createState() =>
      _EditTestimonialsSectionState();
}

class _EditTestimonialsSectionState extends State<EditTestimonialsSection>
    with SingleTickerProviderStateMixin {
  final webLandingPageController = Get.find<WebLandingPageController>();

  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _rotationAnimation1;
  Animation<double>? _animation;
  final introSecController = Get.find<IntroSectionController>();
  final editController = Get.find<EditController>();
  final editIntroController = Get.find<EditIntroController>();
  final testimonialController = Get.find<EditTestimonialController>();
  final blogController = Get.find<EditBlogController>();
  List<dynamic> rawData = []; // fetched data

  oneTimeAnimation() {
    if (mounted) {
      _animationController.forward();
      Future.delayed(const Duration(seconds: 2), () {
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


    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.785398).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _rotationAnimation1 = Tween<double>(begin: -1, end: 0.785398).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    oneTimeAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool change = false;
  bool stop = false;

  final landingPageController = Get.find<WebLandingPageController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty &&
              editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
            // decoration: BoxDecoration(color: AppColors.bgOrange.withOpacity(0.3)),
              decoration: editController
                  .allDataResponse[0]["case_study_details"][0]["case_study_bg_color_switch"]
                  .toString() == "1" &&
                  editController
                      .allDataResponse[0]["case_study_details"][0]["case_study_bg_image_switch"]
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
                        editController
                            .allDataResponse[0]["testimonials_details"]
                        [0]["testimonials_bg_image"]
                            .toString(),
                    errorListener: () => const Icon(Icons.error),),
                      fit: BoxFit.cover)
              ),

              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: editController.testimonials
                                .value,
                            onChanged: (value) {
                              setState(() {
                                editController.testimonials.value = value;
                                print("value ---- $value");
                                editController.showHideComponent(
                                    value: value == false
                                        ? "No"
                                        : "Yes",
                                    componentName: "testimonials");
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
                                                    icon: const Icon(
                                                      Icons.close,
                                                    )),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        ColorPickDialog(
                                                          // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                          // containerColor: Color(int.parse(editController.showcaseAppsBgColor.value.toString())),
                                                          containerColor: Color(
                                                              int.parse(
                                                                  editController
                                                                      .allDataResponse[0]["testimonials_details"][0][
                                                                  "testimonials_bg_color"]
                                                                      .toString())),
                                                          keyNameClr:
                                                          "testimonials_bg_color",
                                                          clrSwitchValue: "1",
                                                          imgSwitchValue: "0",
                                                          switchKeyNameImg:
                                                          "testimonials_bg_image_switch",
                                                          switchKeyNameClr:
                                                          "testimonials_bg_color_switch",
                                                        ));
                                                  },
                                                  child: const Text(
                                                      "Color Picker")),
                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        ImgPickDialog(
                                                          keyNameImg:
                                                          "testimonials_bg_image",
                                                          switchKeyNameImg:
                                                          "testimonials_bg_image_switch",
                                                          switchKeyNameClr:
                                                          "testimonials_bg_color_switch",
                                                        ));
                                                  },
                                                  child: const Text(
                                                      "Image Picker"))
                                            ],
                                          )),
                                    );
                                  },
                                );
                              },
                              child: const Icon(Icons.colorize)),
                        ],
                      )),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,
                            vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10)),
                            color: AppColors.greyBorderColor.withOpacity(0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Customer Logos Visibility",
                              style: AppTextStyle.regular500.copyWith(
                                  fontSize: 14),),
                            const SizedBox(width: 5,),
                            Switch(
                              value: testimonialController
                                  .testimonial_title_1_Switch.value,
                              onChanged: (value) {
                                setState(() {
                                  testimonialController
                                      .testimonial_title_1_Switch.value = value;
                                  print("value ---- $value");
                                  editController.showHideMedia(
                                      value: value == false
                                          ? "hide"
                                          : "show",
                                      keyName: "testimonials_title1_visible");
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  Row(
                    children: [
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                      Expanded(
                        child:

                        InkWell(
                          onTap: () =>
                              Get.dialog(
                                  TextEditModule(
                                    textKeyName: "testimonials_title1",
                                    colorKeyName: "testimonials_title1_color",
                                    fontFamilyKeyName: "testimonials_title1_font",
                                    textValue: editController
                                        .allDataResponse[0]["testimonials_details"][0]["testimonials_title1"]
                                        .toString(),
                                    fontFamily: editController
                                        .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_font"]
                                        .toString(),
                                    fontSize: editController
                                        .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_size"]
                                        .toString(),
                                    textColor: Color(int.parse(editController
                                        .allDataResponse[0]["testimonials_details"][0]["testimonials_title1_color"]
                                        .toString())),
                                  )),
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
                      ),
                      Get.width > 500 ? const SizedBox()
                          : const SizedBox(width: 10),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (
                                    context) => const EditTestimonalScreen()));
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
                                  Text("Edit App logos")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
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
                              itemCount: testimonialController.appLogoList
                                  .length,
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

                  const SizedBox(height: 40),

                  ///edit testimonial button
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (
                                context) => const EditTestimonalScreenList()));
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
                              Text("Edit Testimonals")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///testimonial 1 starts
                  ///our testimonial
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,
                            vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10)),
                            color: AppColors.greyBorderColor.withOpacity(0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Testimonial 1 Visibility",
                              style: AppTextStyle.regular500.copyWith(
                                  fontSize: 14),),
                            const SizedBox(width: 5,),
                            Switch(
                              value: testimonialController.testimonial1Switch
                                  .value,
                              onChanged: (value) {
                                setState(() {
                                  testimonialController.testimonial1Switch
                                      .value = value;
                                  print("value ---- $value");
                                  editController.showHideMedia(
                                      value: value == false
                                          ? "hide"
                                          : "show",
                                      keyName: "testimonial1_visible");
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                          // Text(
                          //   "Client Stories (Testimonials)",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     // fontSize: 40,
                          //     // fontSize: Get.width >1000 ?50:30,
                          //       fontSize: Get.width > 500 ? 24 : 20,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black),
                          // ),
                          InkWell(
                            onTap: () =>
                                Get.dialog(
                                    TextEditModule(
                                      textKeyName: "testimonials1_title",
                                      colorKeyName: "testimonials1_title_color",
                                      fontFamilyKeyName: "testimonials1_title_font",
                                      textValue: editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials1_title"]
                                          .toString(),
                                      fontFamily: editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials1_title_font"]
                                          .toString(),
                                      fontSize: editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials1_title_size"]
                                          .toString(),
                                      textColor: Color(int.parse(editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials1_title_color"]
                                          .toString())),
                                    )),
                            child: Center(
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
                        ),
                        Get.width > 500 ? const SizedBox()
                            : const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
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
                            autoPlayAnimationDuration: const Duration(
                                seconds: 1),
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
                                  color: AppColors.redColor.withOpacity(0.2),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  ytMediaWidget(
                                    featuredImage['media_type'].toString(),
                                    featuredImage['banner_mediatype']
                                        .toString(),
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
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius
                                                .all(Radius.circular(50)),
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
                                      // Container(
                                      //   height: 30,
                                      //   width: 30,
                                      //   decoration: const BoxDecoration(
                                      //       color: Colors.blue,
                                      //       borderRadius: BorderRadius.all(
                                      //
                                      //           Radius.circular(5))),
                                      //   child: Image.asset(
                                      //       "${featuredImage["clientImage"]}"),
                                      // ),
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
                  Get.width > 505
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

                  ///testimonial 1 ends

                  const SizedBox(height: 40),

                  ///testimonial 2 starts
                    ///inspired testimonial
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,
                            vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10)),
                            color: AppColors.greyBorderColor.withOpacity(0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Testimonial 2 Visibility",
                              style: AppTextStyle.regular500.copyWith(
                                  fontSize: 14),),
                            const SizedBox(width: 5),
                            Switch(
                              value: testimonialController.testimonial2Switch
                                  .value,
                              onChanged: (value) {
                                setState(() {
                                  testimonialController.testimonial2Switch
                                      .value = value;
                                  print("value ---- $value");
                                  editController.showHideMedia(
                                      value: value == false
                                          ? "hide"
                                          : "show",
                                      keyName: "testimonial2_visible");
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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

                          InkWell(
                            onTap: () =>
                                Get.dialog(
                                    TextEditModule(
                                      textKeyName: "testimonials2_title",
                                      colorKeyName: "testimonials2_title_color",
                                      fontFamilyKeyName: "testimonials2_title_font",
                                      textValue: editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials2_title"]
                                          .toString(),
                                      fontFamily: editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials2_title_font"]
                                          .toString(),
                                      fontSize: editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials2_title_size"]
                                          .toString(),
                                      textColor: Color(int.parse(editController
                                          .allDataResponse[0]["testimonials_details"][0]["testimonials2_title_color"]
                                          .toString())),
                                    )),
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
                        ),
                        Get.width > 500 ? const SizedBox()
                            : const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Get.width > 800
                      ? Container(
                    // height: 600,
                    height: 600,
                    width: Get.width > 1500
                        ? 800
                        : Get.width > 1000
                        ? 950
                        : Get.width > 800
                        ? 750
                        : Get.width > 600
                        ? 500
                        : 450,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2)),
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      children: [
                        Obx(() {
                          return webLandingPageController.aboveCardIndex.value
                              .toString()
                              .isEmpty ||
                              testimonialController.getTestimonial.isEmpty
                              ? const SizedBox()
                              : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child:
                              Column(
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
                                  ) ,
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
                                        // "Mr Gary",
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
                                        " -${testimonialController
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
                                          print(
                                              "1111111111111${webLandingPageController
                                                  .aboveCardIndex.value}");
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
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: Get.width > 1500 ? 550 : 500,
                            // color: Colors.yellowAccent,
                            child: Obx(() {
                              return webLandingPageController.aboveCardIndex.value.toString().isEmpty
                                  ? const SizedBox()
                                  : Center(
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
                                                        // width: Get.width > 1500 ? 285
                                                        //     : Get.width > 1000 ? 250
                                                        //         : Get.width > 600 ? 200 : 200,
                                                        width: Get.width > 1500
                                                            ? 285
                                                            : Get.width > 1000
                                                            ? 250
                                                            : Get.width > 600
                                                            ? 250
                                                            : 200,
                                                        decoration: BoxDecoration(
                                                          // color: Colors.blue,
                                                            border: Border.all(color: AppColors.blackColor,width: 1),
                                                            borderRadius: const BorderRadius.all(Radius.circular(20))),
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
                                                        width: Get.width > 1500
                                                            ? 285
                                                            : Get.width > 1000
                                                            ? 250
                                                            : Get.width > 600
                                                            ? 250
                                                            : 200,
                                                        decoration: BoxDecoration(
                                                          // color: Colors.blue,
                                                            border: Border.all(color: AppColors.blackColor,width: 1),
                                                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                        child:
                                                        ClipRRect(
                                                            borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    20)),

                                                            child:
                                                            buildMediaWidget(
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
                                                        )
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
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Obx(() {
                    return webLandingPageController.aboveCardIndex.value
                        .toString()
                        .isEmpty
                        ? const SizedBox()
                        : Container(
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
                                                      border: Border.all(color: AppColors.blackColor,width: 1),
                                                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),

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
                                                      border: Border.all(color: AppColors.blackColor,width: 1),
                                                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),

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
                          const SizedBox(height: 10),
                          Text(
                            // StaticString.loremIpsum,
                            "${testimonialController
                                .getTestimonial[webLandingPageController.aboveCardIndex.value]['Description']}",
                            maxLines: 13,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${testimonialController
                                .getTestimonial[webLandingPageController
                                .aboveCardIndex.value]["company_name"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          const SizedBox(height: 10),
                          Row(
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
                                  webLandingPageController
                                      .belowCardIndex.value = 0;
                                  webLandingPageController
                                      .aboveCardIndex.value =
                                      testimonialController.getTestimonial
                                          .length - 1;
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
                                print("1111111111111${webLandingPageController.aboveCardIndex.value}");
                                if (webLandingPageController
                                    .aboveCardIndex.value <
                                    testimonialController.getTestimonial.length -
                                        1) {
                                  webLandingPageController
                                      .belowCardIndex.value =
                                      webLandingPageController
                                          .aboveCardIndex.value;
                                  webLandingPageController
                                      .aboveCardIndex.value++;
                                  setState(() {

                                  });
                                } else {
                                  webLandingPageController
                                      .belowCardIndex.value =
                                      testimonialController.getTestimonial
                                          .length - 1;
                                  webLandingPageController
                                      .aboveCardIndex.value = 0;
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

                  const SizedBox(height: 40),

                  ///testimonial 2 ends
                  ///contact buttons
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      // commonIconButton(
                      //     icon: Icons.perm_phone_msg_sharp,
                      //     title: "Chat to our expert",
                      //     btnColor: Colors.blue.withOpacity(0.7),
                      //     txtColor: Colors.white),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          commonIconButton(
                              onTap: () async {
                                html.window.open(
                                    AppString.playStoreAppLink, "_blank");
                              },
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
                            child: commonIconButton(
                                onTap: () {
                                  html.window.open(
                                      AppString.websiteLink, "_blank");
                                },
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
                      // commonIconButton(
                      //   // icon: Icons.start_rounded,
                      //     icon: Icons.touch_app_rounded,
                      //     title: "Get Started",
                      //     btnColor: Colors.redAccent.withOpacity(0.7),
                      //     txtColor: Colors.white),
                      ///Commented
                      // commonIconButton(
                      //     icon: Icons.perm_phone_msg_sharp,
                      //     title: "Chat to our expert",
                      //     btnColor: Colors.blue.withOpacity(0.7),
                      //     txtColor: Colors.white),

                      commonIconButton(
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
                          // child: Text(
                          //   "Blogs",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     // fontSize: 40,
                          //     //   fontSize: Get.width >1000 ?50:30,
                          //       fontSize: 24,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black),
                          // ),
                          InkWell(
                            onTap: () =>
                                Get.dialog(
                                    TextEditModule(
                                      textKeyName: "Blog_title",
                                      colorKeyName: "Blog_title_color",
                                      fontFamilyKeyName: "Blog_title_font",
                                      textValue: editController
                                          .allDataResponse[0]["testimonials_details"][0]["Blog_title"]
                                          .toString(),
                                      fontFamily: editController
                                          .allDataResponse[0]["testimonials_details"][0]["Blog_title_font"]
                                          .toString(),
                                      fontSize: editController
                                          .allDataResponse[0]["testimonials_details"][0]["Blog_title_size"]
                                          .toString(),
                                      textColor: Color(int.parse(editController
                                          .allDataResponse[0]["testimonials_details"][0]["Blog_title_color"]
                                          .toString())),
                                    )),
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
                                      : 30,
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
                            ? 325
                            : Get.width > 1000
                            ? 300
                            : Get.width > 600
                            ? 255
                            : 205,
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
                                ? 250
                                : Get.width > 1000
                                ? 250
                                : Get.width < 500
                                ? 250
                                : 230,
                            autoPlayAnimationDuration: const Duration(
                                seconds: 1),
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
                                              Map<String, String>.from(
                                                  detail))),

                                        )));
                              },
                              child: Container(
                                // width: 400,
                                width: Get.width > 1500
                                    ? 400
                                    : Get.width > 1000
                                    ? 375
                                    : Get.width > 700
                                    ? 375
                                    : Get.width < 500
                                    ? Get.width - 30
                                    : 400,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor.withOpacity(
                                        0.8),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(20))),
                                margin: const EdgeInsets.only(
                                    right: 5, left: 5),
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
                                          // overflow: TextOverflow.ellipsis,
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
                                        Container(
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
                                              "${featuredImage["userName"]}"),
                                        ),
                                      ],
                                    ),
                                    // Padding(
                                    //   padding:
                                    //   const EdgeInsets.only(
                                    //       left: 8.0, bottom: 8, right: 8.0),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment
                                    //         .spaceBetween,
                                    //     children: [
                                    //       Row(
                                    //         mainAxisAlignment: MainAxisAlignment
                                    //             .start,
                                    //         children: [
                                    //           Container(
                                    //             height: 30,
                                    //             width: 30,
                                    //             child: Center(
                                    //               child: ClipRRect(
                                    //                 borderRadius: const BorderRadius
                                    //                     .all(
                                    //                     Radius.circular(50)),
                                    //                 child: CachedNetworkImage(
                                    //                   imageUrl: APIString
                                    //                       .latestmediaBaseUrl +
                                    //                       featuredImage["userImage"]
                                    //                           .toString(),
                                    //                   fit: BoxFit.cover,
                                    //                   width: 30,
                                    //                   height: 30,
                                    //                   placeholder: (context,
                                    //                       url) =>
                                    //                       Container(
                                    //                         decoration: BoxDecoration(
                                    //                           color: Color(
                                    //                               int.parse(
                                    //                                   editController
                                    //                                       .appDemoBgColor
                                    //                                       .value
                                    //                                       .toString())),
                                    //                         ),
                                    //                       ),
                                    //                   errorWidget: (context,
                                    //                       url, error) =>
                                    //                   const Icon(Icons.error),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //
                                    //           const SizedBox(width: 8),
                                    //
                                    //           Padding(
                                    //             padding: const EdgeInsets.only(
                                    //                 top: 0),
                                    //             child: Text(
                                    //                 "${featuredImage["userName"]}"),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       Text("Read more",
                                    //         style: AppTextStyle.regular400
                                    //             .copyWith(
                                    //             color: AppColors.blueColor),)
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
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => const BlogListScreen()));
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
                              Text("Edit Blog")
                            ],
                          ),
                        ),
                      ),
                    ),
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
              )
          );
        });
      },
    );
  }

  Widget displayUploadedVideo(String videoUrl) {
    VideoPlayerController _controller = VideoPlayerController.network(
        APIString.latestmediaBaseUrl + videoUrl);
    bool isVideoPlaying = false;

    final double videoAspectRatio = /*_controller.value.aspectRatio > 0 ? _controller.value.aspectRatio :*/ 16 /
        9;

    return InkWell(
      onTap: () {
        if (_controller.value.isPlaying) {
          isVideoPlaying = false;
          _controller.pause();
        } else {
          _controller.play();
          isVideoPlaying = true;
        }
        // isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
                aspectRatio: 16 / 9,
                // aspectRatio: 1 / 6,
                child: Stack(
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
                )
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
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: const YoutubePlayerFlags(
        loop: true,
        autoPlay: true,
        mute: false,
      ),
    );

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
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

  Widget ytMediaWidget(String mediaType, String bannerMediaType,
      String bannerMedia, String youthtube) {
    if (mediaType == 'normal') {
      if (bannerMediaType == "image" || bannerMediaType == "gif") {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
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
        return ytvideo(bannerMedia);
      }
    } else if (mediaType == 'youthtube') {
      return displayYoutubeVideo(youthtube);
    } else {
      return Container();
    }
  }

  Widget ytvideo(String videoUrl, {double width = 200}) {
    VideoPlayerController _controller = VideoPlayerController.network(
        APIString.latestmediaBaseUrl + videoUrl);
    bool isVideoPlaying = false;

    final double videoAspectRatio = 16 / 9;

    return InkWell(
      onTap: () {
        if (_controller.value.isPlaying) {
          isVideoPlaying = false;
          _controller.pause();
        } else {
          _controller.play();
          isVideoPlaying = true;
        }
      },
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final double height = width / videoAspectRatio;
            return SizedBox(
              width: width,
              height: height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
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

}
