import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/login_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/pricing_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_address_section/edit_address_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_apps_demo_section/add_latest_project/add_Project_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_apps_demo_section/edit_apps_demo_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/edit_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/edit_benefit_banner_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_checkout_info_section/edit_checkout_info_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_checkout_section/edit_checkoutController.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_checkout_section/edit_checkout_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs_section/edit_faqs_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_help_banner_section/edit_help_banner_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_how_it_works_section/edit_hiw_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_how_it_works_section/edit_how_it_works_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/edit_numbers_banner_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_pricing_section/edit_pricing_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/edit_showcase_apps_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/showcase_app_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/edit_testimonials_section.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_text_banner_section/edit_text_banner_section.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/checkout_info_section/CheckOutInfoControllers.dart';
import 'package:video_player/video_player.dart';

import 'edit_sections/edit_case_study_section/edit_case_study_section.dart';

class EditWebLandingScreen extends StatefulWidget {
  const EditWebLandingScreen({Key? key}) : super(key: key);

  @override
  State<EditWebLandingScreen> createState() => _EditWebLandingScreenState();
}

class _EditWebLandingScreenState extends State<EditWebLandingScreen> {
  CarouselController carouselController = CarouselController();
  CarouselController purchaseMemberCarouselController = CarouselController();
  CarouselController blogCarouselController = CarouselController();
  CarouselController reviewCarouselController = CarouselController();
  LoginController loginController = Get.find<LoginController>();
  WebLandingPageController webLandingPageController =
      Get.find<WebLandingPageController>();
  EditController editController = Get.find<EditController>();
  EditIntroController editIntroController = Get.find<EditIntroController>();
  EditHiwController editHiwController = Get.find<EditHiwController>();
  final mixBannerController = Get.find<MixBannerController>();
  final numberBannerController = Get.find<NumberBannerController>();
  final pricingScreenController = Get.find<PricingScreenController>();
  final editCheckOutController = Get.find<EditCheckOutController>();
  final benefitBannerController = Get.find<BenefitBannerController>();

  ///for dynamic with edit functionality
  String fontSize = "";
  Color? color = Colors.white;
  FontWeight? fontWeight = FontWeight.w300;
  String? fontWeight1 = "${FontWeight.w300}";

  @override
  void initState() {
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
  }

  planFunc() {
    pricingScreenController.getPlansData(lat: "21.2378888", long: "72.863352");
    getUserLocation();
  }

