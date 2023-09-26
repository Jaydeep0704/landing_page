import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class PricingScreenController extends GetxController {
  RxList plansList = [].obs;
  RxList plansSHowHidBoolList = [].obs;
  // List? plansSHowHidBoolList;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  RxBool isLocation = true.obs;

  RxBool isApiCallProcessing = false.obs;

  Future getPlansData(
      {bool? showLoader = true, String? lat, String? long}) async {
    log("inside getPlansData ---------1");
    try {
      log("inside getPlansData ---------2");

      plansList.clear();
      plansSHowHidBoolList.clear();
      log("api ------ ${APIString.getPlansLandingPage}");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.getPlansLandingPage,
          data: {
            "latitude": lat ?? "21.2378888",
            "longitude": long ?? "72.863352",
          });
      hideLoadingDialog();
      log("getPlansLandingPage :: Response :: $response");

      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          log("response[data][0]  ---- ${response['body']["get_plan_lists"][0]}");
          plansList.value = response['body']["get_plan_lists"];
          plansSHowHidBoolList.value =
              RxList<bool>.generate(plansList.length, (index) => false);
          // showSnackbar(title: "Success", message: "${response['body']['msg']}");
        }
      } else if (response['error'] != null) {
        // showSnackbar(title: "Warning",message: "Error");
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("getPlansData Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }
}
