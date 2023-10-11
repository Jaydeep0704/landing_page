// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:grobiz_web_landing/utils/http_handler/network_http.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class CustomerCallController extends GetxController {
  List<String> dropdownOptions = [
    'Select company size',
    "Self Employed",
    "1 - 10",
    "11 - 50",
    "51 - 200",
    "201 - 500",
    "1001+",
  ];

  RxString selectedOption = 'Select company size'.obs;
  RxString countryCodeController = '+91'.obs;
  RxString phoneController = ''.obs;

  TextEditingController nameController = TextEditingController();
  // TextEditingController countryCodeController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobRollController = TextEditingController();

  clearFields() {
    nameController.clear();
    countryCodeController.value = "+91";
    phoneController.value = "";
    emailController.clear();
    companyNameController.clear();
    jobRollController.clear();
    selectedOption.value = 'Select company size';
  }

  Future submitDetails({
    String? name,
    String? phoneCode,
    String? phoneNumber,
    String? email,
    String? companyName,
    String? companySize,
    String? jobRoll,
  }) async {
    try {
      showLoadingDialog();
      var response = await HttpHandler.postHttpMethod(
          url: APIString.customer_call_form,
          data: {
            "name": name,
            "country_code": phoneCode,
            "phone_number": phoneNumber,
            "bussiness_email": email,
            "company_name": companyName,
            "company_size": companySize,
            "job_roll": jobRoll,
          });
      hideLoadingDialog();
      if (response['error'] == null) {
        if (response['body']['status'].toString() == "1") {
          print(" success response --- >  $response");
        }
      } else if (response['error'] != null) {
        showSnackbar(message: "Error");
      }
    } catch (e, s) {
      debugPrint("getFaqType Error -- $e  $s");
      hideLoadingDialog();
    }
  }
}
