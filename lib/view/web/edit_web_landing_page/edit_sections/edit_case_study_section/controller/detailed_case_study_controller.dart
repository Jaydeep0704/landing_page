import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class DetailCaseStudyController extends GetxController {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  RxList caseStudyDetailsList = [].obs;

  clearFields() {
    titleController.clear();
    descController.clear();
  }

  Future addCaseStudyData(
      {String? caseStudyAutoId, String? title, String? description}) async {
    log("inside addData ---------1");
    try {
      log("inside addData ---------2");
      showLoadingDialog();

      log("api ------ ${APIString.addCaseStudyDetails}");

      var response = await HttpHandler.postHttpMethod(
          url: APIString.addCaseStudyDetails,
          data: {
            "case_study_auto_id": caseStudyAutoId,
            "title": title,
            "description": description,
          });
      clearFields();
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // here ------------->

          getCaseStudyData(caseStudyAutoId: caseStudyAutoId);
        }
      } else if (response['error'] != null) {
        showSnackbar(message: "Error");
        getCaseStudyData(caseStudyAutoId: caseStudyAutoId);
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("addCaseStudyDetails Error -- $e  $s");
      Future.delayed(
        Duration.zero,
        () => hideLoadingDialog(),
      );
    }
  }

  Future getCaseStudyData({String? caseStudyAutoId}) async {
    log("inside getCaseStudyData ---------1");
    try {
      log("inside getCaseStudyData ---------2");
      showLoadingDialog();
      caseStudyDetailsList.clear();
      log("api ------ ${APIString.getCaseStudyDetails}");

      var response = await HttpHandler.postHttpMethod(
          url: APIString.getCaseStudyDetails,
          data: {
            "case_study_auto_id": caseStudyAutoId,
          });
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // here ------------->
          caseStudyDetailsList.value = response['body']['data'];
        }
      } else if (response['error'] != null) {
        // showSnackbar(title: "Warning",message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("getCaseStudyData Error -- $e  $s");
      Future.delayed(
        Duration.zero,
        () => hideLoadingDialog(),
      );
    }
  }

  Future editCaseStudyData(
      {String? caseStudyAutoId,
      String? caseStudyDetailsAutoId,
      String? title,
      String? description}) async {
    log("inside editCaseStudyData ---------1");
    try {
      log("inside editCaseStudyData ---------2");
      showLoadingDialog();

      log("api ------ ${APIString.editCaseStudyDetails}");

      var response = await HttpHandler.postHttpMethod(
          url: APIString.editCaseStudyDetails,
          data: {
            "case_study_auto_id": caseStudyAutoId,
            "case_study_details_auto_id": caseStudyDetailsAutoId,
            "title": title,
            "description": description
          });
      clearFields();
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // here ------------->
          getCaseStudyData(caseStudyAutoId: caseStudyAutoId);
        }
      } else if (response['error'] != null) {
        getCaseStudyData(caseStudyAutoId: caseStudyAutoId);
        showSnackbar(message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("editCaseStudyData Error -- $e  $s");
      Future.delayed(
        Duration.zero,
        () => hideLoadingDialog(),
      );
    }
  }

  Future deleteCaseStudyData(
      {String? caseStudyAutoId, String? caseStudyDetailsAutoId}) async {
    log("inside deleteCaseStudyData ---------1");
    try {
      log("inside deleteCaseStudyData ---------2");
      showLoadingDialog();

      log("api ------ ${APIString.deleteCaseStudyDetails}");

      var response = await HttpHandler.postHttpMethod(
          url: APIString.deleteCaseStudyDetails,
          data: {
            "case_study_auto_id": caseStudyAutoId,
            "case_study_details_auto_id": caseStudyDetailsAutoId
          });
      clearFields();
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // here ------------->
          getCaseStudyData(caseStudyAutoId: caseStudyAutoId);
        }
      } else if (response['error'] != null) {
        getCaseStudyData(caseStudyAutoId: caseStudyAutoId);
        showSnackbar(message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("deleteCaseStudyData Error -- $e  $s");
      Future.delayed(
        Duration.zero,
        () => hideLoadingDialog(),
      );
    }
  }
}
