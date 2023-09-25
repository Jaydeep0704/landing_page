// ignore_for_file: prefer_typing_uninitialized_variables, implementation_imports, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs_section/faq_controller.dart';

class AddEditFaqs extends StatefulWidget {
  bool? isEdit = true;
  String? title;
  String? description;
  String? faqId;
  String? faqTypeId;
  Map<String, String>? selectedValue;

  AddEditFaqs({
    super.key,
    this.title,
    this.isEdit,
    this.description,
    this.faqId,
    this.faqTypeId,
    this.selectedValue,
  });

  @override
  State<AddEditFaqs> createState() => _AddEditFaqsState();
}

class _AddEditFaqsState extends State<AddEditFaqs> {
  final faqController = Get.find<FaqController>();
  Map<String, String>? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    if (widget.isEdit == true) {
      faqController.faqTitle.text = widget.title!;
      faqController.faqDesc.text = widget.description!;
      selectedValue = widget.selectedValue!;
    }
  }

  getData() {
    Future.delayed(
      const Duration(microseconds: 50),
      () {
        faqController.getFaq().whenComplete(() {
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            leading: const BackButton(
              color: AppColors.blackColor,
            ),
            title: Text(
                widget.isEdit == false ? "Add Case Study" : "Edit Case Study",
                style: AppTextStyle.regularBold
                    .copyWith(color: AppColors.blackColor, fontSize: 18)),
            // backgroundColor: AppColors.whiteColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                Container(
                  decoration:
                      BoxDecoration(color: AppColors.whiteColor, boxShadow: [
                    BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 3)
                  ]),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  width: Get.width > 800 ? 700 : Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Obx(() {
                        return faqController.faqType.isEmpty
                            ? const Text("Please Wait while Categories Load")
                            : DropdownButtonFormField<Map<String, String>>(
                                decoration: const InputDecoration(
                                  // labelText: 'Select an item',
                                  hintText: "Select an item",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ), // Use OutlineInputBorder for outlined border
                                ),
                                isExpanded: true,
                                value: selectedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedValue = newValue;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                items: faqController.faqType
                                    .map<DropdownMenuItem<Map<String, String>>>(
                                        (Map<String, String> item) {
                                  return DropdownMenuItem<Map<String, String>>(
                                    value: item,
                                    child: Text("${item['title']}"),
                                  );
                                }).toList(),
                              );
                      }),
                      const SizedBox(height: 15),
                      Text(
                        "Enter Question",
                        style: AppTextStyle.regular400.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.08),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: faqController.faqTitle,
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintText: "Enter Question",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor),
                                  borderRadius: BorderRadius.circular(10))),
                          textAlign: TextAlign.start,
                          style: AppTextStyle.regular500.copyWith(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Enter Answer",
                        style: AppTextStyle.regular400.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.08),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: faqController.faqDesc,
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: "Enter Answer",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor),
                                  borderRadius: BorderRadius.circular(10))),
                          textAlign: TextAlign.start,
                          style: AppTextStyle.regular500.copyWith(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                              onTap: () async {
                                if (validation() == true) {
                                  widget.isEdit == false
                                      ? faqController
                                          .addFaq(
                                              title:
                                                  faqController.faqTitle.text,
                                              // faqTypeId: widget.faqTypeId,
                                              faqTypeId: selectedValue!["_id"],
                                              description:
                                                  faqController.faqDesc.text)
                                          .whenComplete(() => {
                                                faqController.faqTitle.clear(),
                                                faqController.faqDesc.clear(),
                                                Get.back()
                                              })
                                      : faqController
                                          .updateFaq(
                                            title: faqController.faqTitle.text,
                                            description:
                                                faqController.faqDesc.text,
                                            faqId: widget.faqId,
                                            // faqTypeId: widget.faqTypeId
                                            faqTypeId: selectedValue!["_id"],
                                          )
                                          .whenComplete(() => {
                                                faqController.faqTitle.clear(),
                                                faqController.faqDesc.clear(),
                                                Get.back()
                                              });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Text(
                                    widget.isEdit == false ? "Add" : "Update"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        );
      },
    );
  }

  bool validation() {
    if (faqController.faqTitle.text.isEmpty ||
        faqController.faqTitle.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Question',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (faqController.faqDesc.text.isEmpty ||
        faqController.faqDesc.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Short Answer',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
  }
}
