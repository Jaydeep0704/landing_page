import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/pricing_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_apps_demo_section/add_latest_project/add_Project_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/edit_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_checkout_section/edit_checkoutController.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_how_it_works_section/edit_hiw_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/showcase_app_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/address_section/address_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/checkout_info_section/CheckOutInfoControllers.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/faqs_section/faqs_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/info_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/intro_section/intro_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/case_study_section/case_study_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/checkout_info_section/checkout_info_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/pricing_section/pricing_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/checkout_section/checkout_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/apps_demo_section/apps_demo_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/showcase_apps_section/showcase_apps_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/how_it_works_section/how_it_works_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/testimonials_section/testimonials_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/text_banner_section/text_banner_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/mix_banner_section/mix_banner_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/benefit_banner_section/benefit_banner_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/numbers_banner_section/numbers_banner_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/help_banner_section/help_banner_section.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';
import 'package:video_player/video_player.dart';

class WebLandingScreen extends StatefulWidget {
  const WebLandingScreen({Key? key}) : super(key: key);

  @override
  State<WebLandingScreen> createState() => _WebLandingScreenState();
}

class _WebLandingScreenState extends State<WebLandingScreen> {
  final benefitBannerController = Get.find<BenefitBannerController>();
  final editCheckOutController = Get.find<EditCheckOutController>();
  final webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();
  final editIntroController = Get.find<EditIntroController>();
  final editHiwController = Get.find<EditHiwController>();
  final numberBannerController = Get.find<NumberBannerController>();
  final mixBannerController = Get.find<MixBannerController>();
  final pricingScreenController = Get.find<PricingScreenController>();
  final getLatestProject = Get.find<AddProjectController>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    editController.showComp1.value = false;
    editController.showComp2.value = false;
    editController.showComp3.value = false;
    editController.showComp4.value = false;
    editController.showComp5.value = false;
    super.initState();
    geComponents();

