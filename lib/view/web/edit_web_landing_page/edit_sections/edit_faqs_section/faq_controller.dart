import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class FaqController extends GetxController {
  RxList<Map<String, String>> faqType = <Map<String, String>>[].obs;
  RxList faqTypeShowHide = [].obs;
  RxList faqs = [].obs;
  RxList faqShowHide = [].obs;

  final faqTypeController = TextEditingController();
  final faqTitle = TextEditingController();
  final faqDesc = TextEditingController();

  Future addFaqType({String? title}) async {
    log("inside addFaqType ---------1");
    try {
      log("inside addFaqType ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.add_faq_type,
        data: {
          "title": title,
        },
      );
      if (response['error'] == null) {
        log("inside addFaqType ---------3");

        if (response['body']['status'].toString() == "success") {
          log("response[data]  ---- ${response['body']["data"]}");


          showSnackbar(title: "Success", message: "Faq type added");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside addFaqType ---------4");

        showSnackbar(title: "Warning", message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside addFaqType ---------5");
      debugPrint("addFaqType Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  Future updateFaqType({
    String? title,
    String? faqTypeId,
  }) async {
    log("inside updateFaqType ---------1");
    try {
      log("inside updateFaqType ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.update_faq_type,
        data: {"title": title, "faq_type_id": faqTypeId},
      );
      if (response['error'] == null) {
        log("inside updateFaqType ---------3");

        if (response['body']['status'].toString() == "success") {

          showSnackbar(title: "Success", message: "Faq Updated");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside updateFaqType ---------4");

        showSnackbar(title: "Warning", message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside updateFaqType ---------5");
      debugPrint("updateFaqType Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  Future deleteFaqType({
    String? faqTypeId,
  }) async {
    log("inside deleteFaqType ---------1");
    try {
      log("inside deleteFaqType ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.delete_faq_type,
        data: {"faq_type_id": faqTypeId},
      );
      if (response['error'] == null) {
        log("inside deleteFaqType ---------3");

        if (response['body']['status'].toString() == "success") {
          log("response[data]  ---- ${response['body']["data"]}");


          showSnackbar(title: "Success", message: "Faq Deleted");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside deleteFaqType ---------4");

        showSnackbar(title: "Warning", message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside deleteFaqType ---------5");
      debugPrint("deleteFaqType Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  Future getFaqType() async {
    log("inside getFaqType ---------1");
    try {
      log("inside getFaqType ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.get_faq_type,
      );
      hideLoadingDialog();
      if (response['error'] == null) {
        log("inside getFaqType ---------3");

        if (response['body']['status'].toString() == "success") {
          log("response[faq_types]  ---- ${response['body']["faq_types"]}");
          faqType.value =
              faqTypeConvertToMapList(response['body']["faq_types"]);
          faqTypeShowHide.value =
              List.generate(faqType.length, (index) => true);
        }
      } else if (response['error'] != null) {
        log("inside getFaqType ---------4");

        showSnackbar(title: "Warning", message: "Error");
        // hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside getFaqType ---------5");
      debugPrint("getFaqType Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  List<Map<String, String>> faqTypeConvertToMapList(List<dynamic> jsonData) {
    List<Map<String, String>> result = [];

    for (var item in jsonData) {
      if (item is Map<String, dynamic>) {
        Map<String, String> mapItem = {};

        mapItem['_id'] = item['_id'] ?? '';
        mapItem['title'] = item['title'] ?? '';
        mapItem['updated_at'] = item['updated_at'] ?? '';
        mapItem['created_at'] = item['created_at'] ?? '';

        result.add(mapItem);
      }
    }

    return result;
  }

  Future addFaq({
    String? title,
    String? description,
    String? faqTypeId,
  }) async {
    log("inside addFaq ---------1");
    try {
      log("inside addFaq ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.add_faq,
        data: {
          "title": title,
          "description": description,
          "faq_type_id": faqTypeId,
        },
      );
      if (response['error'] == null) {
        log("inside addFaq ---------3");

        if (response['body']['status'].toString() == "success") {
          log("response[data]  ---- ${response['body']["data"]}");


          showSnackbar(title: "Success", message: "Faq added");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside addFaq ---------4");

        showSnackbar(title: "Warning", message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside addFaq ---------5");
      debugPrint("addFaq Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  Future updateFaq({
    String? title,
    String? description,
    String? faqTypeId,
    String? faqId,
  }) async {
    log("inside updateFaqType ---------1");
    try {
      log("inside updateFaqType ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.update_faq,
        data: {
          "title": title,
          "description": description,
          "faq_type_id": faqTypeId,
          "faq_id": faqId,
        },
      );
      if (response['error'] == null) {
        log("inside updateFaqType ---------3");

        if (response['body']['status'].toString() == "success") {
          log("response[data]  ---- ${response['body']["data"]}");


          showSnackbar(title: "Success", message: "Faq Updated");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside updateFaqType ---------4");

        showSnackbar(title: "Warning", message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside updateFaqType ---------5");
      debugPrint("updateFaqType Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  Future deleteFaq({
    String? faqId,
  }) async {
    log("inside deleteFaq ---------1");
    try {
      log("inside deleteFaq ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.delete_faq,
        data: {
          "faq_id": faqId,
        },
      );
      if (response['error'] == null) {
        log("inside deleteFaq ---------3");

        if (response['body']['status'].toString() == "success") {
          log("response[data]  ---- ${response['body']["data"]}");


          showSnackbar(title: "Success", message: "Faq deleted");
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside deleteFaq ---------4");

        showSnackbar(title: "Warning", message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside deleteFaq ---------5");
      debugPrint("deleteFaq Error -- $e  $s");
      hideLoadingDialog();
    }
  }

  Future getFaq({
    String? faqTypeId,
  }) async {
    log("inside getFaq ---------1");
    try {
      log("inside getFaq ---------2");

      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
        url: APIString.get_faq,
      );
      if (response['error'] == null) {
        log("inside getFaq ---------3");

        if (response['body']['status'].toString() == "success") {
          log("response[data]  ---- ${response['body']["faq"]}");
          faqs.value = response['body']["faq"];
          faqShowHide.value = List.generate(faqs.length, (index) => false);
          hideLoadingDialog();
        }
      } else if (response['error'] != null) {
        log("inside getFaq ---------4");

        showSnackbar(title: "Warning", message: "Error");
        hideLoadingDialog();
      }
    } catch (e, s) {
      log("inside getFaq ---------5");
      debugPrint("getFaq Error -- $e  $s");
      hideLoadingDialog();
    }
  }
}
