import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:video_player/video_player.dart';

class NumberBannerController extends GetxController {

  /// customer box visible
  RxBool isVisible = false.obs;
  RxBool isAlreadyOpen = false.obs;
  RxInt visibleCount = 0.obs;


  late VideoPlayerController media1Controller;
  late VideoPlayerController media2Controller;
  late VideoPlayerController media3Controller;

  RxBool isMedia1Initialized = false.obs;
  RxBool isMedia22Initialized = false.obs;
  RxBool isMedia33Initialized = false.obs;
  RxBool isMedia2Initialized = false.obs;
  RxBool isMedia3Initialized = false.obs;

  RxBool file1Switch = false.obs;
  RxBool file2Switch = false.obs;
  RxBool file3Switch = false.obs;

  ///Partner Banner Logos

  RxList partnerBannerLogos = [].obs;
  RxString msg = "".obs;

  getPartnerLogo() async {
    // showLoadingDialog();
    try {
      partnerBannerLogos.clear();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_number_banner,
      );
      // hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          partnerBannerLogos.value = response['body']["data"];
          msg.value = response['body']["msg"];
        }
      } else {
        //error
      }
    } catch (e, s) {
      debugPrint("get_number_banner Error -- $e  $s");
    }
  }
}
