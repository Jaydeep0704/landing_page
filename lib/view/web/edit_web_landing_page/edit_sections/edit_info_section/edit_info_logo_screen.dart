// ignore_for_file: implementation_imports, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:http_parser/src/media_type.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';

class EditInfoLogoScreen extends StatefulWidget {
  const EditInfoLogoScreen({Key? key}) : super(key: key);

  @override
  State<EditInfoLogoScreen> createState() => _EditInfoLogoScreenState();
}

class _EditInfoLogoScreenState extends State<EditInfoLogoScreen> {
  // final numberBannerController = Get.find<NumberBannerController>();
  final editInfoController = Get.find<EditInfoController>();

  List<PlatformFile>? _paths;
  var pathsFile;
  var pathsFileName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      editInfoController.getImages();
    });

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: const BackButton(color: AppColors.blackColor,),
          title: Text("Edit Partner Logo",style: AppTextStyle.regularBold.copyWith(color: AppColors.blackColor,fontSize: 18)),
          centerTitle: true,
        ),
        body: Row(
          children: [
            const Expanded(child: SizedBox()),

            Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [BoxShadow(color: AppColors.blackColor.withOpacity(0.3),blurRadius: 4,spreadRadius: 3)]
              ),
              width: Get.width > 800 ? 700 : 400,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        pickFiles(addImage: true);
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
                              Text("Add New Image")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Obx(() {
                      return editInfoController.imagesList.isEmpty
                          ? const Center(child: Text("No Data"))
                          : GridView.builder(
                        padding: const EdgeInsets.all(25),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        shrinkWrap: true,
                        itemCount: editInfoController.imagesList.length,
                        itemBuilder: (context, index) {
                          var data = editInfoController.imagesList[index];
                          return Container(
                            height: 250,
                            width: 250,
                            // padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: AppColors.greyColor.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                  imageUrl: APIString.bannerMediaUrl + data["images"].toString(),
                                  placeholder: (context, url) =>
                                      Container(
                                          height: 150,
                                          width: 150,
                                          decoration: const BoxDecoration(
                                            color: AppColors.greyColor,
                                          )),
                                  // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(onPressed: () {
                                      // pickFiles(addImage: false, numberBannerAutoId: "");
                                      pickFiles(
                                          addImage: false,
                                          imageAutoId:
                                          data["_id"]);
                                    }, icon: const Icon(Icons.edit)),
                                    IconButton(onPressed: () {
                                      // deletePartnerLogo(numberBannerAutoId: "");
                                      deletePartnerLogo(
                                          imageAutoId:
                                          data["_id"]);
                                    }, icon: const Icon(Icons.delete_forever)),
                                  ],
                                )
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
    });
  }

  void pickFiles({bool addImage = false, String? imageAutoId}) async {
    // Navigator.of(context).pop(false);
    showLoadingDialog(loader: false,loadingText: true,delay: true);

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            log("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
      // setState(() {
      hideLoadingDialog();
      pathsFile = _paths!.first.bytes!;
      pathsFileName = _paths!.first.name.removeAllWhitespace;
      // });
      log("_paths!.first.bytes  $pathsFile --  ${_paths!.first.bytes!}");
      log("_paths!.first.name  $pathsFileName --  ${_paths!.first.name}");
      log("selected image is ----------> $_paths");

      addImage == true
          ? addPartnerLogo()
          : editPartnerLogo(imageAutoId: imageAutoId);
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

  Future addPartnerLogo() async {
    showLoadingDialog();
    log("step --------  1");

    var url = APIString.grobizBaseUrl + APIString.add_footer_banner;
    log("step --------  2");

    Uri uri = Uri.parse(url);
    log("step --------  3");

    var request = http.MultipartRequest("POST", uri);
    log("step --------  4");

    log("file1 ------> $pathsFile ${pathsFile.runtimeType} ");
    log("file2 ------> $pathsFileName ${pathsFileName.runtimeType} ");
    try {
      log("step --------  5");

      if (pathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              "images",
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
      log("step --------  6");
    }
    catch (exception) {
      log("step --------  7");
      request.fields["images"] = '';
      log('pic not selected');
    }
    log("step --------  8");

    debugPrint(request.fields.toString());
    log("step --------  9");

    http.Response response = await http.Response.fromStream(await request.send());

    debugPrint("update response$response");
    hideLoadingDialog();
    log("step --------  10");

    if (response.statusCode == 200) {
      log("step -------- 11 ");
      // Navigator.pop(context);
      final resp = jsonDecode(response.body);
      log("step --------  12");

      debugPrint(resp.toString());

      int status = resp['status'];
      if (status == 1) {
        log("step --------  13");
        editInfoController.getImages();
        showSnackbar(title: "", message: "Added successfully");
        // Get.back();
      } else {
        log("step --------  14");
        // editInfoController.getPartnerLogo();
        String message = resp['msg'];
        log(message);
      }
      log("step --------  15");
    } else if (response.statusCode == 500) {
      hideLoadingDialog();
      // editInfoController.getPartnerLogo();
      showSnackbar(title: "", message: "Server Error");
      if (mounted) {
        setState(() {});
      }
    } else {
      // editInfoController.getPartnerLogo();
      hideLoadingDialog();
      showSnackbar(title: "", message: "Error");

      if (mounted) {
        setState(() {});
      }
    }

  }

  Future editPartnerLogo({String? imageAutoId}) async {
    showLoadingDialog();

    var url = APIString.grobizBaseUrl + APIString.edit_footer_banner;

    Uri uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);

    try {
      if (pathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              "images",
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
      request.fields["footer_banner_auto_id"] = imageAutoId.toString();
    } catch (exception) {
      request.fields["images"] = '';
      log('pic not selected');
    }

    debugPrint(request.fields.toString());

    http.Response response =
    await http.Response.fromStream(await request.send());

    debugPrint("update response$response");

    if (response.statusCode == 200) {
      hideLoadingDialog();
      final resp = jsonDecode(response.body);

      debugPrint(resp.toString());

      int status = resp['status'];
      if (status == 1) {
        showSnackbar(title: "", message: "Updated successfully");
        editInfoController.getImages();
      } else {
        // editInfoController.getPartnerLogo();
        String message = resp['msg'];
        log(message);
      }
    } else if (response.statusCode == 500) {
      // editInfoController.getPartnerLogo();
      hideLoadingDialog();
      showSnackbar(title: "", message: "Server Error");
      if (mounted) {
        setState(() {});
      }
    } else {
      // editInfoController.getPartnerLogo();
      hideLoadingDialog();
      showSnackbar(title: "", message: "Error");

      if (mounted) {
        setState(() {});
      }
    }
  }

  Future deletePartnerLogo({String? imageAutoId}) async {
    showLoadingDialog();
    final body = {
      "footer_banner_auto_id": imageAutoId.toString(),
    };

    log(body.toString());
    var url = APIString.grobizBaseUrl + APIString.delete_footer_banner;
    log(url);
    var uri = Uri.parse(url);
    final response = await http.post(uri, body: body);
    log(response.body.toString());
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      int status = resp['status'];
      log("Response status==>$status");
      hideLoadingDialog();
      if (status == 1) {
        log("if status success");
        showSnackbar(title: "", message: "Success");
        editInfoController.getImages();
      } else {
        // String msg = resp['msg'];
        // editInfoController.getPartnerLogo();
        showSnackbar(title: "", message: "Error");
        hideLoadingDialog();
      }
    } else if (response.statusCode == 500) {
      // editInfoController.getPartnerLogo();
      showSnackbar(title: "", message: "Server Error");
    }
  }


}