  Future<Position> getUserLocation() async {
    log("getUserLocation ----- 1");
    LocationPermission permission;
    log("getUserLocation ----- 2");

    // Check if location permission is granted
    permission = await Geolocator.checkPermission();
    log("getUserLocation ----- 3   ${permission != null}");
    log("getUserLocation permission   ${permission}");
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      pricingScreenController.isLocation.value = true;
      log("is from permission always........ ${position.latitude.toString()}");
      pricingScreenController.getPlansData(
        lat: position.latitude.toString(),
        long: position.longitude.toString(),
      );
    } else if (permission == LocationPermission.denied) {
      pricingScreenController.isLocation.value = false;
      pricingScreenController.getPlansData(
          lat: "21.2378888", long: "72.863352");
      log("getUserLocation ----- 4");
      // Request location permission if not granted
      permission = await Geolocator.requestPermission();
      log("getUserLocation ----- 5");

      if (permission == LocationPermission.denied) {
        log("getUserLocation ----- 6");
        pricingScreenController.isLocation.value = false;
        pricingScreenController.getPlansData(
            lat: "21.2378888", long: "72.863352");
        log("getUserLocation ----- 7");
        // Handle the scenario when the user denies the location permission
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
    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    log("getUserLocation ----- 9");
    pricingScreenController.latitude.value = position.latitude.toString();
    log("getUserLocation ----- 10");
    pricingScreenController.longitude.value = position.longitude.toString();
    return position;
  }

  getDataFunction() {
    Future.delayed(
      Duration.zero,
      () {
        webLandingPageController.getUserCount(isFromInit: true);
      },
    );
    // Future.delayed(Duration.zero,(){pricingScreenController.getPlansData(lat: "21.2378888", long: "72.863352");});
    // editController.geComponents();
    Future.delayed(
      Duration.zero,
      () {
        editController.getData().then((value) {
          Future.delayed(
            const Duration(seconds: 5),
            () {
              initializeVideo();
              print("inside timer ---- 10");
              initializeVideoHIW();
              print("inside timer ---- 15");
              initializeVideoMixBanner();
              print("inside timer ---- 20");
              initializeVideoNumberBanner();
            },
          );
        });
      },
    );
  }

  getTestimonialData() {
    Future.delayed(
      const Duration(microseconds: 20),
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<EditTestimonalController>().GetAppLogoes();
          Get.find<EditTestimonalController>().GetTestimonal().then((value) {
            webLandingPageController.belowCardIndex.value =
                Get.find<EditTestimonalController>().getTestimonal.length - 1;
          });
          Get.find<EditBlogController>().getBlogData();
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

  getShowcaseData() {
    Future.delayed(
      const Duration(microseconds: 25),
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<ShowCaseAppsController>().getShowCaseApi();
        });
      },
    );
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
    Future.delayed(const Duration(microseconds: 40), () {
      Get.find<EditCaseStudyController>().getCaseStudy();
    });
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
        Get.find<AddProjectController>().getProjectData();
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
    log("-=-=-=-=-   editController.allDataResponse.isNotEmpty");
    if (editController.allDataResponse.isNotEmpty) {
      log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");

      ///
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_bot_file_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        log("-=-=-=-=-   inside intro_bot_file_mediatype");
        editIntroController.introBotController =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["intro_details"][0]
                        ["intro_bot_file"]
                    .toString()));
        log("-=-=-=-=-   inside intro_bot_file_mediatype ${editIntroController.introBotController.setVolume(0)}");
        // Future.delayed(const Duration(seconds: 1),() async {
        await editIntroController.introBotController
            .initialize()
            .whenComplete(() {
          log("-=-=-=-=-   inside <><><><><> ${editIntroController.introBotController}");
          editIntroController.introBotController.setLooping(true);
          editIntroController.introBotController.setVolume(0);
          editIntroController.isBotVideoInitialized.value = true;
          editIntroController.introBotController.play();
          setState(() {});
        });
        // });
      } else {
        editIntroController.isBotVideoInitialized.value = false;
      }

      ///---------------
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif1_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        log("-=-=-=-=- inside - intro_gif1_mediatype");

        editIntroController.introGif1Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["intro_details"][0]
                        ["intro_gif1"]
                    .toString()));
        // Future.delayed(const Duration(seconds: 0), () async{
        log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
        await editIntroController.introGif1Controller
            .initialize()
            .whenComplete(() {
          log("-=-=-=-=- inside - video --- ${editIntroController.introGif1Controller}");
          editIntroController.introGif1Controller.setLooping(true);
          editIntroController.introGif1Controller.setVolume(0);
          log("-=-=-=-=- inside - isIntroGif1Initialized ${editIntroController.isIntroGif1Initialized.value}");
          editIntroController.isIntroGif1Initialized.value = true;
          Future.delayed(
            const Duration(seconds: 10),
            () {
              log("-=-=-=-=- inside - isIntroGif1Initialized ${editIntroController.isIntroGif1Initialized.value}");
            },
          );
          editIntroController.introGif1Controller.play();

          setState(() {});
        });
        // },);
      } else {
        editIntroController.isIntroGif1Initialized.value = false;
      }

      ///----------
      if (editController.allDataResponse[0]["intro_details"][0]
                  ["intro_gif2_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
        editIntroController.introGif2Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["intro_details"][0]
                        ["intro_gif2"]
                    .toString()));
        await editIntroController.introGif2Controller
            .initialize()
            .whenComplete(() {
          log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
          // Future.delayed(const Duration(seconds: 3),() {
          log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
          editIntroController.introGif2Controller.setLooping(true);
          editIntroController.introGif2Controller.setVolume(0);
          editIntroController.isIntroGif2Initialized.value = true;
          editIntroController.introGif2Controller.play();
          setState(() {});
          // },);
        });
      } else {
        editIntroController.isIntroGif2Initialized.value = false;
      }
    }
  }

  // initializeVideoHIW() async {
  //   log("-=-=-=-=-   editController.allDataResponse.isNotEmpty");
  //   if (editController.allDataResponse.isNotEmpty) {
  //     log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
  //
  //     ///------------how it works
  //     if (editController.allDataResponse[0]["how_it_works_details"][0]
  //     ["hiw_gif_mediatype"]
  //         .toString()
  //         .toLowerCase() ==
  //         "video") {
  //       log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
  //       editHiwController.botController = VideoPlayerController.networkUrl(
  //           Uri.parse(APIString.mediaBaseUrl +
  //               editController.allDataResponse[0]["how_it_works_details"][0]
  //               ["hiw_gif"]
  //                   .toString()));
  //       await editHiwController.botController.initialize().whenComplete(
  //             () {
  //           log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
  //           // Future.delayed(const Duration(seconds: 2),() {
  //           log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
  //           editHiwController.botController.setLooping(true);
  //           editHiwController.botController.setVolume(0);
  //           //editIntroController.isBotVideoInitialized.value = true;
  //           editHiwController.isBotVideoInitialized.value = true;
  //           editHiwController.botController.play();
  //
  //           setState(() {});
  //         },
  //       );
  //       // });
  //     } else {
  //       editHiwController.isBotVideoInitialized.value = false;
  //     }
  //   }
  // }
  initializeVideoHIW() async {
    if (editController.allDataResponse.isNotEmpty) {
      ///------------how it works
      // if (editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif_mediatype"].toString().toLowerCase() == "video") {
      //   editHiwController.botController = VideoPlayerController.networkUrl(
      //       Uri.parse(APIString.mediaBaseUrl + editController.allDataResponse[0]["how_it_works_details"][0]["hiw_gif"].toString()));
      //   await editHiwController.botController.initialize().whenComplete(
      //     () {
      //       editHiwController.botController.setLooping(true);
      //       editHiwController.botController.setVolume(0);
      //       editHiwController.isBotVideoInitialized.value = true;
      //       editHiwController.botController.play();
      //       setState(() {});
      //     },
      //   );
      // }
      // else {
      //   editHiwController.isBotVideoInitialized.value = false;
      // }

      if (editController.allDataResponse[0]["how_it_works_details"][0]
                  ["hiw_gif_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        editHiwController.editBotController = VideoPlayerController.networkUrl(
            Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["how_it_works_details"][0]
                        ["hiw_gif"]
                    .toString()));

        editHiwController.editBotChewieController = ChewieController(
          videoPlayerController: editHiwController.editBotController,
          allowFullScreen: false,
          autoPlay: false,
          looping: true,
        );

        editHiwController.editBotController.initialize().then((_) {
          editHiwController.isEditBotVideoInitialized.value = true;
          setState(() {});
        });
      }
    } else {
      editHiwController.isEditBotVideoInitialized.value = false;
    }
  }

  initializeVideoMixBanner() async {
    log("-=-=-=-=-   editController.allDataResponse.isNotEmpty");
    if (editController.allDataResponse.isNotEmpty) {
      log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");

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
          // Future.delayed(const Duration(seconds: 2),() {
          mixBannerController.videoController.setLooping(true);
          mixBannerController.videoController.setVolume(0);
          mixBannerController.isVideoInitialized.value = true;
          mixBannerController.videoController.play();
          setState(() {});
          // },);
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

  ///checkout section

  initializeVideoCheckout() async {
    log("-=-=-=-=-   editController.allDataResponse.isNotEmpty");
    if (editController.allDataResponse.isNotEmpty) {
      log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");

      ///------------mix banner
      if (editController.allDataResponse[0]["checkout_details"][0]
                  ["checkout_file_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        editCheckOutController.checkvideoController =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["checkout_details"][0]
                        ["checkout_file"]
                    .toString()));
        await editCheckOutController.checkvideoController
            .initialize()
            .whenComplete(() {
          // Future.delayed(const Duration(seconds: 2),() {
          editCheckOutController.checkvideoController.setLooping(true);
          editCheckOutController.checkvideoController.setVolume(0);
          editCheckOutController.ischeckVideoInitialized.value = true;
          editCheckOutController.checkvideoController.play();
          setState(() {});
          // },);
        });
      } else {
        editCheckOutController.ischeckVideoInitialized.value = false;
      }
    }
  }

  initializeVideoNumberBanner() async {
    log("-=-=-=-=-   editController.allDataResponse.isNotEmpty");
    if (editController.allDataResponse.isNotEmpty) {
      log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");

      ///------------NUMBER BANNER
      if (editController.allDataResponse[0]["numbers_banner_details"][0]
                  ["numbers_banner_file1_mediatype"]
              .toString()
              .toLowerCase() ==
          "video") {
        log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
        numberBannerController.media1Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["numbers_banner_details"][0]
                        ["numbers_banner_file1"]
                    .toString()));
        await numberBannerController.media1Controller
            .initialize()
            .whenComplete(() {
          log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
          // Future.delayed(const Duration(seconds: 2),() {
          log("-=-=-=-=- inside - numbers_banner_file1");
          numberBannerController.media1Controller.setLooping(true);
          numberBannerController.media1Controller.play();
          numberBannerController.media1Controller.setVolume(0);
          numberBannerController.isMedia1Initialized.value = true;
          numberBannerController.media1Controller.play();
          setState(() {});
          // },);
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
        log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
        numberBannerController.media2Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["numbers_banner_details"][0]
                        ["numbers_banner_file2"]
                    .toString()));
        await numberBannerController.media2Controller
            .initialize()
            .whenComplete(() {
          log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
          // Future.delayed(const Duration(seconds: 2),() {
          log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
          numberBannerController.media2Controller.setLooping(true);
          numberBannerController.media2Controller.setVolume(0);
          numberBannerController.isMedia2Initialized.value = true;
          numberBannerController.isMedia22Initialized.value = true;
          numberBannerController.media2Controller.play();
          setState(() {});
          // },);
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
        log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
        numberBannerController.media3Controller =
            VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
                editController.allDataResponse[0]["numbers_banner_details"][0]
                        ["numbers_banner_file3"]
                    .toString()));
        await numberBannerController.media3Controller
            .initialize()
            .whenComplete(() {
          log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
          // Future.delayed(const Duration(seconds: 2),() {
          log("-=-=-=-=- inside - editController.allDataResponse.isNotEmpty");
          numberBannerController.media3Controller.setLooping(true);
          numberBannerController.media3Controller.setVolume(0);
          numberBannerController.isMedia3Initialized.value = true;
          numberBannerController.isMedia33Initialized.value = true;
          numberBannerController.media3Controller.play();
          setState(() {});
          // },);
        });
      } else {
        numberBannerController.isMedia33Initialized.value = false;
      }
    }
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
      if (editController.allDataResponse[0]["how_it_works_details"][0]
                  ["hiw_gif_mediatype"]
              .toString()
              .toLowerCase() ==
          'video') {
        editHiwController.editBotController.pause();
        editHiwController.editBotController.dispose();
        editHiwController.editBotChewieController.dispose();
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                  color: AppColors.blackColor, onPressed: () => Get.back()),
              title: Text(
                "Edit Layout",
                style: AppTextStyle.regular400
                    .copyWith(color: AppColors.blackColor, fontSize: 20),
              ),
              centerTitle: true,
              backgroundColor: AppColors.whiteColor,
              actions: [
                InkWell(
                  onTap: () {
                    // editHiwController.editBotController.pause();
                    // Get.find<EditHiwController>().botController.pause();

                    loginController.logout(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: AppTextStyle.regular500.copyWith(
                            fontSize: 14, color: AppColors.blackColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: SizedBox(
              width: Get.width,
              // child: Obx(() {
              //   return editController.allDataResponse.isEmpty &&
              //           editController.homeComponentList.isEmpty
              //       ? const SizedBox()
              //       : ReorderableListView.builder(
              //           cacheExtent: 5000,
              //           itemCount: editController.homeComponentList.length,
              //           onReorder: reorderData,
              //           itemBuilder: (context, index) {
              //             return Container(
              //               key: ValueKey(
              //                   editController.homeComponentList[index]),
              //               child: getComponentUi(
              //                   editController.homeComponentList[index]),
              //             );
              //           });
              // })

              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ReorderableListView(
                  shrinkWrap: true,
                  onReorder: reorderData,
                  children: <Widget>[
                    for (final items in listOfScreens)
                      Card(
                        key: ValueKey(items),
                        elevation: 2,
                        child: items,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> reorderData(int oldIndex, int newIndex) async {
    String id = editController.homeComponentList[oldIndex]["_id"];
    editController.reorderComponent(
        id: id, newindex: newIndex.toString(), oldIndex: oldIndex.toString());
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      log("oldIndex is --------> $oldIndex");
      log("newIndex is --------> $newIndex");
      final items = editController.homeComponentList.removeAt(oldIndex);
      editController.homeComponentList.insert(newIndex, items);
      // final items = listOfScreens.removeAt(oldIndex);
      // listOfScreens.insert(newIndex, items);
    });
  }

  List listOfScreens = [
    ///first part starts from here
    const EditIntroSection(),

    ///second part starts from here
    const EditShowcaseAppsSection(),

    ///third part starts here
    const EditHowItWorksSection(),

    ///fourth part starts from here
    //Phase2
    const EditTestimonialsSection(),

    ///fifth part starts from here
    //Phase2
    const EditTextBannerSection(),

    ///sixth part starts from here
    const EditMixBannerSection(),

    ///seventh part from here
    //Phase2
    const EditBenefitBannerSection(),

    ///eighth part from here - shopify checkout view
    const EditNumbersBannerSection(),

    ///ninth part from here - Builder.ai help select plan
    const EditHelpBannerSection(),

    ///tenth part from here - Builder.ai/pricing case study
    //Phase2
    const EditCaseStudySection(),

    ///Eleven part from here - shopify/checkout - info section of checkout for every apps
    //Phase2
    const EditCheckoutInfoSection(),

    ///Twelve part from here - Builder.ai/pricing platform vise price
    const EditPricingSection(),

    ///Thirteen part from here - shopify - info displaying how fast it is
    //Phase2
    const EditCheckoutSection(),

    ///Fourteen part from here - builder.ai/pricing - carousel showing different apps images
    const EditAppsDemoSection(),

    ///Don't open
    ///Fifteenth part from here - shopify/checkout - payment method overview
    // const FifteenthSection(),

    ///EditFAQs section ---> builder.ai
    const EditFAQsSection(),

    ///info section ---> Note : get this data from backend
    const EditInfoSection(),

    ///info section ---> Note : Static
    const EditAddressSection(),
  ];

  getComponentUi(homeComponent) {
    if (homeComponent["component_name"].toString() == "intro") {
      return const EditIntroSection();
    } else if (homeComponent["component_name"].toString() == "showcase_apps") {
      return const EditShowcaseAppsSection();
    } else if (homeComponent["component_name"].toString() == "how_it_works") {
      return const EditHowItWorksSection();
    } else if (homeComponent["component_name"].toString() == "testimonials") {
      return const EditTestimonialsSection();
    } else if (homeComponent["component_name"].toString() == "text_banner") {
      return const EditTextBannerSection();
    } else if (homeComponent["component_name"].toString() == "mix_banner") {
      return const EditMixBannerSection();
    } else if (homeComponent["component_name"].toString() == "benefit_banner") {
      return const EditBenefitBannerSection();
    } else if (homeComponent["component_name"].toString() == "numbers_banner") {
      return const EditNumbersBannerSection();
    } else if (homeComponent["component_name"].toString() == "help_banner") {
      return const EditHelpBannerSection();
    } else if (homeComponent["component_name"].toString() == "case_study") {
      return const EditCaseStudySection();
    } else if (homeComponent["component_name"].toString() == "checkout_info") {
      return const EditCheckoutInfoSection();
    } else if (homeComponent["component_name"].toString() == "pricing") {
      return const EditPricingSection();
    } else if (homeComponent["component_name"].toString() == "checkout") {
      return const EditCheckoutSection();
    } else if (homeComponent["component_name"].toString() == "apps_demo") {
      return const EditAppsDemoSection();
    } else if (homeComponent["component_name"].toString() == "faq_details") {
      return const EditFAQsSection();
    } else if (homeComponent["component_name"].toString() == "footer_section") {
      return const EditInfoSection();
    } else if (homeComponent["component_name"].toString() ==
        "address_section") {
      return const EditAddressSection();
    } else {
      return Container();
    }
  }
}
