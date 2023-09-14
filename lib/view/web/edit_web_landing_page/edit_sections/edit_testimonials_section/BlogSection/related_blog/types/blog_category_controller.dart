// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class BlogCategoriesController extends GetxController {
  RxList relatedBlogs = [].obs;
  final blogType = TextEditingController();
  final valueController = TextEditingController();

  Future getRelatedBlogs({String? blog_id, String? blog_type}) async {
    assert(blog_id != null);
    log("inside getRelatedBlogs ---------1");
    try {
      log("inside getRelatedBlogs ---------2");
      showLoadingDialog();
      relatedBlogs.clear();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.related_blog,
          data: {"blog_id": blog_id, "blog_type": blog_type});
      if (response['error'] == null) {
        hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          relatedBlogs.value = response['body']['data'];
        }
      } else if (response['error'] != null) {
        hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("getRelatedBlogs Error -- $e  $s");
      Future.delayed(
        Duration.zero,
        () => hideLoadingDialog(),
      );
    }
  }

  ///Blogs Categories Api

  // RxList<Map<String, String>> blogsCategories = <Map<String, String>>[].obs;
  RxList<Map<String, String>> blogsCategories = <Map<String, String>>[].obs;

  Future addBlogCategory({String? blog_type, String? value}) async {
    log("inside addBlogCategory ---------1");
    try {
      log("inside addBlogCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.blog_type_add,
          data: {"blog_type": blog_type, "value": value});
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success adding blog category $response");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("addBlogCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  Future editBlogCategory(
      {String? blog_type_id, String? blog_type, String? value}) async {
    log("inside editBlogCategory ---------1");
    try {
      log("inside editBlogCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.blog_type_update,
          data: {
            "blog_type_id": blog_type_id,
            "blog_type": blog_type,
            "value": value
          });
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success editing blog category $response");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("editBlogCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  Future deleteBlogCategory({String? blog_type_id}) async {
    log("inside deleteBlogCategory ---------1");
    try {
      log("inside deleteBlogCategory ---------2");
      showLoadingDialog();

      var response = await HttpHandler.postHttpMethod(
          url: APIString.blog_type_delete,
          data: {"blog_type_id": blog_type_id});
      hideLoadingDialog();
      if (response['error'] == null) {
        // hideLoadingDialog();
        if (response['body']['status'].toString() == "1") {
          // blogsCategories.value = response['body']['data'];
          print("Success deleting blog category $response");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("deleteBlogCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  Future geBlogCategory() async {
    blogsCategories.clear();
    log("inside geBlogCategory ---------1");
    try {
      log("inside geBlogCategory ---------2");
      showLoadingDialog();

      var response =
          await HttpHandler.postHttpMethod(url: APIString.blog_type_get);
      hideLoadingDialog();
      print("response  ${response}");
      print("responseerror    ${response["error"]}");
      if (response['error'] == null) {
        // hideLoadingDialog();
        print("response['body']['status']   ${response['body']['status']}");
        if (response['body']['status'].toString() == "success") {
          print(
              "blog_types runtimeType --- ${response['body']['blog_types'].runtimeType}");
          // blogsCategories.value = response['body']['blog_types'];
          blogsCategories.value =
              blogConvertToMapList(response['body']['blog_types']);
          print(" blogsCategories.value    ${blogsCategories.value}");
        }
      } else if (response['error'] != null) {
        // hideLoadingDialog();
      }
    } catch (e, s) {
      debugPrint("geBlogCategory Error -- $e  $s");
      // Future.delayed(Duration.zero,() => hideLoadingDialog(),);
    }
  }

  // Future geBlogCategory() async {
  //   log("geBlogCategory step --------  +++ 1 ");
  //   blogsCategories.clear();
  //   showLoadingDialog();
  //   try {
  //     log("geBlogCategory step --------  +++  2 ");
  //
  //     var response = await HttpHandler.getHttpMethod(
  //       url: APIString.blog_type_get,
  //     );
  //     hideLoadingDialog();
  //     log("geBlogCategory step --------  +++ 3 ");
  //     if (response['error'] == null) {
  //       print("Success get blog category $response");
  //
  //       if (response['body']['status'].toString() == "success") {
  //         blogsCategories.value = response['body']['blog_types'];
  //       }
  //     } else {
  //       log("geBlogCategory step --------  +++  77 Error");
  //       //error
  //     }
  //   } catch (e, s) {
  //     debugPrint("geBlogCategory Error -- $e  $s");
  //   }
  // }
}

List<Map<String, String>> blogConvertToMapList(List<dynamic> jsonData) {
  List<Map<String, String>> result = [];

  for (var item in jsonData) {
    if (item is Map<String, dynamic>) {
      Map<String, String> mapItem = {};

      mapItem['id'] = item['_id'] ?? '';
      mapItem['blog_type'] = item['blog_type'] ?? '';
      mapItem['value'] = item['value'] ?? '';
      mapItem['updated_at'] = item['updated_at'] ?? '';
      mapItem['created_at'] = item['created_at'] ?? '';

      result.add(mapItem);
    }
  }

  return result;
}
