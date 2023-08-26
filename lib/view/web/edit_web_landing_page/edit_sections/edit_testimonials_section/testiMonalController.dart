import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:http/http.dart' as http;

class EditTestimonalController extends GetxController {
  ///Partner Banner Logos

  RxList appLogoListt = [].obs;
  RxList getTestimonal = [].obs;
  RxString msg = "".obs;

  RxBool testimonial1Switch = false.obs;
  RxBool testimonial2Switch = false.obs;



  GetAppLogoes() async {
    log("step --------  +++ 1 ");
    showLoadingDialog();
    // hideLoadingDialog();
    try {
      log("step --------  +++  2 ");
      appLogoListt.clear();

      Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_app_logo_list,
      );
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          appLogoListt.value = response['body']["data"];
          msg.value = response['body']["msg"];
        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("get logo Error -- $e  $s");
    }
  }

  Future GetTestimonal() async {
    log("step --------  +++ 1 ");
    showLoadingDialog();
    // hideLoadingDialog();
    try {
      log("step --------  +++  2 ");
      getTestimonal.clear();

      Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_testimonials,
      );
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          getTestimonal.value = response['body']["data"];
          msg.value = response['body']["msg"];
        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("get logo Error -- $e  $s");
    }
  }

  ///delete CheckOut Info
  Future<void> deleteTestiMonalApi({String? id})  async {

    var url = APIString.grobizBaseUrl + APIString.delete_testimonials;
//userlist_auto_id
    final body = {
      'testimonial_auto_id':id,
    };

    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log('USer Id: ' + status.toString());
      if (status == 1) {

        Fluttertoast.showToast(
          msg:  'successfully Deleted' ,
          backgroundColor: Colors.grey,
        );
        // Get.back();
        GetTestimonal();
        print("Deleted");
      } else {
        String msg = resp['msg'];

        Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.grey,
        );
      }
    } else if (response.statusCode == 500) {

      Fluttertoast.showToast(
        msg: 'Server error',
        backgroundColor: Colors.grey,
      );
    }
  }
}