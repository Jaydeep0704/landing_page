// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../../../../../config/api_string.dart';
import '../../../../../utils/http_handler/network_http.dart';

class CheckOutInfoController extends GetxController {
  late VideoPlayerController videoController;

  RxBool isVideoInitialized = false.obs;

  ///Edit Banner Text

  RxList checkInfoDataList = [].obs;
  RxList videoList = [].obs;
  RxString msg = "".obs;
  RxBool isApiCallProcessing = false.obs;

  ///get Baner text
  Future getCheckOutApi() async {
    log("step --------  +++ 1 ");
    // showLoadingDialog();
    try {
      log("step --------  +++  2 ");
      checkInfoDataList.clear();

      Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_checkout,
      );
      log("step --------  +++ 3 ");
      // hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          videoList.clear();
          checkInfoDataList.value = response['body']["data"];

          msg.value = response['body']["msg"];
          for (int i = 0; i < checkInfoDataList.length; i++) {
            if (checkInfoDataList[i]["file_media_type"] == "video") {
              debugPrint(
                  "FileType ==> ${checkInfoDataList[i]["file_media_type"]}");
              videoList.add(checkInfoDataList[i]);
            }
          }
        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("getData Error -- $e  $s");
    }
  }

  void initializeVideo() async {
    for (int i = 0; i < videoList.length; i++) {
      videoController = VideoPlayerController.networkUrl(
          Uri.parse(APIString.mediaBaseUrl + videoList[0]["files"].toString()));
      String videoTitle = videoList[i]["title"];
      debugPrint("VideoTitle: $videoTitle");
    }
    //videoController = VideoPlayerController.networkUrl(Uri.parse("https://grobiz.app/GrobizEcommerceSuperAdminTest/images/Web/campaign1.mp4"));
    await videoController.initialize().whenComplete(() {
      videoController.setLooping(true);
      videoController.setVolume(0);
      isVideoInitialized.value = true;
      videoController.play();
    });
  }

  ///delete CheckOut Info
  Future<void> deleteCheckOutDataApi({String? id}) async {
    isApiCallProcessing.value = false;
    var url = APIString.grobizBaseUrl + APIString.delete_checkout;
//checkout_auto_id
    final body = {
      'checkout_auto_id': id,
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
        getCheckOutApi();
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
