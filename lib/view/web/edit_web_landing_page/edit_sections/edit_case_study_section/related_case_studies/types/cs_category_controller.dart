// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/related_blog/types/blog_category_controller.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class CSCategoriesController extends GetxController {
  RxList relatedCaseStudies = [].obs;
  final csType = TextEditingController();
  final valueController = TextEditingController();

  Future getRelatedCaseStudies(
      {String? case_study_id, String? case_study_type}) async {
    log("inside getRelatedCaseStudies ---------1");
    try {
      log("inside getRelatedCaseStudies ---------2");
      showLoadingDialog();
      relatedCaseStudies.clear();
      ////blogTypeKey as a blog_type
      //case_study_type
      var response = await HttpHandler.postHttpMethod(
          url: APIString.related_casestudy,
          data: {
            "case_study_id": case_study_id,
            "case_study_type": case_study_type
          });
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          relatedCaseStudies.value = response['body']['data'];
        }
      } else if (response['error'] != null) {
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("getRelatedCaseStudies Error -- $e  $s");
      Future.delayed(
        Duration.zero,
        () => hideLoadingDialog(),
      );
    }
  }

  ///Case Study Categories Api

  RxList<Map<String, String>> caseStudyCategories = <Map<String, String>>[].obs;

  Future addCSCategory({String? case_study_type, String? value}) async {
    log("inside addCSCategory ---------1");
    try {
      log("inside addCSCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.case_study_type_add,
          data: {"case_study_type": case_study_type, "value": value});
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success adding CS category $response");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("addCSCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  Future editCSCategory(
      {String? case_study_type_id,
      String? case_study_type,
      String? value}) async {
    log("inside editCSCategory ---------1");
    try {
      log("inside editCSCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.case_study_type_update,
          data: {
            "case_study_type_id": case_study_type_id,
            "case_study_type": case_study_type,
            "value": value
          });
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success editing CS category $response");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("editCSCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  Future deleteCSCategory({String? case_study_type_id}) async {
    log("inside deleteCSCategory ---------1");
    try {
      log("inside deleteCSCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.case_study_type_delete,
          data: {"case_study_type_id": case_study_type_id});
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success deleting CS category $response");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("deleteCSCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  Future geCSCategory() async {
    caseStudyCategories.clear();
    log("inside geCSCategory ---------1");
    try {
      log("inside geCSCategory ---------2");
      showLoadingDialog();

      var response =
          await HttpHandler.postHttpMethod(url: APIString.case_study_type_get);
      hideLoadingDialog();
      print("response  $response");
      print("response error    ${response["error"]}");
      if (response['error'] == null) {
        // hideLoadingDialog();
        print("response['body']['status']   ${response['body']['status']}");
        if (response['body']['status'].toString() == "success") {
          // caseStudyCategories.value = response['body']['case_study_types'];
          caseStudyCategories.value =
              csConvertToMapList(response['body']['case_study_types']);

          print(" caseStudyCategories.value    ${caseStudyCategories.value}");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("geCSCategory Error -- $e  $s");
    }
  }
}

List<Map<String, String>> csConvertToMapList(List<dynamic> jsonData) {
  List<Map<String, String>> result = [];

  for (var item in jsonData) {
    if (item is Map<String, dynamic>) {
      Map<String, String> mapItem = {};

      mapItem['id'] = item['_id'] ?? '';
      mapItem['case_study_type'] = item['case_study_type'] ?? '';
      mapItem['value'] = item['value'] ?? '';
      mapItem['updated_at'] = item['updated_at'] ?? '';
      mapItem['created_at'] = item['created_at'] ?? '';

      result.add(mapItem);
    }
  }

  return result;
}
