import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class EditCaseStudyController extends GetxController {
  TextEditingController type = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController shortDescription = TextEditingController();
  TextEditingController detailDescription = TextEditingController();

  clearFields() {
    type.clear();
    category.clear();
    title.clear();
    shortDescription.clear();
    detailDescription.clear();
  }

  RxList caseStudyList = [].obs;
  RxList caseStudyReadMore = [].obs;

  RxString msg = "".obs;

  Future<void> getCaseStudy() async {
    showLoadingDialog();
    // hideLoadingDialog();
    try {
      caseStudyList.clear();
      // Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.getCaseStudy,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          log(" status------------->  ${response['body']['status']}");
          caseStudyList.value = response['body']["data"];
          for (int i = 0; i < caseStudyList.length; i++) {
            caseStudyReadMore.add(false);
          }
          msg.value = response['body']["msg"];
          // getPartnerLogo2();
        }
      } else {
        //error
      }
    } catch (e, s) {
      debugPrint("get_number_banner Error -- $e  $s");
    }
  }
}
