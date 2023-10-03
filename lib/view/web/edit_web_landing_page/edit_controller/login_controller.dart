import 'dart:convert';
import 'dart:developer';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/local_storage.dart';
import 'package:grobiz_web_landing/page_route/route.dart';
import 'package:grobiz_web_landing/utils/shared_preference/shared_preference_services.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/web_landing_screen.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isApiProcessing = false.obs;
  Future signInApi(String email, String password) async {
    showLoadingDialog();
    final body = {
      "email": email,
      "password": password,
    };

    var url = APIString.grobizBaseUrl + APIString.login_landing_page;
    var uri = Uri.parse(url);

    log("login url =------ $uri");
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log("Response status==>$status");
      hideLoadingDialog();
      if (status == 1) {
        log("if status success");
        // Get.off(()=>const EditWebLandingScreen());
        Get.offNamed(PageRoutes.editWebLandingPage);

        // Get.to(()=>const WebLandingScreen());
        Fluttertoast.showToast(
          msg: "You have logged in successfully",
          backgroundColor: Colors.grey,
        );
        setDataToLocalStorage(
            dataType: LocalStorage.stringType, prefKey: LocalStorage.isLogin);
        saveLoginSession();
      } else {
        String msg = resp['msg'];
        Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.grey,
        );
        isApiProcessing.value = false;
      }
    } else if (response.statusCode == 500) {
      hideLoadingDialog();
      //isApiProcessing=false;
      Fluttertoast.showToast(
        msg: "Server Error",
        backgroundColor: Colors.grey,
      );
    }
  }

  Future<void> saveLoginSession() async {
    log("Inside session");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_login', true);
    // Get.to(()=>const EditWebLandingScreen());
    log("Inside session at ending");
  }

  Future logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_login', false);
    Future.delayed(Duration.zero, () {
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //   builder: (context) {
      //     return const WebLandingScreen();
      //   },
      // ));
      Get.offNamed(PageRoutes.webLandingPage);
    });
  }
}
