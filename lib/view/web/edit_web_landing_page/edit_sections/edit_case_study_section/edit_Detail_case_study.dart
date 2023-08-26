// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/widget/common_textfield.dart';

class EditDetailCaseStudyPage extends StatefulWidget {
  var shortDescription;
  EditDetailCaseStudyPage({Key? key,this.shortDescription}) : super(key: key);

  @override
  State<EditDetailCaseStudyPage> createState() => _EditDetailCaseStudyPageState();
}

class _EditDetailCaseStudyPageState extends State<EditDetailCaseStudyPage> {
  final editPartnerController = Get.find<EditCaseStudyController>();

  final detailCaseStudyController = Get.find<DetailCaseStudyController>();

  @override
  void initState() {
    // TODO: implement initState
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            showPopup(isEdit: false,
                              caseStudyAutoId: widget.shortDescription["case_study_auto_id"],
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.withOpacity(0.5),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.add),
                                  SizedBox(width: 3),
                                  Text("Add New Data")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.shortDescription["case_study_title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 40,color: AppColors.blackColor)),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: AppColors.yellowColor.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: Text("${widget.shortDescription["case_study_category"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                                  const SizedBox(width: 20),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: AppColors.yellowColor.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: Text("${widget.shortDescription["case_study_type"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 15,color: AppColors.blackColor))),
                                ],
                              ),

                              const SizedBox(height: 20),
                              Text("${widget.shortDescription["case_study_short_desciption"]}",style: AppTextStyle.regular500.copyWith(fontSize: 30,color: AppColors.blackColor)),
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
                      ),

                      const SizedBox(height: 25),
                      // DSFGDSFGSDFGDSFGFDSG
                      Obx(() {
                          return detailCaseStudyController.caseStudyDetailsList.isEmpty
                              ? const Center(child: Text("No Data"))
                              : /*Get.width > 800 ?
                          GridView.builder(
                            shrinkWrap:false,

                            physics: const AlwaysScrollableScrollPhysics(),
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
                                 physics: NeverScrollableScrollPhysics(),
                                 itemCount: detailCaseStudyController.caseStudyDetailsList.length,
                                 itemBuilder: (context, index) {
                                var data = detailCaseStudyController.caseStudyDetailsList[index];
                                return Container(
                                  width: Get.width,
                                  margin: const EdgeInsets.only(bottom: 10),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 15),
                                        Text("${data["title"]}",style: AppTextStyle.regularBold.copyWith(fontSize: 16,color: AppColors.blackColor),),
                                        const SizedBox(height: 15),
                                        Text("${data["description"]}",style: AppTextStyle.regular300.copyWith(fontSize: 14,color: AppColors.blackColor),),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),


                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },

    );
  }


  void showPopup({bool? isEdit = true,String? title,String? description,String? caseStudyAutoId,String? caseStudyDetailsAutoId,}) {
    if(isEdit == true){
      detailCaseStudyController.titleController.text = title!;
      detailCaseStudyController.descController.text =description!;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (p0, p1) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Center(child: Text(isEdit == false ?"Add Data":"Edit Data")),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text("Title"),
                  Container(
                    width: Get.width/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0,0),
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.08),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: detailCaseStudyController.titleController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(10))),
                      textAlign: TextAlign.start,
                      style: AppTextStyle.regular500.copyWith(fontSize: 15),

                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text("Description"),
                  Container(
                    width: Get.width/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( 10),
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
                      controller: detailCaseStudyController.descController,
                      maxLines: 30,
                      decoration: InputDecoration(
                          hintText: "Description",
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(10))),
                      textAlign: TextAlign.start,
                      style: AppTextStyle.regular500.copyWith(fontSize: 15),

                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  editPartnerController.clearFields();
                },
                child: const Text("Close"),
              ),
              TextButton(
                  onPressed: () async {
                    isEdit == false
                        ? detailCaseStudyController.addCaseStudyData(
                        caseStudyAutoId: caseStudyAutoId,
                        title: detailCaseStudyController.titleController.text,
                        description: detailCaseStudyController.descController.text)
                        : detailCaseStudyController.editCaseStudyData(
                        title: detailCaseStudyController.titleController.text,
                        description: detailCaseStudyController.descController.text,
                        caseStudyAutoId: caseStudyAutoId,
                        caseStudyDetailsAutoId: caseStudyDetailsAutoId);
                    Navigator.pop(context);
                  },
                  child: Text(isEdit == false ?"Save":"Update"))
            ],
          );
          },
        );
      },
    );
  }

}
