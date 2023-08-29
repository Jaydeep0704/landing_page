// ignore_for_file: implementation_imports

import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/career/careers_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/common_textfield.dart';
import 'package:http_parser/src/media_type.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class CareersScreen extends StatefulWidget {
  const CareersScreen({Key? key}) : super(key: key);

  @override
  State<CareersScreen> createState() => _CareersScreenState();
}

class _CareersScreenState extends State<CareersScreen> {

  final careersController = Get.find<CareersController>();


  List<PlatformFile>? _paths;
  var pathsFile;
  var pathsFileName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          leading: const BackButton(color: AppColors.blackColor,),
          title: Text("Careers", style: AppTextStyle.regularBold.copyWith(
              color: AppColors.blackColor, fontSize: 18)),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Get.width > 501 ?   const Expanded(child: SizedBox()) : const SizedBox(),
            Container(

              padding: const EdgeInsets.only(right: 25,left: 25,bottom: 25,top: 25),
              width: Get.width > 800 ? 700 : Get.width > 501 ? 400 : Get.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 25),
                          Text("Please submit below Details",
                              style: AppTextStyle.regularBold.copyWith(fontSize: 25)),
                          const SizedBox(height: 20),
                          const Text("Email"),
                          const SizedBox(height: 10,),
                          CommonTextField(controller: careersController.emailController,boxShadow: false,hintText: "Email",),
                          const SizedBox(height: 20),
                          const Text("Designation"),
                          const SizedBox(height: 10,),
                          Obx(() {
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:  AppColors.whiteColor,
                                hintStyle: AppTextStyle.regular400.copyWith(
                                    color:  AppColors.blackColor, fontSize: 15),
                                contentPadding: const EdgeInsets.only(
                                        top: 8, bottom: 16, right: 20, left: 20),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular( 10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular( 10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(10)),
                              ),

                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              isExpanded: true,
                              value: careersController.selectedOption.value,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.blue,
                              // ),
                              onChanged: (String? newValue) {
                                // setState(() {
                                  careersController.selectedOption.value = newValue!;
                                // });
                              },
                              items: careersController.dropdownOptions.map<DropdownMenuItem<String>>((
                                  String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          }),
                          const SizedBox(height: 20),
                          const Text("Description"),
                          const SizedBox(height: 10,),
                          CommonTextField(controller: careersController.descController,boxShadow: false,hintText: "Description",maxLine: 10,),
                          const SizedBox(height: 25,),
                          const Text("Upload Resume"),
                          const SizedBox(height: 10,),

                          DottedBorder(
                            color: AppColors.greyBorderColor,
                            strokeWidth: 1,
                            padding: const EdgeInsets.all(4),
                            dashPattern: const [6, 3, 0, 3],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(8),
                            // strokeCap: StrokeCap.butt,
                            // borderPadding:
                            //     EdgeInsets.only(top: 8),
                            child: _paths == null ? InkWell(
                              onTap: () {
                                pickFiles();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.file_upload_outlined),
                                    // const SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text("Upload Resume  ",style: AppTextStyle.regular800.copyWith(fontSize: 14),),
                                        Text("(pdf file only)",style: AppTextStyle.regular300,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                             : Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(10),

                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.picture_as_pdf),
                                  const SizedBox(width: 20,),
                                  Expanded(child: Text("${pathsFileName.toString()} ",style: AppTextStyle.regular800.copyWith(fontSize: 14),)),
                                  const SizedBox(width: 15,),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(onPressed: (){
                                      _paths = null;
                                      setState((){});
                                    }, icon: const Icon(Icons.close)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25,),
                          commonButton(
                            onTap: () {
                              if(careersController.emailController.text.isEmpty){showSnackbar(title: "", message: "Enter Email");}
                              else if(careersController.descController.text.isEmpty){showSnackbar(title: "", message: "Enter Description");}
                              else if(careersController.selectedOption.value.toString() == "Select Designations"){showSnackbar(title: "", message: "Select Designation");}
                              else if(_paths == null){showSnackbar(title: "", message: "Select Resume");}
                              else{
                                log("selectedOption${careersController.selectedOption.value}");
                                careersController.submitForm(pathsFile: pathsFile,pathsFileName: pathsFileName,
                                email: careersController.emailController.text,
                                description: careersController.selectedOption.value,
                                designation: careersController.descController.text).whenComplete(() {});
                              }
                            },
                          title: "Submit",fontSize: 20,
                          width: Get.width,
                              height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 0))


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Get.width > 501 ?   const Expanded(child: SizedBox()) : const SizedBox(),
          ],
        ),
      );
    });
  }


  void pickFiles({bool addImage = false, String? numberBannerAutoId}) async {
    // Navigator.of(context).pop(false);
    showLoadingDialog(loader: false,loadingText: true,delay: true);

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            log("status .... $status"),
        allowedExtensions: ['pdf'],
      ))
          ?.files;
      // setState(() {
      hideLoadingDialog();
      pathsFile = _paths!.first.bytes!;
      pathsFileName = _paths!.first.name.removeAllWhitespace;
      // });
      setState(() {

      });
      log("_paths!.first.bytes  $pathsFile --  ${_paths!.first.bytes!}");
      log("_paths!.first.name  $pathsFileName --  ${_paths!.first.name}");
      log("selected image is ----------> $_paths");
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



  // Future submitForm() async {
  //   showLoadingDialog();
  //   log("step --------  1");
  //
  //   var url = APIString.grobizBaseUrl + APIString.add_number_banner;
  //   log("step --------  2");
  //
  //   Uri uri = Uri.parse(url);
  //   log("step --------  3");
  //
  //   var request = http.MultipartRequest("POST", uri);
  //   log("step --------  4");
  //
  //   log("file1 ------> $pathsFile ${pathsFile.runtimeType} ");
  //   log("file2 ------> $pathsFileName ${pathsFileName.runtimeType} ");
  //   try {
  //     log("step --------  5");
  //
  //     if (pathsFile != null) {
  //       if (kIsWeb) {
  //         request.files.add(
  //           http.MultipartFile.fromBytes(
  //             "images",
  //             pathsFile,
  //             contentType: MediaType('application', 'x-tar'),
  //             filename: pathsFileName
  //                 .toString()
  //                 .removeAllWhitespace,
  //           ),
  //         );
  //       } else {
  //         // hideLoadingDialog();
  //         showSnackbar(title: "", message: "Not Allowed");
  //       }
  //     }
  //     log("step --------  6");
  //   }
  //   catch (exception) {
  //     log("step --------  7");
  //     request.fields["images"] = '';
  //     log('pic not selected');
  //   }
  //   log("step --------  8");
  //
  //   debugPrint(request.fields.toString());
  //   log("step --------  9");
  //
  //   http.Response response = await http.Response.fromStream(
  //       await request.send());
  //
  //   debugPrint("update response$response");
  //   hideLoadingDialog();
  //   log("step --------  10");
  //
  //   if (response.statusCode == 200) {
  //     log("step -------- 11 ");
  //     // Navigator.pop(context);
  //     final resp = jsonDecode(response.body);
  //     log("step --------  12");
  //
  //     debugPrint(resp.toString());
  //
  //     int status = resp['status'];
  //     if (status == 1) {
  //       log("step --------  13");
  //       showSnackbar(title: "", message: "Added successfully");
  //       // Get.back();
  //     } else {
  //       log("step --------  14");
  //       // numberBannerController.getPartnerLogo();
  //       String message = resp['msg'];
  //       log(message);
  //     }
  //     log("step --------  15");
  //   } else if (response.statusCode == 500) {
  //     hideLoadingDialog();
  //     // numberBannerController.getPartnerLogo();
  //     showSnackbar(title: "", message: "Server Error");
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   } else {
  //     // numberBannerController.getPartnerLogo();
  //     hideLoadingDialog();
  //     showSnackbar(title: "", message: "Error");
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   }
  // }


}
