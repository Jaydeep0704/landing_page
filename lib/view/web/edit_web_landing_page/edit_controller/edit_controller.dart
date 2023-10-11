import 'dart:developer';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_address_section/address_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_how_it_works_section/edit_hiw_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/showcase_app_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:video_player/video_player.dart';

class EditController extends GetxController {
  RxBool showComp1 = false.obs;
  RxBool showComp2 = false.obs;
  RxBool showComp3 = false.obs;
  RxBool showComp4 = false.obs;
  RxBool showComp5 = false.obs;

  RxString introBgColor =
      AppColors.bgGreen.withOpacity(0.3).value.toString().obs;
  RxString showcaseAppsBgColor =
      AppColors.bgPurple.withOpacity(0.2).value.toString().obs;
  RxString hiwBgColor =
      AppColors.bgSkyBlue.withOpacity(0.5).value.toString().obs;
  RxString mixBannerBgColor =
      AppColors.bgSkyBlue.withOpacity(0.5).value.toString().obs;
  RxString numberBannerBgColor =
      AppColors.bgSkyBlue.withOpacity(0.5).value.toString().obs;
  RxString helpBannerBgColor =
      AppColors.bgSkyBlue.withOpacity(0.5).value.toString().obs;
  RxString pricingBgColor =
      AppColors.bgSkyBlue.withOpacity(0.5).value.toString().obs;
  RxString appDemoBgColor =
      AppColors.bgSkyBlue.withOpacity(0.5).value.toString().obs;

  RxBool introComp = false.obs;
  RxBool showcaseApps = false.obs;
  RxBool howItWorks = false.obs;
  RxBool testimonials = false.obs;
  RxBool textBanner = false.obs;
  RxBool mixBanner = false.obs;
  RxBool benefitBanner = false.obs;
  RxBool numbersBanner = false.obs;
  RxBool helpBanner = false.obs;
  RxBool caseStudy = false.obs;
  RxBool checkoutInfo = false.obs;
  RxBool pricing = false.obs;
  RxBool checkout = false.obs;
  RxBool appsDemo = false.obs;
  RxBool footerSection = false.obs;
  RxBool addressSection = false.obs;
  RxBool faqSection = false.obs;

  RxList allDataResponse = [].obs;
  RxList introDataList = [].obs;

  RxList homeComponentList = [].obs;

