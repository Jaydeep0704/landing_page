import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class ControllerFile extends GetxController {
  RxList dataList = [].obs;

  Future getData() async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.AboutUs,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          dataList.value = response['body']["data"];
        }
      } else {
        log("geComponents step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      hideLoadingDialog();
      debugPrint("geComponents Error -- $e  $s");
    }
  }
}
