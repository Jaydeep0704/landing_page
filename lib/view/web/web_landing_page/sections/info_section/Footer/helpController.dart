// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:developer';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'FAQ/FaqModel.dart';

class HelpController extends GetxController {
  ///for  about Us
  RxBool isApiCallProcessing = false.obs;
  late String aboutus = '', about_id = '';

  ///for get TFC
  late String terms = '';

  ///for get TFC
  late String privacy = '';
  // late PolicyPrivacy privacydata;

  ///for get FAQ
  late String faq = '';
  late FaqModel faqModel;

  ///for get Refund Policy
  late String refund = '';

  RxList contactUs = [].obs;
  RxList aboutUs = [].obs;
  RxList privacyData = [].obs;
  RxList allFAQs = [].obs;
  RxList allTerms = [].obs;
  RxList allRefundPolicy = [].obs;

  ///for get about Us
  Future getAboutUs() async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.AboutUs,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          aboutUs.value = response['body']["allabouts"];
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

  ///for get Contact Us
  Future getContactUs() async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.showContactDetails,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          contactUs.value = response['body']["contact_details"];
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

  ///for get TFC

  Future getTfcData() async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.TandC,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          allTerms.value = response['body']["allterms"];
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

  ///for get Privacy

  Future getprivacyData() async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.showPrivacy,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          privacyData.value = response['body']["allprivacy"];
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

  ///for get Faq
  // Future<bool> getFaqData() async {
  //   isApiCallProcessing.value = true;
  //
  //   var url = APIString.grobizBaseUrl + APIString.showFaqs;
  //   Uri uri = Uri.parse(url);
  //
  //   final response = await http.get(uri);
  //
  //   if (response.statusCode == 200) {
  //     final resp = jsonDecode(response.body);
  //     int status = resp['status'];
  //
  //     if (status == 1) {
  //       isApiCallProcessing.value = false;
  //       faqModel = FaqModel.fromJson(json.decode(response.body));
  //       var mainList = faqModel.allfaqs;
  //       faq = mainList[0].faq;
  //       log('Data available');
  //       return true;
  //     } else {
  //       isApiCallProcessing.value = false;
  //       return false;
  //     }
  //   } else if (response.statusCode == 500) {
  //     isApiCallProcessing.value = false;
  //     return false;
  //   }
  //
  //   return false;
  // }

  Future getFaqData() async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.showFaqs,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          allFAQs.value = response['body']["allfaqs"];
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

  ///for get Refund Policy

  Future getRefundpolicy() async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.showRefundPolicy,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          allRefundPolicy.value = response['body']["allrefundpolicy"];
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
