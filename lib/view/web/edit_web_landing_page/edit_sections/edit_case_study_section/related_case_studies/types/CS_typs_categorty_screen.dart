// ignore_for_file: must_be_immutable, avoid_print, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/related_case_studies/types/cs_category_controller.dart';

class CSTypeCategoryScreen extends StatefulWidget {
  const CSTypeCategoryScreen({super.key});

  @override
  State<CSTypeCategoryScreen> createState() => _CSTypeCategoryScreenState();
}

class _CSTypeCategoryScreenState extends State<CSTypeCategoryScreen> {
  final csCategoriesController = Get.find<CSCategoriesController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ghgfmjhiuyrtyghjfgrdhuytjhgjkj");
    getData();
    print("^^^^^^^^s");
  }

  getData() {
    Future.delayed(
      const Duration(microseconds: 50),
      () {
        csCategoriesController
            .geCSCategory()
            .whenComplete(() => print("data loaded   "));
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
            title: const Text("Case Study Categories",
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
                          Get.dialog(CSCategoryBox(
                            isEdit: false,
                          )).whenComplete(() {
                            csCategoriesController.geCSCategory();
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
                                Text("Add New Case Study Category")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Obx(() {
                      return csCategoriesController.caseStudyCategories.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: csCategoriesController
                                  .caseStudyCategories.length,
                              itemBuilder: (context, index) {
                                var data = csCategoriesController
                                    .caseStudyCategories[index];
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
                                        "Case Study Type :",
                                        style: AppTextStyle.regular600
                                            .copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                      Text("${data["case_study_type"]}",
                                          style: AppTextStyle.regular300
                                              .copyWith(fontSize: 15)),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Case Study Type Name :",
                                        style: AppTextStyle.regular600
                                            .copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                      Text("${data["value"]}",
                                          style: AppTextStyle.regular300
                                              .copyWith(fontSize: 15)),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              csCategoriesController
                                                      .csType.text =
                                                  data["case_study_type"]!;
                                              csCategoriesController
                                                  .valueController
                                                  .text = data["value"]!;
                                              Get.dialog(CSCategoryBox(
                                                      isEdit: true,
                                                      case_study_type_id:
                                                          data["id"]))
                                                  .whenComplete(() {
                                                csCategoriesController
                                                    .geCSCategory();
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
                                              csCategoriesController
                                                  .deleteCSCategory(
                                                      case_study_type_id:
                                                          data["id"])
                                                  .whenComplete(() {
                                                csCategoriesController
                                                    .geCSCategory();
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

class CSCategoryBox extends StatelessWidget {
  bool? isEdit;
  String? case_study_type_id;
  CSCategoryBox({super.key, this.isEdit = true, this.case_study_type_id});

  final csCategoriesController = Get.find<CSCategoriesController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit! ? "Edit Category" : "Add Category"),
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
              "Case Study Type :",
              style: AppTextStyle.regular600.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: csCategoriesController.csType,
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
            Text(
              "Case Study Type Name:",
              style: AppTextStyle.regular600.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: csCategoriesController.valueController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Enter Value",
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
                        ? csCategoriesController
                            .editCSCategory(
                            case_study_type_id: case_study_type_id,
                            value: csCategoriesController.valueController.text,
                            // value: csCategoriesController.csType.text,
                            case_study_type: csCategoriesController.csType.text,
                          )
                            .whenComplete(() {
                            Get.back();
                            csCategoriesController.csType.clear();
                            csCategoriesController.valueController.clear();
                          })
                        : csCategoriesController
                            .addCSCategory(
                            value: csCategoriesController.valueController.text,
                            // value: csCategoriesController.csType.text,
                            case_study_type: csCategoriesController.csType.text,
                          )
                            .whenComplete(() {
                            Get.back();
                            csCategoriesController.csType.clear();
                            csCategoriesController.valueController.clear();
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
                    csCategoriesController.csType.clear();
                    csCategoriesController.valueController.clear();
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
