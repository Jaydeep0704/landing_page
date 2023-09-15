import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'AboutUs/AboutUsModel.dart';
import 'ContactUs/ContactUsModel.dart';
import 'FAQ/FaqModel.dart';
import 'PrivacyPolicy/PrivacyPolicyModel.dart';
import 'RefundPolicy/RefundPolicyModel.dart';
import 'TandC/TFCModel.dart';

class HelpController extends GetxController {
  ///for  about Us
  RxBool isApiCallProcessing = false.obs;
  late String aboutus = '', about_id = '';
  late AboutUsModel aboutusModel;

  ///for Contact Us
  late ContactUsModel contactUs_Model;
  late String contact_id = '',
      contact_address = '',
      contact_email = '',
      contact_india = '',
      contact_us = '';

  ///for get TFC
  late String terms = '';
  late TFCModel termsandcondition;

  ///for get TFC
  late String privacy = '';
  late PolicyPrivacy privacydata;

  ///for get FAQ
  late String faq = '';
  late FaqModel faqModel;

  ///for get Refund Policy
  late String refund = '';
  late RefundPolicyModel refundPolicyModel;

  ///for get about Us
  Future<bool> getAboutUs() async {
    isApiCallProcessing.value = true;

    var url = APIString.grobizBaseUrl + APIString.AboutUs;
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    print(response.toString());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      print("status=>$status");

      if (status == 1) {
        isApiCallProcessing.value = false;
        aboutusModel = AboutUsModel.fromJson(json.decode(response.body));
        var mainList = aboutusModel.allabouts;
        about_id = mainList[0].id;
        aboutus = mainList[0].about;
        log('Data available');
        return true;
      } else {
        isApiCallProcessing.value = false;
        return false;
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value = false;
      return false;
    }

    return false;
  }

  ///for get Contact Us
  Future<bool> getContactUs() async {
    isApiCallProcessing.value = true;

    var url = APIString.grobizBaseUrl + APIString.showContactDetails;
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    print(response.toString());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      print("status=>$status");

      if (status == 1) {
        isApiCallProcessing.value = false;
        contactUs_Model = ContactUsModel.fromJson(json.decode(response.body));
        var mainList = contactUs_Model.contactDetails;
        contact_id = mainList[0].id;
        contact_india = mainList[0].contactIndia;
        contact_us = mainList[0].contactUs;
        contact_email = mainList[0].email;
        contact_address = mainList[0].address;
        log('Data available');
        return true;
      } else {
        isApiCallProcessing.value = false;
        return false;
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value = false;
      return false;
    }

    return false;
  }

  ///for get TFC
  Future<bool> getTfcData() async {
    isApiCallProcessing.value = true;

    var url = APIString.grobizBaseUrl + APIString.TandC;
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    print(response.toString());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      print("status=>$status");

      if (status == 1) {
        isApiCallProcessing.value = false;
        termsandcondition = TFCModel.fromJson(json.decode(response.body));
        var mainList = termsandcondition.allterms;
        terms = mainList[0].term;
        log('Data available');
        return true;
      } else {
        isApiCallProcessing.value = false;
        return false;
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value = false;
      return false;
    }

    return false;
  }

  ///for get Privacy
  Future<bool> getprivacyData() async {
    isApiCallProcessing.value = true;

    var url = APIString.grobizBaseUrl + APIString.showPrivacy;
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    print(response.toString());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      print("status=>$status");

      if (status.toString() == "1") {
        isApiCallProcessing.value = false;
        privacydata = PolicyPrivacy.fromJson(json.decode(response.body));
        var mainList = privacydata.allprivacy;
        privacy = mainList[0].privacy;
        log('Data available');
        return true;
      } else {
        isApiCallProcessing.value = false;
        return false;
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value = false;
      return false;
    }

    return false;
  }

  ///for get Faq
  Future<bool> getFaqData() async {
    isApiCallProcessing.value = true;

    var url = APIString.grobizBaseUrl + APIString.showFaqs;
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    print(response.toString());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      print("status=>$status");

      if (status == 1) {
        isApiCallProcessing.value = false;
        faqModel = FaqModel.fromJson(json.decode(response.body));
        var mainList = faqModel.allfaqs;
        faq = mainList[0].faq;
        log('Data available');
        return true;
      } else {
        isApiCallProcessing.value = false;
        return false;
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value = false;
      return false;
    }

    return false;
  }

  ///for get Refund Policy
  Future<bool> getRefundpolicy() async {
    isApiCallProcessing.value = true;

    var url = APIString.grobizBaseUrl + APIString.showRefundPolicy;
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    print(response.toString());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      print("status=>$status");

      if (status == 1) {
        isApiCallProcessing.value = false;
        refundPolicyModel =
            RefundPolicyModel.fromJson(json.decode(response.body));
        var mainList = refundPolicyModel.allrefundpolicy;
        refund = mainList[0].refundPolicy;
        log('Data available');
        return true;
      } else {
        isApiCallProcessing.value = false;
        return false;
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value = false;
      return false;
    }

    return false;
  }
}
