// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
class CareersController extends GetxController{

  List<String> dropdownOptions = [
    'Select Designations',
    // 'Option 1',
    // 'Option 2',
    // 'Option 3',
    // 'Option 4',
    // 'Option 5',
    "Android Developer",
    "Flutter developer",
    "Python App Developer",
    "Backend developer",
    "Frontend Developer",
    "Software Security",
    "Software Tester",
    "Marketing",
    "Sales",
    "UI/UX Designer",
  ];

  RxString selectedOption = 'Select Designations'.obs;


  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Future submitForm({var pathsFile, var pathsFileName,String? email, String? designation, String? description}) async {
    showLoadingDialog();
    log("step --------  1");

    var url = APIString.grobizBaseUrl + APIString.career_form;
    log("step --------  2");

    Uri uri = Uri.parse(url);
    log("step --------  3");

    var request = http.MultipartRequest("POST", uri);
    log("step --------  4");

    log("file1 ------> $pathsFile ${pathsFile.runtimeType} ");
    log("file2 ------> $pathsFileName ${pathsFileName.runtimeType} ");
    try {
      log("step --------  5");

      if (pathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              "resume",
              pathsFile,
              contentType: MediaType('application', 'x-tar'),
              filename: pathsFileName.toString().removeAllWhitespace,
            ),
          );
        } else {
          // hideLoadingDialog();
          showSnackbar(title: "", message: "Not Allowed");
        }
      }
      log("step --------  6");
    }
    catch (exception) {
      log("step --------  7");
      request.fields["images"] = '';
      log('pic not selected');
    }

    request.fields["email"] = email!;
    request.fields["job_position"] = designation!;
    request.fields["description"] = description!;
    log("step --------  8");

    debugPrint(request.fields.toString());
    log("step --------  9");

    http.Response response = await http.Response.fromStream(await request.send());

    debugPrint("career_form response  ----  $response");
    debugPrint("career_form response.statusCode  ----  ${response.statusCode}");
    hideLoadingDialog();
    log("step --------  10");

    if (response.statusCode == 200) {
      log("step -------- 11 ");
      // Navigator.pop(context);
      final resp = jsonDecode(response.body);
      log("step --------  12");

      debugPrint(resp.toString());

      int status = resp['status'];
      if (status == 1) {
        log("step --------  13");
        showSnackbar(title: "", message: "Sent successfully");
        emailController.clear();
        descController.clear();
        selectedOption.value = 'Select Designations';

      } else {
        log("step --------  14");
        String message = resp['msg'];
        log(message);
      }
      log("step --------  15");
    } else if (response.statusCode == 500) {
      hideLoadingDialog();
      // numberBannerController.getPartnerLogo();
      showSnackbar(title: "", message: "Server Error");

    } else {
      // numberBannerController.getPartnerLogo();
      hideLoadingDialog();
      showSnackbar(title: "", message: "Error");

    }

  }

}