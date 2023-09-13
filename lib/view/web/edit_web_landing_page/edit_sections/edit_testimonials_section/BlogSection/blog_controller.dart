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

import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'blog_details_list.dart';

class EditBlogController extends GetxController {
  late VideoPlayerController videoController;

  RxBool isVideoInitialized = false.obs;

  RxList blogdata = [].obs;
  RxList blogdataReadMore = [].obs;

  RxList blogtype = [].obs;
  RxString msg = "".obs;

  RxList blogDetails = [].obs;

  getBlogData() async {
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
          for (int i = 0; i < blogdata.length; i++) {
            blogdataReadMore.add(false);
          }
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
  Future<void> deleteBlogApi({String? id}) async {
    var url = APIString.grobizBaseUrl + APIString.delete_blog;
//blog_auto_id
    final body = {
      'blog_auto_id': id,
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
          msg: 'successfully Deleted',
          backgroundColor: Colors.grey,
        );
        // Get.back();
        getBlogData();
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

  // getBlogDetailsData({String? id}) async {
  //   showLoadingDialog();
  //   try {
  //     blogDetails.clear();
  //     var response = await HttpHandler.postHttpMethod(
  //         url: APIString.get_blog_details,
  //         data: {
  //           "blog_auto_id":id,
  //         });
  //     hideLoadingDialog();
  //     if (response['error'] == null) {
  //
  //       if (response['body']['status'].toString() == "1") {
  //         blogDetails.value = response['body']["data"];
  //         msg.value = response['body']["msg"];
  //       }
  //     } else {
  //     }
  //   } catch (e, s) {
  //     debugPrint("get logo Error -- $e  $s");
  //   }
  // }
  Future getBlogDetailsData({String? id}) async {
    log("inside getBlogDetailsData ---------1");
    try {
      log("inside getBlogDetailsData ---------2");
      showLoadingDialog();
      blogDetails.clear();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.get_blog_details,
          data: {
            "blog_auto_id": id,
          });
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          blogDetails.value = response['body']['data'];
        }
      } else if (response['error'] != null) {
        // showSnackbar(title: "Warning",message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("getBlogDetailsData Error -- $e  $s");
      Future.delayed(
        Duration.zero,
        () => hideLoadingDialog(),
      );
    }
  }

  addBlogDetailsApi({String? id, String? title, String? description}) async {
    showLoadingDialog();
    //blog_auto_id,title,description
    try {
      log("step --------  +++  2 ");
      var response = await HttpHandler.postHttpMethod(
          url: APIString.add_blog_details,
          data: {
            "blog_auto_id": id,
            "title": title,
            "description": description,
            // "media":,
            // "mediaTypeKey":""
          });
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          showSnackbar(title: "Success", message: "${response['body']['msg']}");
          Get.off(BlogDetailsList(
            id: id!,
          ));
        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("get logo Error -- $e  $s");
    }
  }

  editBlogDetailsApi(
      {String? blogDetailsId,
      String? blogId,
      String? title,
      String? description}) async {
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
            "blog_details_auto_id": blogDetailsId,
            "blog_auto_id": blogId,
            "title": title,
            "description": description,
          });
      log("step --------  +++ 3 ");
      hideLoadingDialog();
      if (response['error'] == null) {
        log("step --------  +++  4");

        if (response['body']['status'].toString() == "1") {
          showSnackbar(title: "Success", message: "${response['body']['msg']}");
          Get.to(BlogDetailsList(
            id: blogId!,
          ));
        }
      } else {
        log("step --------  +++  77 Error");
        //error
      }
    } catch (e, s) {
      debugPrint("get logo Error -- $e  $s");
    }
  }

  Future<void> deleteBlogDetails({String? id, String? detailsId}) async {
    var url = APIString.grobizBaseUrl + APIString.delete_blog_details;
    final body = {
      'blog_auto_id': id,
      'blog_details_auto_id': detailsId,
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
          msg: 'successfully Deleted',
          backgroundColor: Colors.grey,
        );
        // Get.back();
        getBlogDetailsData(id: id);
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
