
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

import 'AddProjectModel.dart';



class AddProjectController extends GetxController{


  RxBool isApiCallProcessing = false.obs;
  RxBool isVideoPlaying = true.obs;
  RxInt dummyInt = 0.obs;


  ///for get project
  late AddProjectModel getProjectModel;
  RxList<GetProjectData> getProjectList = <GetProjectData>[].obs;
  RxList<VideoPlayerController> videoControllers  = <VideoPlayerController>[].obs;
  RxList<String> imageLinks = <String>[].obs;


  Future<void> getProjectData() async {
    videoControllers.clear();
    imageLinks.clear();
    isApiCallProcessing.value=true;
    var url=APIString.grobizBaseUrl+ APIString.get_app_created_by_grobiz;
    Uri uri=Uri.parse(url);
    debugPrint(url);
    final response = await http.get(uri);
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final resp=jsonDecode(response.body);
      int status =resp['status'];
      if(status==1) {
        getProjectModel = AddProjectModel.fromJson(json.decode(response.body)) ;
        getProjectList.value = getProjectModel.data;
        log(' Data available');
        isApiCallProcessing.value = false;

      }else{
        log('Data not available');
        isApiCallProcessing.value = false;
      }
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  ///delete Project API
  Future<void> deleteProjectApi({String? project_id}) async {
    isApiCallProcessing.value = true;
    var url=APIString.grobizBaseUrl+ APIString.delete_app_created_by_grobiz;
    Uri uri = Uri.parse(url);

    final body = {
      'app_created_auto_id': project_id,

    };
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];

      if (status == 1) {
        Fluttertoast.showToast(
          msg: 'Project has been deleted successfully',
          backgroundColor: Colors.grey,
        );
        getProjectData();
        // getProjectList.removeWhere((item) => item.id == project_id);
        // getProjectList.refresh();
        // Get.find<add_project_controller>().update();

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

    isApiCallProcessing.value = false;
  }


}