  Future getData() async {
    try {
      allDataResponse.clear();
      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.get_web_landing_page_data,
          data: {
            "user_auto_id": APIString.userAutoId,
          });
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          allDataResponse.value = response['body']["data"];
          introDataList.value = response['body']["data"][0]["intro_details"];

          Get.find<EditIntroController>().introBotSwitch.value =
              allDataResponse[0]["intro_details"][0]["intro_bot_file_show"] ==
                      "show"
                  ? true
                  : false;
          Get.find<EditIntroController>().introGif1Switch.value =
              allDataResponse[0]["intro_details"][0]["intro_gif1_show"] ==
                      "show"
                  ? true
                  : false;
          Get.find<EditIntroController>().introGif2Switch.value =
              allDataResponse[0]["intro_details"][0]["intro_gif2_show"] ==
                      "show"
                  ? true
                  : false;
          Get.find<EditIntroController>().introDescBGSwitch.value =
              allDataResponse[0]["intro_details"][0]["intro_desc_bg"] == "show"
                  ? true
                  : false;

          Get.find<EditIntroController>().appCountBGSwitch.value =
              allDataResponse[0]["live_app_count_bg"] == "show" ? true : false;
          Get.find<EditIntroController>().webCountBGSwitch.value =
              allDataResponse[0]["live_web_count_bg"] == "show" ? true : false;

          Get.find<EditHiwController>().hiwGifShowSwitch.value =
              allDataResponse[0]["how_it_works_details"][0]["hiw_gif_show"] ==
                      "show"
                  ? true
                  : false;

          Get.find<ShowCaseAppsController>().titleSwitch.value =
              allDataResponse[0]["showcase_apps_details"][0]
                          ["showcase_apps_heading_show_hide"] ==
                      "show"
                  ? true
                  : false;
          Get.find<ShowCaseAppsController>().carouselSwitch.value =
              allDataResponse[0]["showcase_apps_details"][0]
                          ["showcase_apps_show_hide"] ==
                      "show"
                  ? true
                  : false;

          ///testimonials show hide
          Get.find<EditTestimonialController>()
              .testimonial_title_1_Switch
              .value = allDataResponse[0]["testimonials_details"][0]
                      ["testimonials_title1_visible"] ==
                  "show"
              ? true
              : false;

          Get.find<EditTestimonialController>().testimonial1Switch.value =
              allDataResponse[0]["testimonials_details"][0]
                          ["testimonial1_visible"] ==
                      "show"
                  ? true
                  : false;
          Get.find<EditTestimonialController>().testimonial2Switch.value =
              allDataResponse[0]["testimonials_details"][0]
                          ["testimonial2_visible"] ==
                      "show"
                  ? true
                  : false;

          Get.find<MixBannerController>().mixBannerFileShowSwitch.value =
              allDataResponse[0]["mix_banner_details"][0]
                          ["mix_banner_file_show"] ==
                      "show"
                  ? true
                  : false;

          ///benefit banner remains

          Get.find<NumberBannerController>().file1Switch.value =
              allDataResponse[0]["numbers_banner_details"][0]
                          ["numbers_banner_file1_show"] ==
                      "show"
                  ? true
                  : false;
          Get.find<NumberBannerController>().file2Switch.value =
              allDataResponse[0]["numbers_banner_details"][0]
                          ["numbers_banner_file2_show"] ==
                      "show"
                  ? true
                  : false;
          Get.find<NumberBannerController>().file3Switch.value =
              allDataResponse[0]["numbers_banner_details"][0]
                          ["numbers_banner_file3_show"] ==
                      "show"
                  ? true
                  : false;

          ///show hide address
          Get.find<AddressController>().showAddress.value = allDataResponse[0]
                      ["address_section"][0]["address_details_show_hide"] ==
                  "show"
              ? true
              : false;
          // functionToGetAllVideos();

          // showSnackbar(title: "Success", message: "${response['body']['msg']}");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        showSnackbar(message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside getData ---------5");
      debugPrint("getData Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  ///to update component background color
  saveBgColorToApi({
    required BuildContext context,
    required String? keyNameClr,
    bool isTextBGColorEdit = false,
    String? textBgColorHide,
    String? keyNameImg,
    String? switchKeyNameImg,
    String? clrSwitchValue,
    String? switchKeyNameClr,
    String? imgSwitchValue,
    required Color? color,
    var img,
  }) async {
    try {
      showLoadingDialog();
      // Get.focusScope!.unfocus();
      if (keyNameClr.toString().isNotEmpty &&
          color!.value.toString().isNotEmpty) {
        log(" img switch key name   : ${switchKeyNameImg.toString()}");
        log(" color switch key name   : ${switchKeyNameClr.toString()}");

        var response = await HttpHandler.postHttpMethod(
            url: APIString.update_web_landing_page_data,
            data: isTextBGColorEdit == false
                ? {
                    "user_auto_id": APIString.userAutoId,
                    keyNameClr.toString(): color.value.toString(),
                    keyNameImg.toString(): img,
                    switchKeyNameImg.toString(): "0",
                    switchKeyNameClr.toString(): "1",
                  }
                : {
                    "user_auto_id": APIString.userAutoId,
                    keyNameClr.toString(): color.value.toString(),
                  });
        hideLoadingDialog();
        if (response['error'] == null) {
          if (response['body']['status'].toString() == "1") {
            showSnackbar(message: "${response['body']['msg']}");
            getData();
          }
        } else if (response['error'] != null) {
          showSnackbar(message: "Error");
        }
      }
    } catch (e, s) {
      debugPrint("saveColorToApi Error -- $e  $s");
    }
  }

  ///to update text ,text color , text font
  editText({
    required BuildContext context,
    required bool? textEdit,
    required Color? color,
    required String? colorKeyName,
    required String? fontFamilyKeyName,
    required String? fontFamily,
    required String? text,
    required String? textKeyName,
  }) async {
    try {
      showLoadingDialog();
      Get.focusScope!.unfocus();

      if (text!.isNotEmpty) {
        Map<String, dynamic>? data;
        if (textEdit == true) {
          data = {
            "user_auto_id": APIString.userAutoId,
            textKeyName.toString(): text.toString(),
          };
        } else {
          data = {
            "user_auto_id": APIString.userAutoId,
            textKeyName.toString(): text.toString(),
            colorKeyName.toString(): color!.value.toString(),
            fontFamilyKeyName.toString(): fontFamily.toString()
          };
        }

        var response = await HttpHandler.postHttpMethod(
            url: APIString.update_web_landing_page_data, data: data);

        hideLoadingDialog();
        if (response['error'] == null) {
          if (response['body']['status'].toString() == "1") {
            log("successfully updated ------------ :: ");
            showSnackbar(message: "${response['body']['msg']}");
            getData();
          }
        } else if (response['error'] != null) {
          log("error ------------ :: ");
          showSnackbar(message: "Error");
        }
      } else {
        var response = await HttpHandler.postHttpMethod(
            url: APIString.update_web_landing_page_data,
            data: {
              "user_auto_id": APIString.userAutoId,
              colorKeyName.toString(): color!.value.toString(),
              fontFamilyKeyName.toString(): fontFamily.toString()
            });

        hideLoadingDialog();
        if (response['error'] == null) {
          if (response['body']['status'].toString() == "1") {
            log("successfully updated ------------ :: ");
            showSnackbar(message: "${response['body']['msg']}");
            getData();
          }
        } else if (response['error'] != null) {
          log("error ------------ :: ");
          showSnackbar(message: "Error");
        }
      }
    } catch (e, s) {
      log("error ------------ :: ");

      debugPrint("saveColorToApi Error -- $e  $s");
    }
  }

  Future showHideMedia({String? keyName, String? value}) async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.update_web_landing_page_data,
          data: {
            "user_auto_id": APIString.userAutoId.toString(),
            keyName.toString(): value.toString(),
          });
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          getData();
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        getData();
        hideLoadingDialog();
      }
    } catch (e, s) {
      getData();
      hideLoadingDialog();
    }
  }

  Future showHideComponent({String? componentName, String? value}) async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.update_component_visibility,
          data: {
            "component_name": componentName.toString(),
            "visible": value.toString()
          });
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          getData();
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        getData();
        hideLoadingDialog();
      }
    } catch (e, s) {
      getData();
      hideLoadingDialog();
    }
  }

  Future geComponents() async {
    homeComponentList.clear();
    try {
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_web_component_list,
      );
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          homeComponentList.value = response['body']["data"];

          introComp.value =
              homeComponentList[0]["visible"] == "Yes" ? true : false;
          showcaseApps.value =
              homeComponentList[1]["visible"] == "Yes" ? true : false;
          howItWorks.value =
              homeComponentList[2]["visible"] == "Yes" ? true : false;
          testimonials.value =
              homeComponentList[3]["visible"] == "Yes" ? true : false;
          textBanner.value =
              homeComponentList[4]["visible"] == "Yes" ? true : false;
          mixBanner.value =
              homeComponentList[5]["visible"] == "Yes" ? true : false;
          benefitBanner.value =
              homeComponentList[6]["visible"] == "Yes" ? true : false;
          numbersBanner.value =
              homeComponentList[7]["visible"] == "Yes" ? true : false;
          helpBanner.value =
              homeComponentList[8]["visible"] == "Yes" ? true : false;
          caseStudy.value =
              homeComponentList[9]["visible"] == "Yes" ? true : false;
          checkoutInfo.value =
              homeComponentList[10]["visible"] == "Yes" ? true : false;
          pricing.value =
              homeComponentList[11]["visible"] == "Yes" ? true : false;
          checkout.value =
              homeComponentList[12]["visible"] == "Yes" ? true : false;
          appsDemo.value =
              homeComponentList[13]["visible"] == "Yes" ? true : false;
          footerSection.value =
              homeComponentList[14]["visible"] == "Yes" ? true : false;
          addressSection.value =
              homeComponentList[15]["visible"] == "Yes" ? true : false;
          faqSection.value =
              homeComponentList[16]["visible"] == "Yes" ? true : false;
        }
      } else {
        //error
      }
    } catch (e, s) {
      debugPrint("geComponents Error -- $e  $s");
    }
  }

  Future reorderComponent(
      {String? id, String? oldIndex, String? newIndex}) async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.reordering_web_components,
          data: {
            "homecomponent_auto_id": id.toString(),
            "new_index": newIndex.toString(),
            "previous_index": oldIndex.toString()
          });
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          log(" response[msg] ----->  ${response['msg']}");
        }
      } else if (response['error'] != null) {}
    } catch (e, s) {
      hideLoadingDialog();
      debugPrint("reorderData Error -- $e  $s");
    }
  }

  RxString mediaType = "".obs;

  ///edit media component

  // RxList videoUrls = [].obs;
  // List<VideoPlayerController> controllers = [];
  //
  // functionToGetAllVideos() {
  //   videoUrls.clear();
  //   if (allDataResponse[0]["intro_details"][0]["intro_bot_file_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["intro_details"][0]["intro_bot_file"].toString()}");
  //   }
  //   if (allDataResponse[0]["intro_details"][0]["intro_gif1_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["intro_details"][0]["intro_gif1"].toString()}");
  //   }
  //   if (allDataResponse[0]["intro_details"][0]["intro_gif2_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["intro_details"][0]["intro_gif2"].toString()}");
  //   }
  //
  //   ///how it works
  //   if (allDataResponse[0]["how_it_works_details"][0]["hiw_gif_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["how_it_works_details"][0]["hiw_gif"].toString()}");
  //   }
  //
  //   ///MixBanner
  //   if (allDataResponse[0]["mix_banner_details"][0]["mix_banner_file_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["mix_banner_details"][0]["mix_banner_file"].toString()}");
  //   }
  //
  //   ///Number banner
  //   if (allDataResponse[0]["numbers_banner_details"][0]
  //   ["numbers_banner_file1_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file1"].toString()}");
  //   }
  //   if (allDataResponse[0]["numbers_banner_details"][0]
  //   ["numbers_banner_file2_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file2"].toString()}");
  //   }
  //   if (allDataResponse[0]["numbers_banner_details"][0]
  //   ["numbers_banner_file3_mediatype"]
  //       .toString()
  //       .toLowerCase() ==
  //       "video") {
  //     videoUrls.add(
  //         "${APIString.mediaBaseUrl}${allDataResponse[0]["numbers_banner_details"][0]["numbers_banner_file3"].toString()}");
  //   }
  // }
  //
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   initializeControllers();
  // }
  //
  // void initializeControllers() {
  //   for (String url in videoUrls) {
  //     final controller = VideoPlayerController.networkUrl(Uri.parse(url));
  //     controller.initialize().then((_) {
  //       controller.setLooping(true);
  //       controller.setVolume(0);
  //       controller.play();
  //     });
  //     controllers.add(controller);
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   for (var controller in controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }
}
