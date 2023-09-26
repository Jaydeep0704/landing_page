import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';

class EditInfoController extends GetxController {
  ///Partner Banner Logos

  RxList imagesList = [].obs;
  RxString msg = "".obs;

  getImages() async {
    log("step --------  +++ 1 ");
    try {
      // showLoadingDialog();
      log("step --------  +++  2 ");
      imagesList.clear();

      // Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_footer_banner,
      );
      log("step --------  +++ 3 ");
      // hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          imagesList.value = response['body']["data"];
          msg.value = response['body']["msg"];
        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("get_footer_banner Error  -- $e  $s");
    }
  }
}
