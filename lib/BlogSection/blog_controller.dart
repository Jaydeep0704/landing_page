import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../widget/common_snackbar.dart';
import 'blog_details_list.dart';

class EditBlogController extends GetxController {

  late VideoPlayerController videoController;

  RxBool isVideoInitialized = false.obs;

  RxList blogdata = [].obs;
  RxList blogtype = [].obs;
  RxString msg = "".obs;

  RxList blogdetails = [].obs;

  GetBlogData() async {
    log("step --------  +++ 1 ");
    showLoadingDialog();
    // hideLoadingDialog();
    try {
      log("step --------  +++  2 ");
      blogdata.clear();

      Get.focusScope!.unfocus();
      var response = await HttpHandler.getHttpMethod(
        url: APIString.get_blog,
      );
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          blogdata.value = response['body']["data"];
          blogtype.clear();
          for (var blog in blogdata) {
            blogtype.add(blog['blogTypeKey']);
          }

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

  ///delete blog
  Future<void> deleteBlogApi({String? id})  async {

    var url = APIString.grobizBaseUrl + APIString.delete_blog;
//blog_auto_id
    final body = {
      'blog_auto_id':id,
    };

    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log('USer Id: $status');
      if (status == 1) {

        Fluttertoast.showToast(
          msg:  'successfully Deleted' ,
          backgroundColor: Colors.grey,
        );
        // Get.back();
        GetBlogData();
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

  GetBlogDetailsData({String? id}) async {
    log("step --------  +++ 1 ");
    showLoadingDialog();
    // hideLoadingDialog();
    try {
      log("step --------  +++  2 ");
      blogdetails.clear();

      Get.focusScope!.unfocus();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.get_blog_details,
          data: {
            "blog_auto_id":id,
          });
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          blogdetails.value = response['body']["data"];
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

  add_blog_details_api({String? id,String? title, String? description}) async {
    log("step --------  +++ 1 ");
    showLoadingDialog();
    //blog_auto_id,title,description
    try {
      log("step --------  +++  2 ");
      Get.focusScope!.unfocus();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.add_blog_details,
          data: {
            "blog_auto_id":id,
            "title":title,
            "description":description,
            // "media":,
            // "mediaTypeKey":""
          });
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          showSnackbar(title: "Success", message: "${response['body']['msg']}");
          Get.off(BlogDetailslist(id: id!,));

        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("get logo Error -- $e  $s");
    }
  }

  edit_blog_details_api({String? blog_deatils_id,String? blog_id,String? title, String? description}) async {
    log("step --------  +++ 1 ");
    showLoadingDialog();
    //blog_details_auto_id,
    // blog_auto_id,
    // title,
    // description
    try {
      log("step --------  +++  2 ");
      Get.focusScope!.unfocus();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.edit_blog_details,
          data: {
            "blog_details_auto_id":blog_deatils_id,
            "blog_auto_id":blog_id,
            "title":title,
            "description":description,
          });
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          showSnackbar(title: "Success", message: "${response['body']['msg']}");
          Get.to(BlogDetailslist(id: blog_id!,));

        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("get logo Error -- $e  $s");
    }
  }

  Future<void> delete_blog_details({String? id,String? deatils_id})  async {
    var url = APIString.grobizBaseUrl + APIString.delete_blog_details;
//blog_auto_id,blog_details_auto_id
    final body = {
      'blog_auto_id':id,
      'blog_details_auto_id':deatils_id,
    };
    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log('USer Id: $status');
      if (status == 1) {

        Fluttertoast.showToast(
          msg:  'successfully Deleted' ,
          backgroundColor: Colors.grey,
        );
        // Get.back();
        GetBlogDetailsData(id: id);
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