import 'dart:html' as html;
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/address_section/Address.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/checkout_info_section/CheckOutInfoControllers.dart';
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
import 'package:video_player/video_player.dart';

class WebLandingScreen extends StatefulWidget {
  const WebLandingScreen({Key? key}) : super(key: key);

  @override
  State<WebLandingScreen> createState() => _WebLandingScreenState();
}

class _WebLandingScreenState extends State<WebLandingScreen> {
  CarouselController carouselController = CarouselController();
  CarouselController purchaseMemberCarouselController = CarouselController();
  CarouselController blogCarouselController = CarouselController();
  CarouselController reviewCarouselController = CarouselController();

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
    // getAppData();
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

  getAppData() {
    log("inside ---- getProjectData");
    getLatestProject.getProjectData().whenComplete(() {
      log("inside ---- getProjectData");
      initializeAppDataVideo();
    });
    super.initState();
  }

  initializeAppDataVideo() {
    log("inside ---- initializeVideo1");
    for (var item in getLatestProject.getProjectList) {
      log("inside ---- initializeVideo2");
      final mediaType = item.appMediaFileType;
      final link = item.appMediaFile;
      log("passed from -----  $mediaType --  ${item.appMediaFileType}");
      log("passed from -----  $link      --  ${item.appMediaFile}");

      if (mediaType == 'video') {
        final controller =
            VideoPlayerController.network(APIString.latestmediaBaseUrl + link);
        controller.initialize().then((_) {
          log("passed from ----- 1");
          controller.setLooping(true);
          log("passed from ----- 2");
          getLatestProject.videoControllers.add(controller);
          log("passed from ----- 3");
          controller.play();
          log("passed from ----- 4");
          setState(() {});
        });
      } else if (mediaType == 'image') {
        log("passed from ----- image ");
        getLatestProject.imageLinks.add(link);
      }
    }
  }

  Future<Position> getUserLocation() async {
    // pricingScreenController.getPlansData(lat: "21.2378888", long: "72.863352");
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
          Future.delayed(
            const Duration(seconds: 5),
            () {
              initializeVideo();
              initializeVideoHIW();
              initializeVideoMixBanner();
              initializeVideobenefitBanner();
              initializeVideCheckOut();
              initializeVideoNumberBanner();
            },
          );
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

  ///checkOut
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
        editHiwController.botController.pause();
        editHiwController.botController.dispose();
        editHiwController.botChewieController.dispose();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
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
                    : Scrollbar(
                        controller: _scrollController,
                        trackVisibility: true,
                        thickness: 15,
                        interactive: true,
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ///first part starts from here ----  intro
                              const IntroSection(),

                              ///second part starts from here ---- showcase_apps
                              const ShowcaseAppsSection(),

                              ///third part starts here --- how_it_works
                              const HowItWorksSection(),

                              ///fourth part starts from here --- testimonials
                              //Phase2
                              TestimonialsSection(
                                scrollToPricingSection: _scrollToPricingSection,
                              ),

                              ///fifth part starts from here --- text_banner
                              //Phase2
                              const TextBannerSection(),

                              ///sixth part starts from here --- mix_banner
                              const MixBannerSection(),

                              ///seventh part from here --- benefit_banner
                              //Phase2
                              const BenefitBannerSection(),

                              ///eighth part from here - shopify checkout view --- numbers_banner
                              const NumbersBannerSection(),

                              ///ninth part from here - Builder.ai help select plan --- help_banner
                              //Phase2
                              HelpBannerSection(
                                scrollToPricingSection: _scrollToPricingSection,
                              ),

                              ///tenth part from here - Builder.ai/pricing case study --- case_study
                              //Phase2
                              const CaseStudySection(),

                              ///Eleven part from here - shopify/checkout - info section of checkout for every apps --- checkout_info
                              //Phase2
                              const CheckoutInfoSection(),

                              ///twelfth part from here - Builder.ai/pricing platform vise price --- pricing
                              PricingSection(
                                  key: PricingSection.pricingSectionKey),

                              ///Thirteen part from here - shopify - info displaying how fast it is --- checkout
                              //Phase2
                              const CheckoutSection(),

                              ///Fourteen part from here - builder.ai/pricing - carousel showing different apps images --- apps_demo
                              const AppsDemoSection(),

                              ///Don't open
                              ///Fifteenth part from here - shopify/checkout - payment method overview --- how app works
                              // FifteenthSection(),

                              ///info section ---> Note : get this data from backend --- info
                              const InfoSection(),

                              ///Address Section ---> Note : Static data--- Address
                              const AddressSection(),
                            ],
                          ),
                        ),
                      );
              }),
            ),
          ),
        );
      },
    );
  }

  void _scrollToPricingSection() {
    final RenderObject? pricingSectionRenderObject =
        PricingSection.pricingSectionKey.currentContext?.findRenderObject();
    log("_scrollToPricingSection    ------ 1");
    log("pricingSectionRenderObject    ------ ${pricingSectionRenderObject}");

    if (pricingSectionRenderObject != null) {
      log("_scrollToPricingSection    ------ 2");

      log("sjhfjhsgfjgsjhfjk  :::::: ${pricingSectionRenderObject.getTransformTo(null).getTranslation().y}");

      _scrollController.animateTo(
        _scrollController.position.pixels +
            pricingSectionRenderObject.getTransformTo(null).getTranslation().y,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    log("_scrollToPricingSection    ------ 3");
  }

  getComponentUi(homeComponent, {var keyScroll}) {
    if (homeComponent == "intro") {
      return const IntroSection();
    } else if (homeComponent == "showcase_apps") {
      return const ShowcaseAppsSection();
    } else if (homeComponent == "how_it_works") {
      return const HowItWorksSection();
    } else if (homeComponent == "testimonials") {
      return TestimonialsSection(
        scrollToPricingSection: _scrollToPricingSection,
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
        scrollToPricingSection: _scrollToPricingSection,
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
    } else {
      return Container();
    }
  }
}
