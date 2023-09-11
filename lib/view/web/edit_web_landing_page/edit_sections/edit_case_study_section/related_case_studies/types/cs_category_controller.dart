// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class CSCategoriesController extends GetxController{


  RxList relatedCaseStudies = [].obs;

  Future getRelatedCaseStudies({String? case_study_id,String? case_study_type}) async {
    log("inside getRelatedCaseStudies ---------1");
    try {
      log("inside getRelatedCaseStudies ---------2");
      showLoadingDialog();
      relatedCaseStudies.clear();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.related_casestudy,
          data: {
            "case_study_id" :case_study_id,
            "case_study_type":case_study_type
          });
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          relatedCaseStudies.value = response['body']['data'];
        }
      }
      else if (response['error'] != null) {
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("getRelatedCaseStudies Error -- $e  $s");
      Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  ///Case Study Categories Api

  RxList caseStudyCategories = [].obs;

  Future addCSCategory({String? case_study_type,String?  value}) async {
    log("inside addCSCategory ---------1");
    try {
      log("inside addCSCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.case_study_type_add,
          data: {
            "case_study_type":case_study_type,
            "value":value
          });
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success adding CS category $response");
        }
      }
      else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("addCSCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  Future editCSCategory({String? case_study_type_id,String?  case_study_type,String?  value}) async {
    log("inside editCSCategory ---------1");
    try {
      log("inside editCSCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.case_study_type_update,
          data: {
            "case_study_type_id":case_study_type_id,
            "case_study_type":case_study_type,
            "value":value
          });
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success editing CS category $response");
        }
      }
      else if (response['error'] != null) {
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
          data: {
            "case_study_type_id":case_study_type_id
          });
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success deleting CS category $response");
        }
      }
      else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("deleteCSCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }


  Future geCSCategory() async {
    log("geCSCategory step --------  +++ 1 ");
    caseStudyCategories.clear();
    showLoadingDialog();
    try {
      log("geCSCategory step --------  +++  2 ");

      var response = await HttpHandler.getHttpMethod(
        url: APIString.case_study_type_get,
      );
      hideLoadingDialog();
      log("geCSCategory step --------  +++ 3 ");
      if (response['error'] == null) {
        log("geCSCategory step --------  +++  4");
        print("Success get CS category $response");

        if (response['body']['status'].toString() == "1") {
          caseStudyCategories.value = response['body']['data'];
        }
      } else {
        log("geCSCategory step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("geCSCategory Error -- $e  $s");
    }
  }


}