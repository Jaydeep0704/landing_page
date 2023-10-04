import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/detail_case_study_screen.dart';
import 'package:grobiz_web_landing/widget/top_navbar.dart';

class CaseStudySection extends StatefulWidget {
  const CaseStudySection({Key? key}) : super(key: key);

  @override
  State<CaseStudySection> createState() => _CaseStudySectionState();
}

class _CaseStudySectionState extends State<CaseStudySection> {

  final editPartnerController = Get.find<EditCaseStudyController>();

  final detailCaseStudyController = Get.find<DetailCaseStudyController>();
  final editController = Get.find<EditController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCaseStudyData();
  }
  getCaseStudyData() {
    if(Get.width < 950){
      Future.delayed(const Duration(microseconds: 40), () {
        Get.find<EditCaseStudyController>().getCaseStudy();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      return  Get.width > 950
        ? caseStudySection()
        : Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            caseStudySection(),
          ],
        ),
      ),
    );

  }

  LayoutBuilder caseStudySection() {
    return LayoutBuilder(
    builder: (context, constraints) {
      return Obx(() {
        return editController.caseStudy.value == false ||  editController.allDataResponse.isEmpty
            ? const SizedBox()
            : SizedBox(
          height: Get.height>950 ?700:770,
          width: Get.width,
          child: Stack(
            children: [
              Container(
                height: 300,
                width: Get.width,
                decoration:
                const BoxDecoration(color: AppColors.bgBlue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Get.width > 950 ?const SizedBox(): TopNavBar(),
                    SizedBox(height: Get.width > 1500 ? Get.width * 0.02 : Get
                        .width > 1000 ? Get.width * 0.03 : Get.width * 0.04),

                    Text(
                      editController.allDataResponse[0]["case_study_details"][0]["case_study_title"]
                          .toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(editController.allDataResponse[0]["case_study_details"][0]["case_study_title_font"].toString()).copyWith(
                          fontSize: editController.allDataResponse[0]["case_study_details"][0]["case_study_title_size"].toString() !=""
                              ? double.parse(editController.allDataResponse[0]["case_study_details"][0]["case_study_title_size"].toString())
                              : 25,

                          fontWeight: FontWeight.bold,
                          color: editController.allDataResponse[0]["case_study_details"][0]["case_study_title_color"].toString().isEmpty
                              ?AppColors.blackColor
                              :Color(int.parse(editController.allDataResponse[0]["case_study_details"][0]["case_study_title_color"].toString()))),
                    ),
                    SizedBox(height: Get.width > 1500 ? Get.width * 0.02 : Get
                        .width > 1000 ? Get.width * 0.03 : Get.width * 0.04),
                    SizedBox(
                        width: Get.width > 1500
                            ? Get.width * 0.4
                            : Get.width > 1000
                            ? Get.width * 0.6
                            : Get.width * 0.8,
                        child:
                        Text(
                          editController.allDataResponse[0]["case_study_details"][0]["case_study_description"]
                              .toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(editController.allDataResponse[0]["case_study_details"][0]["case_study_description_font"].toString()).copyWith(
                              fontSize: editController.allDataResponse[0]["case_study_details"][0]["case_study_description_size"].toString() !=""
                                  ? double.parse(editController.allDataResponse[0]["case_study_details"][0]["case_study_description_size"].toString())
                                  : 25,
                              height: 1.2,
                              fontWeight: FontWeight.w400,
                              color: editController.allDataResponse[0]["case_study_details"][0]["case_study_description_color"].toString().isEmpty
                                  ?AppColors.blackColor
                                  :Color(int.parse(editController.allDataResponse[0]["case_study_details"][0]["case_study_description_color"].toString()))),
                        ),
                    ),
                    SizedBox(height: Get.width > 1500 ? Get.width * 0.02 : Get
                        .width > 1000 ? Get.width * 0.03 : Get.width * 0.04),

                  ],
                ),
              ),
              Positioned(
                left: 0, right: 0,
                top: 200,
                child: SizedBox(
                  width: Get.width * 0.85,
                  height: 400,
                  child: Obx(() {
                    return editPartnerController.caseStudyList.isEmpty
                        ? const Center(child: Text("Please wait while data is loading..."))
                        : ListView.builder(
                      itemCount: editPartnerController.caseStudyList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var data = editPartnerController.caseStudyList[index];

                        return Container(
                          width: Get.width > 375 ? 350 : Get.width * 0.85,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                            color: AppColors.whiteColor,),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: Get.width > 375 ? 350 : Get.width *
                                    0.85,
                                decoration: const BoxDecoration(
                                  border: Border(right: BorderSide(
                                      color: AppColors.blackColor,
                                      width: 1.5),
                                      left: BorderSide(
                                          color: AppColors.blackColor,
                                          width: 1.5),
                                      top: BorderSide(
                                          color: AppColors.blackColor,
                                          width: 1.5)),
                                ),
                                child: CachedNetworkImage(
                                  height: 200,
                                  width: 150,
                                  imageUrl: APIString.bannerMediaUrl +
                                      data["case_study_image"].toString(),
                                  placeholder: (context, url) =>
                                      Container(
                                        height: 100,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(border: Border.all(
                                      color: AppColors.blackColor, width: 1.5)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.lightBlueColor,
                                              border: Border.all(
                                                  color: AppColors.blueColor,
                                                  width: 0.8),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(20))
                                          ),
                                          child: Text(
                                            "${data["case_study_type"]}",
                                            style: AppTextStyle.regularBold
                                                .copyWith(fontSize: 12,
                                                color: AppColors.blueColor),)),
                                      const SizedBox(height: 10),
                                      Text("${data["case_study_title"]}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: AppTextStyle.regularBold
                                            .copyWith(
                                            fontSize: 16),),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${data["case_study_short_desciption"]}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 7,
                                        style: AppTextStyle.regular300.copyWith(
                                            fontSize: 14),),
                                      const SizedBox(height: 10),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() =>
                                                  DetailCaseStudyScreen(mainData: data,));
                                            },
                                            child: Container(
                                              width: 175,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: AppColors.greenColor
                                                      .withOpacity(0.5)),
                                              padding: const EdgeInsets
                                                  .symmetric(vertical: 10, horizontal: 20),
                                              child: Center(child: Text(
                                                "Read the case study",
                                                style: AppTextStyle.regular900,)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },);
                  }),
                ),
              ),
            ],
          ),
        );
      });
    },
  );
  }
}
