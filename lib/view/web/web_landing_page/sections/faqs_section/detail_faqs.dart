import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs_section/faq_controller.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';

class DetailFAQs extends StatefulWidget {
  const DetailFAQs({super.key});

  @override
  State<DetailFAQs> createState() => _DetailFAQsState();
}

class _DetailFAQsState extends State<DetailFAQs> {
  final faqController = Get.find<FaqController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
    KeyboardScroll.addScrollListener(_scrollController);
  }

  @override
  void dispose() {
    KeyboardScroll.removeScrollListener();
    _scrollController.dispose();
    super.dispose();
  }

  getData() {
    Future.delayed(
      const Duration(microseconds: 50),
      () {
        faqController.getFaqType();
      },
    );
    Future.delayed(
      const Duration(microseconds: 50),
      () {
        faqController.getFaq();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SingleChildScrollView(
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width:
                      Get.width > 600 ? Get.width - Get.width * 0.2 : Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: Get.width < 600
                                ? const Icon(
                                    Icons.arrow_back_sharp,
                                    color: AppColors.blackColor,
                                  )
                                : Row(
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
                          ),
                          Text("Frequently Asked Questions",
                              style: AppTextStyle.regular600.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: Get.width > 600 ? 20 : 18)),
                          const SizedBox()
                        ],
                      ),
                      const SizedBox(height: 40),
                      Obx(() {
                        return faqController.faqType.isEmpty
                            ? const SizedBox()
                            : ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: faqController.faqType.length,
                                itemBuilder: (context, index) {
                                  var data = faqController.faqType[index];

                                  bool isExpanded = faqController.faqTypeShowHide[index] ?? false;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "✦  ${data["title"]}",
                                            style: AppTextStyle.regular700
                                                .copyWith(fontSize: 22),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                faqController.faqTypeShowHide[
                                                        index] =
                                                    !faqController
                                                        .faqTypeShowHide[index];
                                                setState(() {});
                                              },
                                              icon: Icon(isExpanded
                                                  ? Icons.arrow_drop_up_sharp
                                                  : Icons.arrow_drop_down_sharp))
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      if (isExpanded)
                                        Obx(() {
                                          return faqController.faqs.isEmpty
                                              ? const SizedBox()
                                              : ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      faqController.faqs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var v = faqController
                                                        .faqs[index];
                                                    bool isOpen = faqController
                                                        .faqShowHide[index];
                                                    return v["faq_type_id"]
                                                                .toString() !=
                                                            data["_id"]
                                                                .toString()
                                                        ? const SizedBox()
                                                        : Container(
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
                                                                              18),
                                                                ),
                                                                if (isOpen)
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                if (isOpen)
                                                                  Text(
                                                                    "${v["description"]}",
                                                                    style: AppTextStyle
                                                                        .regular300
                                                                        .copyWith(
                                                                            fontSize:
                                                                                15),
                                                                  ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                InkWell(
                                                                  onTap: () {
                                                                    faqController
                                                                            .faqShowHide[
                                                                        index] = !faqController
                                                                            .faqShowHide[
                                                                        index];
                                                                    setState(
                                                                        () {});
                                                                    // isOpen
                                                                  },
                                                                  child: Text(
                                                                    isOpen
                                                                        ? "Close"
                                                                        : "Read",
                                                                    style: AppTextStyle
                                                                        .regular300
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.greyColor,
                                                                            fontSize: 15),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                const Divider(),
                                                                const SizedBox(
                                                                    height: 5),
                                                              ],
                                                            ),
                                                          );
                                                  },
                                                );
                                        }),
                                      const SizedBox(height: 40),
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
