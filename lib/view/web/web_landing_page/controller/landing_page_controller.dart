import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

import '../../../../Model/ReorderComponentModel.dart';
import '../../../../Model/subscription_plan_model.dart';
import 'package:http/http.dart' as http;

class WebLandingPageController extends GetxController{
  CarouselController carouselController = CarouselController();
  CarouselController purchaseMemberCarouselController = CarouselController();
  CarouselController blogCarouselController = CarouselController();
  CarouselController reviewCarouselController = CarouselController();
  CarouselController appDetailsController = CarouselController();

  ///section12
  RxInt selectedType = 0.obs;
  // RxInt currentIndex = 0.obs;
  int currentIndex = 0;

  ///section 15
  RxBool selectedMobileDevice = true.obs;

  ///testimonial animation
  RxInt aboveCardIndex = 0.obs;
  RxInt belowCardIndex = 1.obs;
  RxList homecomponentList=[].obs;
  RxList planList=[].obs;

  getAllPlansApi() async {

    var url = APIString.grobizBaseUrl + APIString.get_plans;

    var uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      log(response.body.toString());
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      if (status == 1) {

        SubscriptionPlanModel subscriptionPlanModel =
        SubscriptionPlanModel.fromJson(json.decode(response.body));
        planList.value = subscriptionPlanModel.getPlanLists;
        planList.refresh();
        //log("all plans"+response.body.toString());

      } else {
        log("no plans");
        planList.value = [];
       planList.refresh();
      }
    } else if (response.statusCode == 500) {
    }
  }


  getComponentList() async {
    var url = APIString.grobizBaseUrl + APIString.get_web_component_list;

    var uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      log(response.body.toString());
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      if (status == 1) {
        //log("status=> "+status.toString());
        ReorderComponentModel componentModel =
        ReorderComponentModel.fromJson(json.decode(response.body));
        homecomponentList.value = componentModel.data;
        homecomponentList.refresh();
      }
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(
        msg: 'Server error',
        backgroundColor: Colors.grey,
      );
    }
  }


  ///live user count api call

  RxString appLiveCount = "0".obs;
  RxString webLiveCount = "0".obs;

  Future getUserCount({bool isFromInit = false}) async {

    try {
      if(isFromInit == true) showLoadingDialog();

      // Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_user_count_list,
      );
      log("response :: $response");
      log("response error :: ${response['error']}");
        log("response body :: ${response['body']}");
      if(isFromInit == true) hideLoadingDialog();

      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {

        appLiveCount.value = response['body']['app_live_count'].toString();
        webLiveCount.value = response['body']['web_live_count'].toString();
      }


      } else {
        // hideLoadingDialog();

        log("Error :: ${response['error']}");
        //error
      }

    } catch (e, s) {
      if(isFromInit == true) hideLoadingDialog();
      // hideLoadingDialog();

      debugPrint("get_user_count_list Error :: $e  $s");
    }
  }


}