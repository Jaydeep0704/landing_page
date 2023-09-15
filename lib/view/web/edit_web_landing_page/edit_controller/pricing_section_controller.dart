import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
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
      // Get.focusScope!.unfocus();
      // log("Get.focusScope <><><><><>   ${Get.focusScope != null}");
      // if (Get.focusScope != null) {
      //   Get.focusScope!.unfocus();
      // }
      log("api ------ ${APIString.getPlansLandingPage}");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.getPlansLandingPage,
          data: {
            "latitude": lat ?? "21.2378888",
            "longitude": long ?? "72.863352",
          });
      hideLoadingDialog();
      log("0-=-0=-0=-0-=0=-0=-0=-0-=0-=0-=0=-0=-0-= ${response}");

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

  // Future getPlansData1({bool? showLoader = true,String? lat,String? long}) async {
  //   log("inside getPlansData ---------1");
  //   // isApiCallProcessing.value=true;
  //   showLoadingDialog();
  //   plansList.clear();
  //   plansSHowHidBoolList.clear();
  //   Get.focusScope!.unfocus();
  //
  //   log("inside getPlansData ---------2");
  //   final body = {
  //     // "latitude" : "21.2378888",
  //     // "longitude" : "72.863352"
  //     "latitude" : lat ?? "21.2378888",
  //     "longitude" : long ?? "72.863352",
  //   };
  //
  //   log("inside getPlansData ---------3");
  //   var url=APIString.grobizBaseUrl+APIString.getPlansLandingPage;
  //   var uri = Uri.parse(url);
  //   log("inside getPlansData ---------4");
  //
  //   log("getPlansData url =------ $uri");
  //   final response = await http.post(uri,body: body);
  //   hideLoadingDialog();
  //   log("inside getPlansData ---------5");
  //   if (response.statusCode == 200) {
  //     log("inside getPlansData ---------6");
  //     final resp=jsonDecode(response.body);
  //     int status=resp['status'];
  //     log("Response status==>$status");
  //     log("inside getPlansData ---------7");
  //     hideLoadingDialog();
  //     if(status==1){
  //       log("inside getPlansData ---------8");
  //       log("get_plan_lists  ---- ${resp["get_plan_lists"][0]}");
  //       plansList.value = resp["get_plan_lists"];
  //       plansSHowHidBoolList.value = RxList<bool>.generate(plansList.length, (index) => false);
  //       // showSnackbar(title: "Success", message: "${resp['msg']}");
  //       log("inside getPlansData ---------9");
  //
  //     }
  //     else {
  //       log("inside getPlansData ---------10");
  //       String msg=resp['msg'];
  //       Fluttertoast.showToast(msg: msg, backgroundColor: Colors.grey,);
  //       // isApiCallProcessing.value=false;
  //     }
  //   }
  //   else if(response.statusCode==500){
  //     log("inside getPlansData ---------11");
  //     hideLoadingDialog();
  //     //isApiProcessing=false;
  //     Fluttertoast.showToast(msg: "Server Error", backgroundColor: Colors.grey,);
  //   }
  // }
}
