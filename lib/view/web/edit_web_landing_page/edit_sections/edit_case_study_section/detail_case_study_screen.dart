import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';

class DetailCaseStudyScreen extends StatefulWidget {
  var shortDescription;
  DetailCaseStudyScreen({Key? key,this.shortDescription}) : super(key: key);

  @override
  State<DetailCaseStudyScreen> createState() => _DetailCaseStudyScreenState();
}

class _DetailCaseStudyScreenState extends State<DetailCaseStudyScreen> {

  final detailCaseStudyController = Get.find<DetailCaseStudyController>();

  @override
  void initState() {
    super.initState();
    detailCaseStudyController.getCaseStudyData(caseStudyAutoId: widget.shortDescription["case_study_auto_id"]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Row(
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Get.width > 1200 ? 1100 : Get.width > 800 ? 700 : 400,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const SizedBox(height: 25),
                    InkWell(
                        onTap: () => Get.back(),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios_new,color: AppColors.blackColor,),
                            const SizedBox(width: 5),
                            Text("Go back",style: AppTextStyle.regularBold.copyWith(fontSize: 16,decoration:TextDecoration.underline,),),
                          ],
                        )),
                    Get.width>825 ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.shortDescription["case_study_title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 55,color: AppColors.blackColor)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.yellowColor.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Text("${widget.shortDescription["case_study_category"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                                // const SizedBox(width: 60),
                                // Container(
                                //     padding: const EdgeInsets.all(10),
                                //     decoration: BoxDecoration(
                                //         color: AppColors.yellowColor.withOpacity(0.2),
                                //         borderRadius: const BorderRadius.all(Radius.circular(15))
                                //     ),
                                //     child: Text("${widget.shortDescription["case_study_type"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text("${widget.shortDescription["case_study_short_desciption"]}",style: AppTextStyle.regular500.copyWith(fontSize: 22,color: AppColors.blackColor)),
                          ],
                        ),
                        const SizedBox(width: 30),
                        CachedNetworkImage(
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          imageUrl: APIString.bannerMediaUrl +
                              widget.shortDescription["case_study_image"].toString(),
                          placeholder: (context, url) =>
                              Container(
                                height: 200,
                                width: 200,
                                decoration: const BoxDecoration(
                                  color: AppColors.greyColor,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ],
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.shortDescription["case_study_title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 55,color: AppColors.blackColor)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.yellowColor.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Text("${widget.shortDescription["case_study_category"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                                // const SizedBox(width: 60),
                                // Container(
                                //     padding: const EdgeInsets.all(10),
                                //     decoration: BoxDecoration(
                                //         color: AppColors.yellowColor.withOpacity(0.2),
                                //         borderRadius: const BorderRadius.all(Radius.circular(15))
                                //     ),
                                //     child: Text("${widget.shortDescription["case_study_type"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: Get.width,
                              child: CachedNetworkImage(
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                                imageUrl: APIString.bannerMediaUrl +
                                    widget.shortDescription["case_study_image"].toString(),
                                placeholder: (context, url) =>
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: const BoxDecoration(
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text("${widget.shortDescription["case_study_short_desciption"]}",style: AppTextStyle.regular500.copyWith(fontSize: 22,color: AppColors.blackColor)),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: Obx(() {
                        return detailCaseStudyController.caseStudyDetailsList.isEmpty
                            ? const Center(child: Text("No Data"))
                            : /*Get.width > 800 ?
                        GridView.builder(
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: detailCaseStudyController.caseStudyDetailsList.length,
                          itemBuilder: (context, index) {
                            var data = detailCaseStudyController.caseStudyDetailsList[index];
                            return Container(
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 10,right: 30,left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          showPopup(isEdit: true,
                                            caseStudyAutoId: data["case_study_auto_id"],
                                            caseStudyDetailsAutoId: data["_id"],
                                            title: data["title"],
                                            description: data["description"],
                                          );
                                        },
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: AppColors.whiteColor.withOpacity(0.5),
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5))),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit),
                                                SizedBox(width: 3),
                                                Text("Edit")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          detailCaseStudyController.deleteCaseStudyData(
                                            caseStudyAutoId: data["case_study_auto_id"],
                                            caseStudyDetailsAutoId: data["_id"],
                                          );
                                        },
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: AppColors.whiteColor.withOpacity(0.5),
                                                borderRadius: const BorderRadius.all(Radius.circular(5))),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.delete),
                                                SizedBox(width: 3),
                                                Text("Delete")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      Text("${data["title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 25,color: AppColors.blackColor),),
                                      const SizedBox(height: 15),
                                      Text("${data["description"]}",style: AppTextStyle.regular300.copyWith(fontSize: 20,color: AppColors.blackColor),),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        :*/
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: detailCaseStudyController.caseStudyDetailsList.length,
                          itemBuilder: (context, index) {
                            var data = detailCaseStudyController.caseStudyDetailsList[index];
                            return Container(
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      Text("${data["title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 24,color: AppColors.blackColor),),
                                      const SizedBox(height: 15),
                                      Text("${data["description"]}",style: AppTextStyle.regular300.copyWith(fontSize: 20,color: AppColors.blackColor,height: 1.2),),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),

                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },

    );
  }
}
