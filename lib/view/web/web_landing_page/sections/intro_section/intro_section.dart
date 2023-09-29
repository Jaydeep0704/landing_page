// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/intro_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/case_study_section/case_study_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/how_it_works_section/how_it_works_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/pricing_section/pricing_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/showcase_apps_section/showcase_apps_section.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroSection extends StatefulWidget {
  const IntroSection({Key? key}) : super(key: key);

  @override
  State<IntroSection> createState() => _IntroSectionState();
}

class _IntroSectionState extends State<IntroSection> with TickerProviderStateMixin  {
  final introSecController = Get.find<IntroSectionController>();
  final webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final editIntroController = Get.find<EditIntroController>();

  AnimationController? _animationController;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.introComp.value == false || editController.allDataResponse.isEmpty /*&&*/|| editController.homeComponentList.isEmpty
              ? const SizedBox()
              : Container(
            decoration: editController.allDataResponse[0]["intro_details"][0]["intro_bg_color_switch"].toString() == "1" &&
                editController.allDataResponse[0]["intro_details"][0]["intro_bg_image_switch"].toString() == "0"
                ? BoxDecoration(
              color: editController.allDataResponse[0]
              ["intro_details"][0]["intro_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(int.parse(
                  editController.introBgColor.value.toString()))
                  : Color(int.parse(editController.allDataResponse[0]
              ["intro_details"][0]["intro_bg_color"]
                  .toString())),
            )
                :BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider( APIString.mediaBaseUrl +
                    editController.allDataResponse[0]["intro_details"]
                    [0]["intro_bg_image"]
                        .toString(),
                  errorListener: () =>  const Icon(Icons.error),),fit: BoxFit.cover)
            ),
            width: Get.width,
            child: Column(
              children: [
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(25))),
                        child :  Center(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: CachedNetworkImage(
                              width: Get.width,
                              imageUrl: APIString.mediaBaseUrl +
                                  editController.allDataResponse[0]["intro_details"][0]["Logo_image"]
                                      .toString(),
                              placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                  )),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          ),
                        ),

                      ),

                      Get.width >950?const SizedBox():AnimatedIconButton(
                        size: 30,
                        onPressed: () {
                          _showPopupMenu();
                        },
                        duration: const Duration(milliseconds: 500),
                        splashColor: AppColors.transparentColor,
                        icons: const <AnimatedIconItem>[
                          AnimatedIconItem(
                            icon: Icon(
                              Icons.menu,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.width > 1049 ? Get.height : null,
                  child: Column(
                    mainAxisAlignment: Get.width > 1049
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.start,
                    children: [
                      Get.width > 1049
                          ? const SizedBox()
                          : SizedBox(
                          height: Get.width > 1500
                              ? 75
                              : Get.width > 800
                              ? 60
                              : Get.width > 500
                              ? 50
                              : 40),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width > 1500 ? 60 : Get.width > 1000 ? 22 :  15),
                        child: Get.width > 1000
                            ? Row(
                          children: [
                            Expanded(
                              child:    Text(
                                editController.allDataResponse[0]["intro_details"][0]["intro_main_title"]
                                    .toString(),
                                style: GoogleFonts.getFont(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_font"].toString()).copyWith(
                                    fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString() !=""
                                        ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString())
                                        : Get.width > 1000
                                        ? 50
                                        : Get.width > 550
                                        ? 30
                                        : 20,
                                    fontWeight: FontWeight.bold,
                                    color:  editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString() == ""
                                        ?Colors.black
                                        :Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString()))),
                              ),
                            ),

                            const SizedBox(width: 20),
                            editController.allDataResponse[0]["intro_details"][0]["intro_gif1_show"] == "hide"
                                ?const SizedBox(): Container(
                              height: 300,
                              width: 300,
                              decoration:
                              const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius
                                          .circular(
                                          5))),
                              child: Center(
                                  child: buildGif1Widget()
                              ),
                            ),
                            const SizedBox(width: 40),
                            Column(
                              children: [
                                editController.allDataResponse[0]["intro_details"][0]["intro_bot_file_show"] == "hide"
                                    ?const SizedBox():SizedBox(
                                  height: 120,
                                  width: 120,
                                  child:  Center(
                                    child : buildBotWidget(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                editController.allDataResponse[0]["intro_details"][0]["intro_gif2_show"] == "hide"
                                    ?const SizedBox(): SizedBox(
                                  height: 160,
                                  width: 120,
                                  child: Center(
                                    child : buildGif2Widget(),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              editController.allDataResponse[0]["intro_details"][0]["intro_main_title"]
                                  .toString(),
                              style: GoogleFonts.getFont(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_font"].toString()).copyWith(
                                  fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString() !=""
                                      ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_size"].toString())
                                      : Get.width > 1000
                                      ? 50
                                      : Get.width > 550
                                      ? 30
                                      : 20,
                                  fontWeight: FontWeight.bold,
                                  color:  editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString() == ""
                                      ?Colors.black
                                      :Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_main_title_color"].toString()))),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                editController.allDataResponse[0]["intro_details"][0]["intro_gif1_show"] == "hide"
                                    ?const SizedBox():  Container(
                                  height: Get.width > 500 ? 300 : Get.width > 425 ?250:175,
                                  width: Get.width > 500 ? 300 : Get.width > 425 ?250:175,
                                  decoration:  const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                      child: buildGif1Widget()
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .center,
                                  children: [
                                    editController.allDataResponse[0]["intro_details"][0]["intro_bot_file_show"] == "hide"
                                        ?const SizedBox(): SizedBox(
                                      height: Get.width > 500 ? 120 :Get.width > 425 ? 100 : 75,
                                      width: Get.width > 500 ? 120 :Get.width > 425 ? 100 : 75,
                                      child:  Center(
                                        child : buildBotWidget(),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: 20),
                                    editController.allDataResponse[0]["intro_details"][0]["intro_gif2_show"] == "hide"
                                        ?const SizedBox():  SizedBox(
                                      height: Get.width > 500 ? 160 : Get.width > 425 ? 120 : 90,
                                      width: Get.width > 500 ? 120 :Get.width > 425 ? 100 : 75,
                                      child: Center(
                                        child : buildGif2Widget(),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Get.width > 1049
                          ? const SizedBox()
                          : SizedBox(
                          height: Get.width > 1500 ? 75 : Get.width > 800 ? 60 : Get.width > 500 ? 50 : 40),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width > 1500
                                ? Get.width * 0.4
                                : Get.width > 1000
                                ? Get.width * 0.5
                                : Get.width * 0.6,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                decoration : BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                                    color:  editController.allDataResponse[0]["intro_details"][0]["intro_desc_bg"] == "hide"
                                        ? AppColors.transparentColor
                                        : Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_desc_bg_color"].toString()))),
                                child: Text(
                                  editController.allDataResponse[0]["intro_details"][0]["intro_desc"]
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(editController.allDataResponse[0]["intro_details"][0]["intro_desc_font"].toString()).copyWith(
                                      fontSize: editController.allDataResponse[0]["intro_details"][0]["intro_desc_size"].toString() ==""
                                          ? double.parse(editController.allDataResponse[0]["intro_details"][0]["intro_desc_size"].toString())
                                          : 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(int.parse(editController.allDataResponse[0]["intro_details"][0]["intro_desc_color"].toString()))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Get.width > 1049
                          ? const SizedBox()
                          : const SizedBox(height: 40),
                      Wrap(
                        crossAxisAlignment:
                        WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              commonIconButton(
                                  onTap: appOpen,
                                  icon: Icons.phone_android,
                                  title: "Create Your App",
                                  btnColor: Colors.redAccent
                                      .withOpacity(0.7),
                                  txtColor: Colors.white),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  decoration : BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                                    color: editController.allDataResponse[0]["live_app_count_bg"] == "hide"
                                        ? AppColors.transparentColor
                                        : Color(int.parse(editController.allDataResponse[0]["live_app_count_bg_color"].toString()),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons
                                          .remove_red_eye_rounded),
                                      const SizedBox(width: 8),
                                      Row(
                                        children: [
                                          Obx(() => Text("${webLandingPageController.appLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                              fontSize: editController.allDataResponse[0]["live_app_count_size"].toString() ==""
                                                  ? double.parse(editController.allDataResponse[0]["live_app_count_size"].toString())
                                                  : 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))))),
                                          Text(
                                            editController.allDataResponse[0]["live_app_count_string"].toString(),
                                            style: GoogleFonts.getFont(editController.allDataResponse[0]["live_app_count_font"].toString()).copyWith(
                                               color: Color(int.parse(editController.allDataResponse[0]["live_app_count_color"].toString()))),
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
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              commonIconButton(
                                  onTap: websiteOpen,
                                  icon: Icons.language,
                                  title: "Create Your Website",
                                  btnColor: Colors.green
                                      .withOpacity(0.7),
                                  txtColor: Colors.white),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  decoration : BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                                    color: editController.allDataResponse[0]["live_web_count_bg"] == "hide"
                                        ? AppColors.transparentColor
                                        : Color(int.parse(editController.allDataResponse[0]["live_web_count_bg_color"].toString()),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons
                                          .remove_red_eye_rounded),
                                      const SizedBox(width: 8),
                                      Row(
                                        children: [
                                          Obx(() => Text("${webLandingPageController.webLiveCount.value} ",style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(
                                              color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),)),
                                          Text(
                                            editController.allDataResponse[0]["live_web_count_string"].toString(),
                                            style: GoogleFonts.getFont(editController.allDataResponse[0]["live_web_count_font"].toString()).copyWith(

                                                color: Color(int.parse(editController.allDataResponse[0]["live_web_count_color"].toString()))),
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
                          //     icon: Icons.perm_phone_msg_sharp,
                          //     title: "Chat to our expert",
                          //     btnColor:
                          //         Colors.blue.withOpacity(0.7),
                          //     txtColor: Colors.white),
                        ],
                      ),

                      Get.width > 1049
                          ? const SizedBox()
                          : const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    ));
  }


  void _showPopupMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.blackColor.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          color: AppColors.transparentColor,
          child: Align(
            alignment: Alignment.topRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: Get.width > 500 ?475:Get.width,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.purple,
                          )),
                    ),
                    ///Showcase Apps
                    editController.showcaseApps.value == false ? const SizedBox():ListTile (
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const Material(child:  ShowcaseAppsSection());
                          },)).whenComplete(() => {Navigator.of(context).pop(),
                            Future.delayed(Duration.zero, () {
                              webLandingPageController.getUserCount();
                            })});
                        },
                        title: const Text('Showcase Apps')),
                    editController.howItWorks.value == false ? const SizedBox():ListTile(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) {
                             return const Material(child: HowItWorksSection(),);
                           },)).whenComplete(() => {Navigator.of(context).pop(),
                             Future.delayed(Duration.zero, () {
                               webLandingPageController.getUserCount();
                             })});
                         },
                         title: const Text('How It Works')),
                    editController.caseStudy.value == false ? const SizedBox():ListTile(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) {
                             return const Material(child: CaseStudySection(),);
                           },)).whenComplete(() => {Navigator.of(context).pop(),
                             Future.delayed(Duration.zero, () {
                               webLandingPageController.getUserCount();
                             })});
                         },
                         title: const Text('Case Study')),
                    editController.pricing.value == false ? const SizedBox():ListTile(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) {
                             return const Material(child: PricingSection(),);
                           },)).whenComplete(() => {Navigator.of(context).pop(),
                             Future.delayed(Duration.zero, () {
                               webLandingPageController.getUserCount();
                             })});
                         },
                         title: const Text('Pricing')),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}