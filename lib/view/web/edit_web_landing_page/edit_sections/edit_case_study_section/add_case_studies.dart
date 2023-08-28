// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/add_update_short_case_study.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/edit_Detail_case_study.dart';
import 'package:http_parser/src/media_type.dart';

import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:http/http.dart' as http;

class AllNewCaseStudies extends StatefulWidget {
  const AllNewCaseStudies({super.key});

  @override
  State<AllNewCaseStudies> createState() => _AllNewCaseStudiesState();
}

class _AllNewCaseStudiesState extends State<AllNewCaseStudies> {
  final editPartnerController = Get.find<EditCaseStudyController>();

  List<PlatformFile>? _paths;
  var pathsFile;
  var pathsFileName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editPartnerController.getCaseStudy();
    });
  }

  void showPopup({bool? isEdit = true,String? category,String? title,String? type,String? shortDescription,String? id}) {
    if(isEdit == true){
      editPartnerController.category.text = category!;
      editPartnerController.title.text =title! ;
      editPartnerController.type.text = type!;
      editPartnerController.shortDescription.text = shortDescription!;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(isEdit == false ?"Add Case Study":"Edit Case Study"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  pickFiles();
                },
                child: Container(
                  decoration: const BoxDecoration(color: AppColors.greyColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  height: 70,width: 150,
                  child: _paths != null ? ClipRRect(child: Image.memory(_paths!.first.bytes!,height: 60,width: 60,))
                  : const Center(
                    child: Icon(Icons.image),
                   ),
                ),
              ),
              const SizedBox(height: 15),
              const Text("Enter Case Study Type"),
              TextField(
                controller: editPartnerController.type,
                decoration: const InputDecoration(
                  hintText: "Enter the type",
                  // border: InputBorder.none
                ),
              ),
              const SizedBox(height: 15),
              const Text("Enter Case Study Category"),
              TextField(
                controller: editPartnerController.category,
                decoration: const InputDecoration(hintText: "Enter the category"),
              ),
              const SizedBox(height: 15),
              const Text("Enter Case Study Title"),
              TextField(
                controller: editPartnerController.title,
                decoration: const InputDecoration(hintText: "Enter the title"),
              ),
              const SizedBox(height: 15),
              const Text("Enter Case Study Description"),
              TextField(
                controller: editPartnerController.shortDescription,
                decoration: const InputDecoration(hintText: "Enter the description"),
              ),
            ],
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
                  isEdit == false ? addCaseStudy(
                      caseStudyCategory: editPartnerController.category.text,
                      caseStudyTitle: editPartnerController.title.text,
                      caseStudyType: editPartnerController.type.text,
                      detailDescription: "",
                      shortDescription: editPartnerController.shortDescription.text)
                  : editCaseStudy(
                      id: id,
                      caseStudyCategory: editPartnerController.category.text,
                      caseStudyTitle: editPartnerController.title.text,
                      caseStudyType: editPartnerController.type.text,
                      detailDescription: "",
                      shortDescription: editPartnerController.shortDescription.text);
                  // await myController.getPartnerLogo2();
                  Navigator.pop(context);
                  // log("-----------------------------------^^^^^^^^^^^^^^${editpartnercontroller.getCaseStudy()}");
                },
                child: Text(isEdit == false ?"Save":"Update"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            leading: const BackButton(
              color: AppColors.blackColor,
            ),
            title: Text("Edit Case Study",
                style: AppTextStyle.regularBold
                    .copyWith(color: AppColors.blackColor, fontSize: 18)),
            centerTitle: true,
          ),
          body: Row(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                decoration: BoxDecoration(
                        color: AppColors.whiteColor, boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 3)
                ]),
                width: Get.width > 800 ? 700 : Get.width,
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          // showPopup(isEdit: false);
                          Get.to(()=>AddUpdateShortCaseStudy(isEdit: false,))!.whenComplete(() => editPartnerController.getCaseStudy());
                          // pickFiles(addImage: true);
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
                                Text("Add New Case Study")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: Obx(() {
                        return editPartnerController.caseStudyList.isEmpty
                            ? const Center(child: Text("No Data"))
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                shrinkWrap: true,
                                itemCount: editPartnerController.caseStudyList.length,
                                itemBuilder: (context, index) {
                                  var data = editPartnerController.caseStudyList[index];
                                  return Container(
                                    // height: 250,
                                    width: Get.width,
                                    padding: const EdgeInsets.all(25),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.greyColor.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CachedNetworkImage(
                                              height: 200,
                                              width: 150,
                                              fit: BoxFit.cover,
                                              imageUrl: APIString.bannerMediaUrl +
                                                  data["case_study_image"].toString(),
                                              placeholder: (context, url) =>
                                                  Container(
                                                    height: 70,
                                                    width: 150,
                                                    decoration: const BoxDecoration(
                                                      color: AppColors.greyColor,
                                                    ),
                                                  ),
                                              errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Title",style: AppTextStyle.regularBold.copyWith(fontSize: 16,color: AppColors.blackColor),),
                                                  Text("${data["case_study_title"]}",style: AppTextStyle.regular300.copyWith(fontSize: 14,color: AppColors.blackColor),),
                                                  const SizedBox(height: 10),
                                                  Text("Case Study Type",style: AppTextStyle.regularBold.copyWith(fontSize: 16,color: AppColors.blackColor),),
                                                  Text("${data["case_study_type"]}",style: AppTextStyle.regular300.copyWith(fontSize: 14,color: AppColors.blackColor),),
                                                  const SizedBox(height: 10),
                                                  Text("Case Study Category",style: AppTextStyle.regularBold.copyWith(fontSize: 16,color: AppColors.blackColor),),
                                                  Text("${data["case_study_category"]}",style: AppTextStyle.regular300.copyWith(fontSize: 14,color: AppColors.blackColor),),
                                                  const SizedBox(height: 10),
                                                  Text("Case Study Short Desciption",style: AppTextStyle.regularBold.copyWith(fontSize: 16,color: AppColors.blackColor),),
                                                  Text("${data["case_study_short_desciption"]}",style: AppTextStyle.regular300.copyWith(fontSize: 14,color: AppColors.blackColor),),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                Get.to(()=>AddUpdateShortCaseStudy(
                                                  isEdit: true,
                                                media: data["media"],
                                                  shortDescription: data["case_study_short_desciption"],
                                                  detailDescription: data["case_study_detail_desciption"],
                                                  caseType: data["case_study_type"],
                                                  caseStudyImage: data["case_study_image"],
                                                  caseStudyAutoId: data["case_study_auto_id"],
                                                  caseCategory: data["case_study_category"],mediaTypeKey: data["mediaTypeKey"],
                                                  title: data["case_study_title"],
                                                
                                                ))!.whenComplete(() => editPartnerController.getCaseStudy());

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
                                                      Text("Edit Short Details")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(context: context, builder: (context) {
                                                  return AlertDialog(
                                                    content: SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(height: 20),
                                                          const Text("Are you sure you want to delete?"),
                                                          const SizedBox(height: 20),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [

                                                              ElevatedButton(onPressed: (){
                                                                Get.back();
                                                              },
                                                                  child: const Text("Cancel")),
                                                              ElevatedButton(onPressed: (){
                                                                deleteCaseStudy(caseStudyAutoId: data["case_study_auto_id"]).then((value) => Get.back());
                                                              },
                                                                  child: const Text("Delete")),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 20),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                  // deleteCaseStudy(caseStudyAutoId: data["case_study_auto_id"]);
                                                );},
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Container(
                                                  padding: const EdgeInsets.all(5),
                                                  margin: const EdgeInsets.only(right: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.whiteColor.withOpacity(0.5),
                                                      borderRadius:
                                                      const BorderRadius.all(Radius.circular(5))),
                                                  child:  Row(
                                                    children: const [
                                                      Icon(Icons.delete),
                                                      SizedBox(width: 3),
                                                      Text("Delete Case Study")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(()=> EditDetailCaseStudyPage(shortDescription: data,));
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
                                                      Text("Go to Detail Edit Page")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
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

  void pickFiles({bool addImage = false, String? numberBannerAutoId}) async {
    // Navigator.of(context).pop(false);
    showLoadingDialog(loader: false, loadingText: true, delay: true);

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => log("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
      // setState(() {
      hideLoadingDialog();
      pathsFile = _paths!.first.bytes!;
      pathsFileName = _paths!.first.name.removeAllWhitespace;
      setState(() {});
      // });
      log("_paths!.first.bytes  $pathsFile --  ${_paths!.first.bytes!}");
      log("_paths!.first.name  $pathsFileName --  ${_paths!.first.name}");
      log("selected image is ----------> $_paths");

      // addImage == true
      //     ? addCaseStudy()
      //     : editCaseStudy(numberBannerAutoId: numberBannerAutoId);
    } on PlatformException catch (e) {
      log('Unsupported operation   $e');
    } catch (e) {
      log(e.toString());
      setState(() {
        if (_paths != null) {
          if (_paths != null) {
            log("selected image path is -----------> $_paths");
          }
        }
      });
    }
  }

  Future addCaseStudy({String? caseStudyType, String? caseStudyCategory,String? caseStudyTitle,String? shortDescription,String? detailDescription}) async {
    showLoadingDialog();

    var url = APIString.grobizBaseUrl + APIString.addCaseStudy;
    Uri uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    log("file1 ------> $pathsFile ${pathsFile.runtimeType} ");
    log("file2 ------> $pathsFileName ${pathsFileName.runtimeType} ");
    try {
      if (pathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              "case_study_image",
              pathsFile,
              contentType: MediaType('application', 'x-tar'),
              filename: pathsFileName.toString().removeAllWhitespace,
            ),
          );
        } else {
          // hideLoadingDialog();
          showSnackbar(title: "", message: "Not Allowed");
        }
      }
    } catch (exception) {
      request.fields["case_study_image"] = '';
    }

    debugPrint(request.fields.toString());
    request.fields["case_study_type"] = caseStudyType.toString();
    request.fields["case_study_category"] =caseStudyCategory.toString();
    request.fields["case_study_title"] =caseStudyTitle.toString();
    request.fields["case_study_short_desciption"] =shortDescription.toString();
    request.fields["case_study_detail_desciption"] =detailDescription.toString();


    http.Response response = await http.Response.fromStream(await request.send());

    debugPrint("update response$response");
    hideLoadingDialog();
    log("step --------  10");
    editPartnerController.clearFields();
    _paths = null;
    pathsFile = null;
    pathsFileName = null;

    if (response.statusCode == 200) {
      log("step -------- 11");
      // Navigator.pop(context);
      editPartnerController.getCaseStudy();
      final resp = jsonDecode(response.body);
      log("step --------  12");

      debugPrint(resp.toString());

      int status = resp['status'];
      if (status == 1) {
        log("step --------  13");
        editPartnerController.getCaseStudy();
        showSnackbar(title: "", message: "Added successfully");
        // Get.back();
      } else {
        log("step --------  14");
        // numberBannerController.getPartnerLogo();
        String message = resp['msg'];
        log(message);
      }
      log("step --------  15");
    } else if (response.statusCode == 500) {
      hideLoadingDialog();
      // numberBannerController.getPartnerLogo();
      showSnackbar(title: "", message: "Server Error");
      if (mounted) {
        setState(() {});
      }
    } else {
      // numberBannerController.getPartnerLogo();
      hideLoadingDialog();
      showSnackbar(title: "", message: "Error");

      if (mounted) {
        setState(() {});
      }
    }
  }

  Future editCaseStudy({String? id,String? caseStudyType, String? caseStudyCategory,
    String? caseStudyTitle,String? shortDescription,String? detailDescription}) async {

    showLoadingDialog();

    var url = APIString.grobizBaseUrl + APIString.editCaseStudy;
    Uri uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    try {
      if (pathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              "case_study_image",
              pathsFile,
              contentType: MediaType('application', 'x-tar'),
              filename: pathsFileName.toString().removeAllWhitespace,
            ),
          );
        } else {
          // hideLoadingDialog();
          showSnackbar(title: "", message: "Not Allowed");
        }
      }
      request.fields["case_study_image"] = "";
    } catch (exception) {
      request.fields["case_study_image"] = '';
      log('pic not selected');
    }
    request.fields["case_study_auto_id"] = id.toString();
    request.fields["case_study_type"] = caseStudyType.toString();
    request.fields["case_study_category"] =caseStudyCategory.toString();
    request.fields["case_study_title"] =caseStudyTitle.toString();
    request.fields["case_study_short_desciption"] =shortDescription.toString();
    request.fields["case_study_detail_desciption"] =detailDescription.toString();

    debugPrint(request.fields.toString());

    http.Response response = await http.Response.fromStream(await request.send());

    debugPrint("update response$response");
    editPartnerController.clearFields();
    _paths = null;
    pathsFile = null;
    pathsFileName = null;
    if (response.statusCode == 200) {
      hideLoadingDialog();
      final resp = jsonDecode(response.body);

      debugPrint(resp.toString());

      int status = resp['status'];
      if (status == 1) {
        showSnackbar(title: "", message: "Updated successfully");
        editPartnerController.getCaseStudy();
      } else {
        // numberBannerController.getPartnerLogo();
        String message = resp['msg'];
        log(message);
      }
    } else if (response.statusCode == 500) {
      // numberBannerController.getPartnerLogo();
      hideLoadingDialog();
      showSnackbar(title: "", message: "Server Error");
      if (mounted) {
        setState(() {});
      }
    } else {
      // numberBannerController.getPartnerLogo();
      hideLoadingDialog();
      showSnackbar(title: "", message: "Error");

      if (mounted) {
        setState(() {});
      }
    }
  }

  Future deleteCaseStudy({String? caseStudyAutoId}) async {
    showLoadingDialog();
    final body = {
      "case_study_auto_id": caseStudyAutoId.toString(),
    };

    log(body.toString());
    var url = APIString.grobizBaseUrl + APIString.deleteCaseStudy;
    log(url);
    var uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    // log(response.body.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      hideLoadingDialog();
      if (status == 1) {
        showSnackbar(title: "", message: "Success");
        editPartnerController.getCaseStudy();
      } else {
        showSnackbar(title: "", message: "Error");
        // hideLoadingDialog();
      }
    } else if (response.statusCode == 500) {
      hideLoadingDialog();
      // numberBannerController.getPartnerLogo();
      showSnackbar(title: "", message: "Server Error");
    }
  }
}
