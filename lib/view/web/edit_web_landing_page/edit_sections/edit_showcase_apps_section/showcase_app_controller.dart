// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/local_storage.dart';
import 'package:grobiz_web_landing/utils/shared_preference/shared_preference_services.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../../../../../config/api_string.dart';
import '../../../../../utils/http_handler/network_http.dart';
import '../../../../../widget/loading_dialog.dart';

class ShowCaseAppsController extends GetxController {
  late VideoPlayerController videoController;

  RxBool isVideoInitialized = false.obs;
  RxBool titleSwitch = false.obs;
  RxBool carouselSwitch = false.obs;

  RxString couponCode = "".obs;
  RxString couponUserId = "".obs;
  RxString couponRegisterDate = "".obs;
  RxString couponRegisterTime = "".obs;
  RxString couponUpdatedAt = "".obs;
  RxString couponCreatedAt = "".obs;
  RxString couponId = "".obs;

  RxList getCouponList = [].obs;

  Future generateCoupon() async {
    log("inside getCouponData ---------1");
    try {
      log("inside getCouponData ---------2");

      showLoadingDialog();
      // Get.focusScope!.unfocus();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.generate_coupon_code,
        // data: {},
      );
      if (response['error'] == null) {
        log("inside getCouponData ---------3");

        if (response['body']['status'].toString() == "1") {
          log("response[data]  ---- ${response['body']["data"]}");

          // couponCode.value = response['body']["data"]["coupon_code"];
          // couponUserId.value = response['body']["data"]["user_id"];
          // couponRegisterDate.value = response['body']["data"]["register_date"];
          // couponRegisterTime.value = response['body']["data"]["register_time"];
          // couponUpdatedAt.value = response['body']["data"]["updated_at"];
          // couponCreatedAt.value = response['body']["data"]["created_at"];
          // couponId.value = response['body']["data"]["_id"];

          var data = response['body']["data"];
          setDataToLocalStorage(
              dataType: LocalStorage.stringType,
              prefKey: LocalStorage.couponCode,
              stringData: data["coupon_code"]);
          setDataToLocalStorage(
              dataType: LocalStorage.stringType,
              prefKey: LocalStorage.couponUserId,
              stringData: data["user_id"]);
          setDataToLocalStorage(
              dataType: LocalStorage.stringType,
              prefKey: LocalStorage.couponRegisterDate,
              stringData: data["register_date"]);
          setDataToLocalStorage(
              dataType: LocalStorage.stringType,
              prefKey: LocalStorage.couponRegisterTime,
              stringData: data["register_time"]);
          setDataToLocalStorage(
              dataType: LocalStorage.stringType,
              prefKey: LocalStorage.couponUpdatedAt,
              stringData: data["updated_at"]);
          setDataToLocalStorage(
              dataType: LocalStorage.stringType,
              prefKey: LocalStorage.couponCreatedAt,
              stringData: data["created_at"]);
          setDataToLocalStorage(
              dataType: LocalStorage.stringType,
              prefKey: LocalStorage.couponId,
              stringData: data["_id"]);

          showSnackbar(message: "Coupon Generated");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside getCouponData ---------4");

        showSnackbar(message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside getCouponData ---------5");
      debugPrint("getCouponData Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  Future getWebCouponCodeList() async {
    getCouponList.clear();
    log("inside getCouponData ---------1");
    try {
      log("inside getCouponData ---------2");

      showLoadingDialog();
      // Get.focusScope!.unfocus();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.get_web_coupon_code_list,
        data: {
          "user_id": couponUserId.value,
        },
      );
      if (response['error'] == null) {
        log("inside getCouponData ---------3");

        if (response['body']['status'].toString() == "1") {
          log("response[data]  ---- ${response['body']["data"]}");

          // getCouponList.value =  response['body']["data"];
          getCouponList.add(response['body']["data"]);

          showSnackbar(message: "Coupon Generated");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside getCouponData ---------4");

        showSnackbar(message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside getCouponData ---------5");
      debugPrint("getCouponData Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  ///Edit Banner Text

  RxList ShowcaseData = [].obs;

  RxString msg = "".obs;
  RxBool isApiCallProcessing = false.obs;

  ///get Baner text
  getShowCaseApi() async {
    log("step --------  +++ 1 ");
    // showLoadingDialog();
    try {
      log("step --------  +++  2 ");
      ShowcaseData.clear();

      Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_userlist,
      );
      log("step --------  +++ 3 ");
      // hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          ShowcaseData.value = response['body']["data"];
          msg.value = response['body']["msg"];
        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("getData Error -- $e  $s");
    }
  }

  ///delete CheckOut Info
  Future<void> deleteShowCaseApi({String? id}) async {
    isApiCallProcessing.value = false;
    var url = APIString.grobizBaseUrl + APIString.delete_userlist;
//userlist_auto_id
    final body = {
      'userlist_auto_id': id,
    };

    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log('USer Id: $status');
      if (status == 1) {
        isApiCallProcessing.value = true;
        Fluttertoast.showToast(
          msg: 'successfully Deleted',
          backgroundColor: Colors.grey,
        );
        // Get.back();
        getShowCaseApi();
      } else {
        String msg = resp['msg'];
        isApiCallProcessing.value = false;
        Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.grey,
        );
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value = false;
      Fluttertoast.showToast(
        msg: 'Server error',
        backgroundColor: Colors.grey,
      );
    }
  }
}
