import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs/add_edit_faq_tye.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs/add_edit_faqs.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs/faq_controller.dart';

class EditDetailFaqs extends StatefulWidget {
  const EditDetailFaqs({super.key});

  @override
  State<EditDetailFaqs> createState() => _EditDetailFaqsState();
}

class _EditDetailFaqsState extends State<EditDetailFaqs> {
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
        faqController
            .getFaqType()
            .whenComplete(() => print("data loaded getFaqType  "));
      },
    );
    Future.delayed(
      const Duration(microseconds: 50),
      () {
        faqController
            .getFaq()
            .whenComplete(() => print("data loaded  getFaq "));
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
            title: Text("Edit Frequently Asked Questions",
                style: AppTextStyle.regular600
                    .copyWith(color: AppColors.blackColor, fontSize: 16)),
            leading: const BackButton(
              color: AppColors.blackColor,
            ),
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
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const FaqTypeScreen())!
                                    .whenComplete(() {
                                  // faqController.getFaqType();
                                  getData();
                                });
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.greyColor.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add),
                                      SizedBox(width: 3),
                                      Text("FAQ Type")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            GestureDetector(
                              onTap: () {
                                Get.dialog(AddEditFaqs(
                                  isEdit: false,
                                )).whenComplete(() {
                                  getData();
                                });
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.greyColor.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add),
                                      SizedBox(width: 3),
                                      Text("FAQs")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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

                                  bool isExpanded =
                                      faqController.faqTypeShowHide[index] ??
                                          false;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${data["title"]}",
                                            style: AppTextStyle.regular700
                                                .copyWith(fontSize: 18),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                faqController.faqTypeShowHide[
                                                        index] =
                                                    !faqController
                                                        .faqTypeShowHide[index];
                                                setState(() {});

                                                Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () => print(
                                                        "-0-0--0-0-0-0   ${faqController.faqTypeShowHide[index]}"));
                                              },
                                              icon: Icon(isExpanded
                                                  ? Icons.arrow_drop_up_sharp
                                                  : Icons
                                                      .arrow_drop_down_sharp))
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      if (isExpanded)
                                        Obx(() {
                                          return faqController.faqs.isEmpty
                                              ? const SizedBox()
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      faqController.faqs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var v = faqController
                                                        .faqs[index];
                                                    return v["faq_type_id"]
                                                                .toString() !=
                                                            data["_id"]
                                                                .toString()
                                                        ? const SizedBox()
                                                        : Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .whiteColor
                                                                    .withOpacity(
                                                                        0.2)),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${v["title"]}",
                                                                  style: AppTextStyle
                                                                      .regular700
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  "${v["description"]}",
                                                                  style: AppTextStyle
                                                                      .regular300
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                                AddEditFaqs(
                                                                                  isEdit: true,
                                                                                  faqTypeId: data["_id"],
                                                                                  title: v["title"],
                                                                                  description: v["description"],
                                                                                  faqId: v["_id"],
                                                                                  selectedValue: data,
                                                                                ))!
                                                                            .whenComplete(() {
                                                                          // faqController.getFaqType();
                                                                          getData();
                                                                        });
                                                                      },
                                                                      child:
                                                                          FittedBox(
                                                                        fit: BoxFit
                                                                            .scaleDown,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          decoration: BoxDecoration(
                                                                              color: AppColors.greyColor.withOpacity(0.5),
                                                                              borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                                          child:
                                                                              const Center(child: Icon(Icons.edit)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        faqController
                                                                            .deleteFaq(faqId: v["_id"])
                                                                            .whenComplete(() {
                                                                          getData();
                                                                        });
                                                                      },
                                                                      child:
                                                                          FittedBox(
                                                                        fit: BoxFit
                                                                            .scaleDown,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          decoration: BoxDecoration(
                                                                              color: AppColors.greyColor.withOpacity(0.5),
                                                                              borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                                          child:
                                                                              const Center(child: Icon(Icons.delete)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const SizedBox(
                                                                  width: 250,
                                                                  child:
                                                                      Divider(
                                                                    color: AppColors
                                                                        .greyColor,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                              ],
                                                            ),
                                                          );
                                                  },
                                                );
                                        }),
                                      const SizedBox(height: 20),
                                      const Divider(
                                        color: AppColors.blackColor,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  );
                                },
                              );
                      })
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
}
//AddEditFaqs