    getDataFunction();
    planFunc();
    getTestimonialData();
    getShowcaseData();
    getBenefitBannerData();
    getNumbersBannerData();
    getCaseStudyData();
    getCheckoutInfoData();
    getAppDemoData();
    getAddressData();
    KeyboardScroll.addScrollListener(_scrollController);
  }

  showCompOneByOne() {
    Future.delayed(
        const Duration(seconds: 0),
        () => {
              editController.showComp1.value = true,
              initializeVideo(),
              initializeVideoHIW()
            });
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              editController.showComp2.value = true,
              initializeVideoMixBanner(),
              initializeVideobenefitBanner(),
              initializeVideoNumberBanner()
            });
    Future.delayed(
        const Duration(seconds: 4),
        () =>
            {editController.showComp3.value = true, initializeVideCheckOut()});
    Future.delayed(const Duration(seconds: 6),
        () => editController.showComp4.value = true);
  }

  @override
  void dispose() {
    log("dispose called");
    if (editController.allDataResponse.isNotEmpty) {
      log("dispose called when list isNotEmpty");
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_bot_file_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editIntroController.introBotController.pause();
        editIntroController.introBotController.dispose();
        // editIntroController.introBotControllerChewie!.dispose();
      }
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif1_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editIntroController.introGif1Controller.pause();
        editIntroController.introGif1Controller.dispose();
      }
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif2_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editIntroController.introGif2Controller.pause();
        editIntroController.introGif2Controller.dispose();
      }
      //----------how it works
      if (Get.width > 950) {
        if (editController.allDataResponse[0]["how_it_works_details"][0]
                    ["hiw_gif_mediatype"]
                .toString()
                .toLowerCase() ==
            'video') {
          editHiwController.botController.pause();
          editHiwController.botController.dispose();
          editHiwController.botChewieController.dispose();
        }
      }
      //----------mix banner
      if (editController.allDataResponse[0]["mix_banner_details"][0]
                  ["mix_banner_file_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        mixBannerController.videoController.pause();
        mixBannerController.videoController.dispose();
      }
      //----------NUMBER BANNER
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file1_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        numberBannerController.media1Controller.pause();
        numberBannerController.media1Controller.dispose();
      }
      //--------------
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file2_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        numberBannerController.media2Controller.pause();
        numberBannerController.media2Controller.dispose();
      }
      //--------------
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file3_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        numberBannerController.media3Controller.pause();
        numberBannerController.media3Controller.dispose();
      }
    }

    for (var controller in getLatestProject.videoControllers) {
      controller.dispose();
    }

    KeyboardScroll.removeScrollListener();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToPricingSection() {
    final RenderObject? pricingSectionRenderObject =
        PricingSection.pricingSectionKey.currentContext?.findRenderObject();
    if (pricingSectionRenderObject != null) {
      _scrollController.animateTo(
        _scrollController.position.pixels +
            pricingSectionRenderObject.getTransformTo(null).getTranslation().y,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SizedBox(
                width: Get.width,
                child: Obx(() {
                  return editController.allDataResponse.isEmpty &&
                          editController.homeComponentList.isEmpty
                      ? const SizedBox()
                      //   : ListView.builder(
                      // controller: _scrollController,
                      //       itemCount: editController.homeComponentList.length,
                      //       itemBuilder: (context, index) =>
                      //           Container(
                      //             key: ValueKey(editController.homeComponentList[index]),
                      //             child: getComponentUi(editController.homeComponentList[index]["component_name"],keyScroll: PricingSection.pricingSectionKey),
                      //           ));
                      : RawScrollbar(
                          // : Scrollbar(
                          radius: const Radius.circular(20),
                          thumbColor: Colors.blue,
                          controller: _scrollController,
                          trackVisibility: true,
                          thickness: 15,
                          interactive: true,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                editController.showComp1.value == false
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          const IntroSection(),
                                          Get.width < 950
                                              ? const SizedBox()
                                              : const ShowcaseAppsSection(),
                                          Get.width < 950
                                              ? const SizedBox()
                                              : const HowItWorksSection(),
                                          // TestimonialsSection(
                                          //     scrollToPricingSection:
                                          //         scrollToPricingSection),
                                        ],
                                      ),
                                editController.showComp2.value == false
                                    ? const SizedBox()
                                    : Column(
                                        children: const [
                                          TextBannerSection(),
                                          MixBannerSection(),
                                          BenefitBannerSection(),
                                          CheckoutInfoSection(),
                                          NumbersBannerSection(),
                                        ],
                                      ),
                                editController.showComp3.value == false
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          HelpBannerSection(
                                            scrollToPricingSection:
                                                scrollToPricingSection,
                                          ),
                                          Get.width < 950
                                              ? const SizedBox()
                                              : const CaseStudySection(),
                                          /*Get.width < 950
                                              ? const SizedBox()
                                              : */
                                          // const CheckoutInfoSection(),
                                          Get.width < 950
                                              ? const SizedBox()
                                              : PricingSection(
                                                  key: PricingSection
                                                      .pricingSectionKey),
                                        ],
                                      ),
                                editController.showComp4.value == false
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          CheckoutSection(),
                                          AppsDemoSection(),
                                          TestimonialsSection(
                                              scrollToPricingSection:
                                                  scrollToPricingSection),
                                          FAQsSection(),
                                          InfoSection(),
                                          AddressSection(),
                                        ],
                                      ),
                                // editController.showComp1.value == false ||
                                editController.showComp2.value == false ||
                                        editController.showComp3.value ==
                                            false ||
                                        editController.showComp4.value == false
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        );
                }),
              ),
            ));
      },
    );
  }

  ///will be used when implemented reordering
  getComponentUi(homeComponent, {var keyScroll}) {
    if (homeComponent == "intro") {
      return const IntroSection();
    } else if (homeComponent == "showcase_apps") {
      return Get.width > 950 ? const ShowcaseAppsSection() : const SizedBox();
    } else if (homeComponent == "how_it_works") {
      return Get.width > 950 ? const HowItWorksSection() : const SizedBox();
    } else if (homeComponent == "testimonials") {
      return TestimonialsSection(
        scrollToPricingSection: scrollToPricingSection,
      );
    } else if (homeComponent == "text_banner") {
      return const TextBannerSection();
    } else if (homeComponent == "mix_banner") {
      return const MixBannerSection();
    } else if (homeComponent == "benefit_banner") {
      return const BenefitBannerSection();
    } else if (homeComponent == "numbers_banner") {
      return const NumbersBannerSection();
    } else if (homeComponent == "help_banner") {
      return HelpBannerSection(
        scrollToPricingSection: scrollToPricingSection,
      );
    } else if (homeComponent == "case_study") {
      return const CaseStudySection();
    } else if (homeComponent == "checkout_info") {
      return const CheckoutInfoSection();
    } else if (homeComponent == "pricing") {
      // return PricingSection(key: PricingSection.pricingSectionKey);
      return PricingSection(key: keyScroll);
    } else if (homeComponent == "checkout") {
      return const CheckoutSection();
    } else if (homeComponent == "apps_demo") {
      return const AppsDemoSection();
    } else if (homeComponent == "footer_section") {
      return const InfoSection();
    } else if (homeComponent == "address_section") {
      return const AddressSection();
    } else if (homeComponent == "faq_details") {
      return const FAQsSection();
    } else {
      return Container();
    }
  }

  ///initialization of all function and apis

  planFunc() {
    if (Get.width > 950) {
      pricingScreenController.getPlansData(
          lat: "21.2378888", long: "72.863352");
      getUserLocation();
    }
  }

  Future<Position> getUserLocation() async {
    LocationPermission permission;

    // Check if location permission is granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      pricingScreenController.isLocation.value = true;
      pricingScreenController.getPlansData(
        lat: position.latitude.toString(),
        long: position.longitude.toString(),
      );
    } else if (permission == LocationPermission.denied) {
      pricingScreenController.isLocation.value = false;
      pricingScreenController.getPlansData(
          lat: "21.2378888", long: "72.863352");
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        pricingScreenController.isLocation.value = false;
        pricingScreenController.getPlansData(
            lat: "21.2378888", long: "72.863352");
        return Future.error('Location permission denied');
      }
    } else if (permission == LocationPermission.unableToDetermine) {
      pricingScreenController.getPlansData(
          lat: "21.2378888", long: "72.863352");
      pricingScreenController.isLocation.value = false;
    } else if (permission == LocationPermission.deniedForever) {
      pricingScreenController.getPlansData(
          lat: "21.2378888", long: "72.863352");
      pricingScreenController.isLocation.value = false;
    }
    Position position = await Geolocator.getCurrentPosition();
    pricingScreenController.latitude.value = position.latitude.toString();
    pricingScreenController.longitude.value = position.longitude.toString();
    return position;
  }

  getDataFunction() {
    Future.delayed(Duration.zero, () {
      webLandingPageController.getUserCount(isFromInit: true);
    });

    Future.delayed(
      Duration.zero,
      () {
        editController.getData().then((value) {
          showCompOneByOne();
        });
      },
    );
  }

  geComponents() {
    Future.delayed(
      const Duration(microseconds: 20),
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          editController.geComponents();
        });
      },
    );
  }

  getTestimonialData() {
    Future.delayed(
      const Duration(microseconds: 20),
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<EditTestimonialController>().GetAppLogoes();
          Get.find<EditTestimonialController>().GetTestimonal().then((value) {
            webLandingPageController.belowCardIndex.value =
                Get.find<EditTestimonialController>().getTestimonial.length - 1;
          });
          Get.find<EditBlogController>().getBlogData();
        });
      },
    );
  }

  getShowcaseData() {
    if (Get.width < 950) {
      Future.delayed(
        const Duration(microseconds: 25),
        () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.find<ShowCaseAppsController>().getShowCaseApi();
          });
        },
      );
    }
  }

  getBenefitBannerData() {
    Future.delayed(
      const Duration(microseconds: 30),
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          benefitBannerController.getDataApi().whenComplete(() {});
        });
      },
    );
  }

  getNumbersBannerData() {
    Future.delayed(const Duration(microseconds: 35), () {
      numberBannerController.getPartnerLogo();
    });
  }

  getCaseStudyData() {
    if (Get.width > 950) {
      Future.delayed(const Duration(microseconds: 40), () {
        Get.find<EditCaseStudyController>().getCaseStudy();
      });
    }
  }

  getCheckoutInfoData() {
    Future.delayed(const Duration(microseconds: 45), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.find<CheckOutInfoController>().getCheckOutApi();
      });
    });
  }

  getAppDemoData() {
    Future.delayed(const Duration(microseconds: 50), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getLatestProject.getProjectData();
      });
    });
  }

  getAddressData() {
    Future.delayed(const Duration(microseconds: 50), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.find<EditInfoController>().getImages();
      });
    });
  }

  initializeVideo() async {
    if (editController.allDataResponse.isNotEmpty) {
      ///
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_bot_file_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        editIntroController.introBotController =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["intro_details"][0]
                        ["intro_bot_file"]
                    .toString()));
        await editIntroController.introBotController
            .initialize()
            .whenComplete(() {
          editIntroController.introBotController.setLooping(true);
          editIntroController.introBotController.setVolume(0);
          editIntroController.isBotVideoInitialized.value = true;
          editIntroController.introBotController.play();
          setState(() {});
        });
      } else {
        editIntroController.isBotVideoInitialized.value = false;
      }

      ///---------------
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif1_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        editIntroController.introGif1Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["intro_details"][0]
                        ["intro_gif1"]
                    .toString()));
        await editIntroController.introGif1Controller
            .initialize()
            .whenComplete(() {
          editIntroController.introGif1Controller.setLooping(true);
          editIntroController.introGif1Controller.setVolume(0);
          editIntroController.isIntroGif1Initialized.value = true;
          Future.delayed(
            const Duration(seconds: 10),
            () {},
          );
          editIntroController.introGif1Controller.play();
          setState(() {});
        });
      } else {
        editIntroController.isIntroGif1Initialized.value = false;
      }

      ///----------
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif2_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        editIntroController.introGif2Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["intro_details"][0]
                        ["intro_gif2"]
                    .toString()));
        await editIntroController.introGif2Controller
            .initialize()
            .whenComplete(() {
          editIntroController.introGif2Controller.setLooping(true);
          editIntroController.introGif2Controller.setVolume(0);
          editIntroController.isIntroGif2Initialized.value = true;
          editIntroController.introGif2Controller.play();
          setState(() {});
        });
      } else {
        editIntroController.isIntroGif2Initialized.value = false;
      }
    }
  }

  initializeVideoHIW() async {
    if (Get.width > 950) {
      if (editController.allDataResponse.isNotEmpty) {
        ///------------how it works
        if (editController.allDataResponse[0]["how_it_works_details"][0]
                    ["hiw_gif_mediatype"]
                .toString()
                .toLowerCase() ==
            "video") {
          editHiwController.botController = VideoPlayerController.networkUrl(
              Uri.parse(APIString.mediaBaseUrl +
                  editController.allDataResponse[0]["how_it_works_details"][0]
                          ["hiw_gif"]
                      .toString()));

          editHiwController.botChewieController = ChewieController(
            videoPlayerController: editHiwController.botController,
            allowFullScreen: false,
            autoPlay: false,
            looping: true,
          );

          editHiwController.botController.initialize().then((_) {
            editHiwController.isBotVideoInitialized.value = true;
            setState(() {});
          });
        }
      } else {
        editHiwController.isBotVideoInitialized.value = false;
      }
    }
  }

  initializeVideoMixBanner() async {
    if (editController.allDataResponse.isNotEmpty) {
      ///------------mix banner
      if (editController.allDataResponse[0]["mix_banner_details"][0]
                  ["mix_banner_file_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        mixBannerController.videoController = VideoPlayerController.networkUrl(
            Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["mix_banner_details"][0]
                        ["mix_banner_file"]
                    .toString()));
        await mixBannerController.videoController.initialize().whenComplete(() {
          mixBannerController.videoController.setLooping(true);
          mixBannerController.videoController.setVolume(0);
          mixBannerController.isVideoInitialized.value = true;
          mixBannerController.videoController.play();
          setState(() {});
        });
      } else {
        mixBannerController.isVideoInitialized.value = false;
      }
    }
  }

  initializeVideobenefitBanner() async {
    log("-=-=-=-=-   editController.allDataResponse.isNotEmpty");
    if (editController.allDataResponse.isNotEmpty) {
      log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");

      ///------------mix banner
      if (editController.allDataResponse[0]["benefit_banner_details"][0]
                  ["benefit_banner_file_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        benefitBannerController.videoController =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["benefit_banner_details"][0]
                        ["benefit_banner_file"]
                    .toString()));
        await benefitBannerController.videoController
            .initialize()
            .whenComplete(() {
          // Future.delayed(const Duration(seconds: 2),() {
          benefitBannerController.videoController.setLooping(true);
          benefitBannerController.videoController.setVolume(0);
          benefitBannerController.isVideoInitialized.value = true;
          benefitBannerController.videoController.play();
          setState(() {});
          // },);
        });
      } else {
        benefitBannerController.isVideoInitialized.value = false;
      }
    }
  }

  initializeVideCheckOut() async {
    log("-=-=-=-=-   editController.allDataResponse.isNotEmpty");
    if (editController.allDataResponse.isNotEmpty) {
      log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");

      ///------------mix banner
      if (editController.allDataResponse[0]["checkout_details"][0]
                  ["checkout_file_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        editCheckOutController.checkVideoController =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["checkout_details"][0]
                        ["checkout_file"]
                    .toString()));
        await editCheckOutController.checkVideoController
            .initialize()
            .whenComplete(() {
          // Future.delayed(const Duration(seconds: 2),() {
          editCheckOutController.checkVideoController.setLooping(true);
          editCheckOutController.checkVideoController.setVolume(0);
          editCheckOutController.isCheckVideoInitialized.value = true;
          editCheckOutController.checkVideoController.play();
          setState(() {});
          // },);
        });
      } else {
        editCheckOutController.isCheckVideoInitialized.value = false;
      }
    }
  }

  initializeVideoNumberBanner() async {
    if (editController.allDataResponse.isNotEmpty) {
      ///------------NUMBER BANNER
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file1_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        numberBannerController.media1Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["numbers_banner_details"][0]
                        ["numbers_banner_file1"]
                    .toString()));
        await numberBannerController.media1Controller
            .initialize()
            .whenComplete(() {
          numberBannerController.media1Controller.setLooping(true);
          numberBannerController.media1Controller.play();
          numberBannerController.media1Controller.setVolume(0);
          numberBannerController.isMedia1Initialized.value = true;
          numberBannerController.media1Controller.play();
          setState(() {});
        });
      } else {
        numberBannerController.isMedia1Initialized.value = false;
      }

      ///------------
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file2_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        numberBannerController.media2Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["numbers_banner_details"][0]
                        ["numbers_banner_file2"]
                    .toString()));
        await numberBannerController.media2Controller
            .initialize()
            .whenComplete(() {
          numberBannerController.media2Controller.setLooping(true);
          numberBannerController.media2Controller.setVolume(0);
          numberBannerController.isMedia2Initialized.value = true;
          numberBannerController.isMedia22Initialized.value = true;
          numberBannerController.media2Controller.play();
          setState(() {});
        });
      } else {
        numberBannerController.isMedia22Initialized.value = false;

        numberBannerController.isMedia2Initialized.value = false;
      }

      ///------------
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file3_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        numberBannerController.media3Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["numbers_banner_details"][0]
                        ["numbers_banner_file3"]
                    .toString()));
        await numberBannerController.media3Controller
            .initialize()
            .whenComplete(() {
          numberBannerController.media3Controller.setLooping(true);
          numberBannerController.media3Controller.setVolume(0);
          numberBannerController.isMedia3Initialized.value = true;
          numberBannerController.isMedia33Initialized.value = true;
          numberBannerController.media3Controller.play();
          setState(() {});
        });
      } else {
        numberBannerController.isMedia33Initialized.value = false;
      }
    }
  }
}
