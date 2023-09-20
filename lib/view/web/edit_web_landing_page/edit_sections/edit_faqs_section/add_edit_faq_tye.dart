// ignore_for_file: must_be_immutable, avoid_print, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs_section/faq_controller.dart';

class FaqTypeScreen extends StatefulWidget {
  const FaqTypeScreen({super.key});

  @override
  State<FaqTypeScreen> createState() => _FaqTypeScreenState();
}

class _FaqTypeScreenState extends State<FaqTypeScreen> {
  final faqController = Get.find<FaqController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
    print("^^^^^^^^s");
  }

  getData() {
    Future.delayed(
      const Duration(microseconds: 50),
      () {
        faqController.getFaqType().whenComplete(() => print("data loaded   "));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("FAQ Types",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Row(children: [
              const Expanded(child: SizedBox()),
              Container(
                decoration:
                    BoxDecoration(color: AppColors.whiteColor, boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.0),
                      blurRadius: 1,
                      spreadRadius: 2)
                ]),
                width: Get.width > 800 ? 500 : 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Get.dialog(FaqTypeBox(
                            isEdit: false,
                          )).whenComplete(() {
                            faqController.getFaqType();
                          });
                          // blogCategoriesController.addBlogCategory(value: "", case_study_type: "");
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: AppColors.greyColor.withOpacity(0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              children: const [
                                Icon(Icons.add),
                                SizedBox(width: 3),
                                Text("Add New FAQ Type")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Obx(() {
                      return faqController.faqType.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: faqController.faqType.length,
                              itemBuilder: (context, index) {
                                var data = faqController.faqType[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: const BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "FAQs Type :",
                                        style: AppTextStyle.regular600
                                            .copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                      Text("${data["title"]}",
                                          style: AppTextStyle.regular300
                                              .copyWith(fontSize: 15)),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              faqController.faqTypeController
                                                  .text = data["title"]!;

                                              Get.dialog(FaqTypeBox(
                                                      isEdit: true,
                                                      faq_type_id: data["_id"]))
                                                  .whenComplete(() {
                                                faqController.getFaqType();
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  color:
                                                      AppColors.greyBorderColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: const Icon(Icons.edit),
                                            ),
                                          ),
                                          const SizedBox(height: 25),
                                          GestureDetector(
                                            onTap: () {
                                              faqController
                                                  .deleteFaqType(
                                                      faqTypeId: data["_id"])
                                                  .whenComplete(() {
                                                faqController.getFaqType();
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  color:
                                                      AppColors.greyBorderColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: const Icon(Icons.delete),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(
                                          color: AppColors.greyBorderColor,
                                          thickness: 1.2),
                                    ],
                                  ),
                                );
                              },
                            );
                    })
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ]),
          ),
        );
      },
    );
  }
}

class FaqTypeBox extends StatelessWidget {
  bool? isEdit;
  String? faq_type_id;
  FaqTypeBox({super.key, this.isEdit = true, this.faq_type_id});

  final faqController = Get.find<FaqController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit! ? "Edit FAQ" : "Add FAQ"),
      content: SizedBox(
        width: Get.width > 800
            ? 700
            : Get.width > 500
                ? 450
                : 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              "FAQ Type :",
              style: AppTextStyle.regular600.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: faqController.faqTypeController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Enter Data",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    isEdit!
                        ? faqController
                            .updateFaqType(
                            title: faqController.faqTypeController.text,
                            faqTypeId: faq_type_id,
                          )
                            .whenComplete(() {
                            Get.back();
                            faqController.faqTypeController.clear();
                          })
                        : faqController
                            .addFaqType(
                                title: faqController.faqTypeController.text)
                            .whenComplete(() {
                            Get.back();
                            faqController.faqTypeController.clear();
                          });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent,
                    ),
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      isEdit! ? "Edit" : "Add",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    Get.back();
                    faqController.faqTypeController.clear();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.greyColor,
                    ),
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    alignment: Alignment.center,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
