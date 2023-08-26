import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../../../../../config/api_string.dart';
import '../../../../../utils/http_handler/network_http.dart';
import '../../../../../widget/loading_dialog.dart';

class BenefitBannerController extends GetxController{

  late VideoPlayerController videoController;

  RxBool isVideoInitialized = false.obs;


  ///Edit Banner Text

  RxList DataList = [].obs;
  RxList bannerInfoReadMore = [].obs;
  RxString msg = "".obs;
  RxBool isApiCallProcessing = false.obs;

///get Baner text
  Future getDataApi() async {
    log("step --------  +++ 1 ");
    showLoadingDialog();
    // hideLoadingDialog();
    try {
      log("step --------  +++  2 ");
      DataList.clear();

      Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_benefit_list,
      );
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          DataList.value = response['body']["data"];
          for (int i = 0; i < DataList.length; i++) {
            bannerInfoReadMore.add(false);
          }
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

///Add Baner text
  Future<void> addDataApi({String? title, String? description})  async {
    isApiCallProcessing.value=false;
    var url = APIString.grobizBaseUrl + APIString.add_benefit_list;

//title,description
    final body = {
      'title':title,
      'description':description,

    };

    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log('USer Id: ' + status.toString());
      if (status == 1) {
        isApiCallProcessing.value=true;
        Fluttertoast.showToast(
          msg:  'successfully Added' ,
          backgroundColor: Colors.grey,
        );
         Get.back();
        getDataApi();
        print("Added");
      } else {
        String msg = resp['msg'];
        isApiCallProcessing.value=false;
        Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.grey,
        );
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value=false;
      Fluttertoast.showToast(
        msg: 'Server error',
        backgroundColor: Colors.grey,
      );
    }
  }

  ///Update Baner text
  Future<void> updateDataApi({String? title,String? id, String? description})  async {
    isApiCallProcessing.value=false;
    var url = APIString.grobizBaseUrl + APIString.edit_benefit_list;

//benefit_list_auto_id,title,description
    final body = {
      'benefit_list_auto_id':id,
      'title':title,
      'description':description,

    };

    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log('USer Id: ' + status.toString());
      if (status == 1) {
        isApiCallProcessing.value=true;
        Fluttertoast.showToast(
          msg:  'successfully updated' ,
          backgroundColor: Colors.grey,
        );
        Get.back();
        getDataApi();
        print("updated");
      } else {
        String msg = resp['msg'];
        isApiCallProcessing.value=false;
        Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.grey,
        );
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value=false;
      Fluttertoast.showToast(
        msg: 'Server error',
        backgroundColor: Colors.grey,
      );
    }
  }

  ///delete banner text
  Future<void> deleteDataApi({String? id})  async {
    isApiCallProcessing.value=false;
    var url = APIString.grobizBaseUrl + APIString.delete_benefit_list;

//benefit_list_auto_id,title,description
    final body = {
      'benefit_list_auto_id':id,
    };

    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log('USer Id: ' + status.toString());
      if (status == 1) {
        isApiCallProcessing.value=true;
        Fluttertoast.showToast(
          msg:  'successfully Deleted' ,
          backgroundColor: Colors.grey,
        );
       // Get.back();
        getDataApi();
        print("Deleted");
      } else {
        String msg = resp['msg'];
        isApiCallProcessing.value=false;
        Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.grey,
        );
      }
    } else if (response.statusCode == 500) {
      isApiCallProcessing.value=false;
      Fluttertoast.showToast(
        msg: 'Server error',
        backgroundColor: Colors.grey,
      );
    }
  }





}