// ignore_for_file: implementation_imports, prefer_typing_uninitialized_variables
import 'package:flutter/services.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/customer_call_form/customer_call_controller.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/common_textfield.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomerCallScreen extends StatefulWidget {
  const CustomerCallScreen({Key? key}) : super(key: key);

  @override
  State<CustomerCallScreen> createState() => _CustomerCallScreenState();
}

class _CustomerCallScreenState extends State<CustomerCallScreen> {
  final customerCallController = Get.find<CustomerCallController>();
  // final customerCallController = Get.put(CustomerCallController());
  final ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool submitPressed = false;
  bool phoneNumberEmpty = false;

  @override
  void initState() {
    super.initState();
    customerCallController.clearFields();
    KeyboardScroll.addScrollListener(scrollController);
  }

  @override
  void dispose() {
    KeyboardScroll.removeScrollListener();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            Get.width > 501
                ? const Expanded(child: SizedBox())
                : const SizedBox(),
            Container(
              padding: const EdgeInsets.only(
                  right: 25, left: 25, bottom: 25, top: 25),
              width: Get.width > 800
                  ? 700
                  : Get.width > 501
                      ? 400
                      : Get.width,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: () => Get.back(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.arrow_back_sharp,
                                  color: AppColors.blackColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Go back",
                                  style: AppTextStyle.regular700.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 400,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 25),
                            Text("Get Free Consultation",
                                style: AppTextStyle.regularBold
                                    .copyWith(fontSize: 25)),
                            const SizedBox(height: 20),
                            const Text("Name"),
                            const SizedBox(height: 10),
                            CommonTextField(
                              needValidation: true,
                              textInputType: TextInputType.text,
                              controller: customerCallController.nameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]*$')),
                              ],
                              validator: validateName,
                              boxShadow: false,
                              hintText: "Name",
                            ),
                            const SizedBox(height: 20),
                            const Text("Phone Number"),
                            const SizedBox(height: 10),
                            Obx(() {
                              return customerCallController.countryCodeController.value.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IntlPhoneField(
                                          focusNode: focusNode,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                          ],
                                          validator: (v) {
                                            if (v!.toString().isEmpty) {
                                              print("Enter Phone Number");
                                              print("value of v :-: $v");
                                              showSnackbar(message: "Enter Phone Number");
                                            }
                                            return null;
                                          },
                                          languageCode: "en",
                                          initialCountryCode: 'IN',
                                          onChanged: (phone) {
                                            customerCallController
                                                .phoneController
                                                .value = phone.number;
                                            customerCallController
                                                .countryCodeController
                                                .value = phone.countryCode;
                                          },
                                          onCountryChanged: (country) {
                                            customerCallController
                                                .countryCodeController
                                                .value = country.dialCode;
                                          },
                                          decoration: InputDecoration(
                                            fillColor: AppColors.whiteColor,
                                            isDense: true,
                                            filled: true,
                                            counterText: "",
                                            hintText: "Phone Number",
                                            hintStyle: AppTextStyle.regular400
                                                .copyWith(
                                                    color:
                                                        AppColors.borderColor,
                                                    fontSize: 13),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: submitPressed &&
                                                            customerCallController
                                                                .phoneController
                                                                .value
                                                                .isEmpty
                                                        ? AppColors.redColor
                                                        : AppColors
                                                            .borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: submitPressed &&
                                                            customerCallController
                                                                .phoneController
                                                                .value
                                                                .isEmpty
                                                        ? AppColors.redColor
                                                        : AppColors
                                                            .borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: submitPressed &&
                                                            customerCallController
                                                                .phoneController
                                                                .value
                                                                .isEmpty
                                                        ? AppColors.redColor
                                                        : AppColors
                                                            .borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: submitPressed &&
                                                            customerCallController
                                                                .phoneController
                                                                .value
                                                                .isEmpty
                                                        ? AppColors.redColor
                                                        : AppColors
                                                            .borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        if (submitPressed && customerCallController.phoneController.value.isEmpty)
                                          const Text(
                                            "    Please Enter Phone Number",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          ),
                                      ],
                                    );
                            }),

                            const SizedBox(height: 20),
                            const Text("Business Email"),
                            const SizedBox(height: 10),

                            CommonTextField(
                              needValidation: true,
                              controller:
                                  customerCallController.emailController,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              validator: validateEmail,
                              textInputType: TextInputType.emailAddress,
                              boxShadow: false,
                              hintText: "Business Email",
                            ),
                            const SizedBox(height: 20),
                            const Text("Company Name"),
                            const SizedBox(height: 10),
                            CommonTextField(
                              needValidation: true,
                              controller:
                                  customerCallController.companyNameController,
                              textInputType: TextInputType.text,
                              validator: validateCompanyName,
                              boxShadow: false,
                              hintText: "Company Name",
                            ),
                            const SizedBox(height: 20),
                            const Text("Company Size"),
                            const SizedBox(height: 10),
                            Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      fillColor: AppColors.whiteColor,
                                      isDense: true,
                                      filled: true,
                                      counterText: "",
                                      hintText: "Phone Number",
                                      hintStyle: AppTextStyle.regular400
                                          .copyWith(
                                              color: AppColors.borderColor,
                                              fontSize: 13),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: submitPressed &&
                                                      customerCallController
                                                              .selectedOption
                                                              .value ==
                                                          'Select company size'
                                                  ? AppColors.redColor
                                                  : AppColors.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: submitPressed &&
                                                      customerCallController
                                                              .selectedOption
                                                              .value ==
                                                          'Select company size'
                                                  ? AppColors.redColor
                                                  : AppColors.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: submitPressed &&
                                                      customerCallController
                                                              .selectedOption
                                                              .value ==
                                                          'Select company size'
                                                  ? AppColors.redColor
                                                  : AppColors.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: submitPressed &&
                                                      customerCallController
                                                              .selectedOption
                                                              .value ==
                                                          'Select company size'
                                                  ? AppColors.redColor
                                                  : AppColors.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    isExpanded: true,
                                    value: customerCallController
                                        .selectedOption.value,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    onChanged: (String? newValue) {
                                      customerCallController
                                          .selectedOption.value = newValue!;
                                    },
                                    items: customerCallController
                                        .dropdownOptions
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 5),
                                  if (submitPressed && customerCallController.selectedOption.value == 'Select company size')
                                    const Text(
                                      '  Please select a company size.',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                ],
                              );
                            }),
                            const SizedBox(height: 20),
                            const Text("Job Role"),
                            const SizedBox(height: 10),
                            CommonTextField(
                              needValidation: true,
                              validator: validateJobRole,
                              textInputType: TextInputType.text,
                              controller:
                                  customerCallController.jobRollController,
                              boxShadow: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]*$')),
                              ],
                              hintText: "Job Role",
                            ),
                            const SizedBox(height: 25),
                            commonButton(
                                // onTap: () {
                                //   print(
                                //       "_formKey.currentState!.validate()   ${_formKey.currentState!.validate()}");
                                //   if (customerCallController.nameController.text
                                //       .removeAllWhitespace.isEmpty) {
                                //     showSnackbar(
                                //       message: "Enter name");
                                //   } else if (customerCallController
                                //           .countryCodeController.text.isEmpty ||
                                //       customerCallController.phoneController
                                //           .text.removeAllWhitespace.isEmpty) {
                                //     showSnackbar(
                                //         message: "Check Phone number");
                                //   } else if (customerCallController
                                //       .emailController
                                //       .text
                                //       .removeAllWhitespace
                                //       .isEmpty) {
                                //     showSnackbar(
                                //      message: "Enter Email");
                                //   } else if (customerCallController
                                //           .emailController.text
                                //           .contains("@") ==
                                //       false) {
                                //     showSnackbar(
                                //         message: "Enter Valid Email");
                                //   } else if (customerCallController
                                //       .jobRollController
                                //       .text
                                //       .removeAllWhitespace
                                //       .isEmpty) {
                                //     showSnackbar(
                                //      message: "Enter Job Role");
                                //   } else if (customerCallController
                                //           .selectedOption.value
                                //           .toString() ==
                                //       "Select company size") {
                                //     showSnackbar(
                                //         message: "Select company size");
                                //   } else if (customerCallController
                                //       .companyNameController
                                //       .text
                                //       .removeAllWhitespace
                                //       .isEmpty) {
                                //     showSnackbar(
                                //         message: "Enter Company name");
                                //   } else {
                                //     log("selectedOption${customerCallController.selectedOption.value}");
                                //     customerCallController
                                //         .submitDetails(
                                //       email: customerCallController
                                //           .emailController.text,
                                //       name: customerCallController
                                //           .nameController.text,
                                //       companyName: customerCallController
                                //           .companyNameController.text,
                                //       companySize: customerCallController
                                //           .selectedOption.value,
                                //       jobRoll: customerCallController
                                //           .jobRollController.text,
                                //       phoneCode: customerCallController
                                //           .countryCodeController.text,
                                //       phoneNumber: customerCallController
                                //           .phoneController.text,
                                //     )
                                //         .whenComplete(() {
                                //       Get.back();
                                //       customerCallController.clearFields();
                                //     });
                                //   }
                                // },
                                onTap: () {
                                  setState(() {
                                    submitPressed = true;
                                  });
                                  if (formKey.currentState!.validate() &&
                                      customerCallController
                                              .selectedOption.value !=
                                          "Select company size" &&
                                      customerCallController
                                          .countryCodeController
                                          .value
                                          .isNotEmpty &&
                                      customerCallController
                                          .phoneController.value.isNotEmpty) {
                                    log("phone number  :: ${customerCallController.countryCodeController.value}${customerCallController.phoneController.value}");
                                    log("selectedOption :: ${customerCallController.selectedOption.value}");
                                    customerCallController
                                        .submitDetails(
                                      email: customerCallController
                                          .emailController.text,
                                      name: customerCallController
                                          .nameController.text,
                                      companyName: customerCallController
                                          .companyNameController.text,
                                      companySize: customerCallController
                                          .selectedOption.value,
                                      jobRoll: customerCallController
                                          .jobRollController.text,
                                      phoneCode: customerCallController
                                          .countryCodeController.value,
                                      phoneNumber: customerCallController
                                          .phoneController.value,
                                    )
                                        .whenComplete(() {
                                      Get.back();
                                      customerCallController.clearFields();
                                    });
                                  }
                                },
                                title: "Request a call back",
                                fontSize: 20,
                                width: Get.width,
                                height: 40,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Get.width > 501
                ? const Expanded(child: SizedBox())
                : const SizedBox(),
          ],
        ),
      );
    });
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }
    if (!value.contains('@')) {
      return 'Invalid email format.';
    }
    return null;
  }

  String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your company name.';
    }
    return null;
  }

  String? validateJobRole(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your job role.';
    }
    return null;
  }
}
