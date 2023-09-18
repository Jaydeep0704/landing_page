// ignore_for_file: prefer_typing_uninitialized_variables, implementation_imports, must_be_immutable

import 'dart:developer';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/related_case_studies/types/cs_category_controller.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http_parser/src/media_type.dart';
import 'package:http/http.dart' as http;

class AddUpdateShortCaseStudy extends StatefulWidget {
  bool? isEdit = true;
  String? caseType;
  String? caseCategory;
  String? caseStudyCatagoryId;
  String? title;
  String? shortDescription;
  String? detailDescription;
  String? caseStudyAutoId;
  String? caseStudyImage;
  String? media;
  String? mediaTypeKey;
  AddUpdateShortCaseStudy(
      {super.key,
      this.mediaTypeKey,
      this.caseStudyCatagoryId,
      this.media,
      this.title,
      this.isEdit,
      this.shortDescription,
      this.detailDescription,
      this.caseStudyAutoId,
      this.caseCategory,
      this.caseStudyImage,
      this.caseType});

  @override
  State<AddUpdateShortCaseStudy> createState() =>
      _AddUpdateShortCaseStudyState();
}

class _AddUpdateShortCaseStudyState extends State<AddUpdateShortCaseStudy> {
  final editCaseStudyController = Get.find<EditCaseStudyController>();
  final csCategoriesController = Get.find<CSCategoriesController>();

  String profile = "";
  String mediaTypeKey = "";

  String videoImg = "";
  bool isvideo = false;
  bool isImage = false;
  bool isGif = false;
  VideoPlayerController? _controller;

  ///for logo
  List<PlatformFile>? _pathsLogo;
  var pathsFileLogo;
  var pathsFileNameLogo;

  //  List<PlatformFile>? _pathsLogo;  _paths
//   var pathsFileLogo;  pathsFile
//   var pathsFileNameLogo;  pathsFile

  ///for gif file
  List<PlatformFile>? gifpaths;
  var gifpathsFile;
  var gifpathsFileName;
  Uint8List? gifData;

  ///for video file
  List<PlatformFile>? videopaths;
  var videopathsFile;
  var videopathsFileName;
  Uint8List? videoData;

  ///for banner image file
  List<PlatformFile>? paths;
  var pathsFile;
  var pathsFileName;
  Uint8List? imageData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    if (widget.isEdit == true) {
      profile = widget.caseStudyImage!;
      mediaTypeKey = widget.mediaTypeKey!;
      videoImg = widget.mediaTypeKey!;

      editCaseStudyController.category.text = widget.caseCategory!;
      editCaseStudyController.title.text = widget.title!;
      editCaseStudyController.type.text = widget.caseType!;
      editCaseStudyController.shortDescription.text = widget.shortDescription!;
      editCaseStudyController.detailDescription.text =
          widget.detailDescription!;

      // VideoImg = mediaTypeKey.toString();
      if (mediaTypeKey == "image") {
        isImage = true;
        isvideo = false;
        isGif = false;
      } else if (mediaTypeKey == "video") {
        isImage = false;
        isvideo = true;
        isGif = false;
        preVideo(link: widget.media!);
      } else if (mediaTypeKey == "gif") {
        isImage = false;
        isvideo = false;
        isGif = true;
      }
    } else {
      profile = "";
      mediaTypeKey = "";
      videoImg = "";

      editCaseStudyController.category.text = "";
      editCaseStudyController.title.text = "";
      editCaseStudyController.type.text = "";
      editCaseStudyController.shortDescription.text = "";
      editCaseStudyController.detailDescription.text = "";
    }
  }

  getData() {
    Future.delayed(
      const Duration(microseconds: 50),
      () {
        //csCategoriesController.caseStudyCategories

        csCategoriesController.geCSCategory().whenComplete(() {
          print("data loaded ");
          if (widget.isEdit == true) {
            List<Map<String, String>> data =
                csCategoriesController.caseStudyCategories
                    // .where((p0) => p0["id"] == widget.caseCategory)
                    .where((p0) => p0["id"] == widget.caseStudyCatagoryId)
                    .toList();
            selectedValue = data[0];
            print("selectedValue loaded   $selectedValue");
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            leading: const BackButton(
              color: AppColors.blackColor,
            ),
            title: Text(
                widget.isEdit == false ? "Add Case Study" : "Edit Case Study",
                style: AppTextStyle.regularBold
                    .copyWith(color: AppColors.blackColor, fontSize: 18)),
            // backgroundColor: AppColors.whiteColor,
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
                      const SizedBox(height: 15),
                      Text(
                        "Select Case Study Logo",
                        style: AppTextStyle.regular400.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          pickFilesLogo();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 150,
                          width: 150,
                          child: _pathsLogo != null
                              ? ClipRRect(
                                  child: Image.memory(
                                  _pathsLogo!.first.bytes!,
                                  height: 60,
                                  width: 60,
                                ))
                              : profile.toString().isNotEmpty
                                  ? CachedNetworkImage(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      imageUrl: APIString.latestmediaBaseUrl +
                                          profile,
                                      placeholder: (context, url) => Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.greyBorderColor,
                                        ),
                                      ),
                                      // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    )
                                  : const Center(
                                      child: Icon(Icons.image),
                                    ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Select Case Study Category",
                        style: AppTextStyle.regular400.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return csCategoriesController
                                .caseStudyCategories.isEmpty
                            ? Text("Please Wait while Categories Load")
                            : DropdownButtonFormField<Map<String, String>>(
                                decoration: const InputDecoration(
                                  // labelText: 'Select an item',
                                  hintText: "Select an item",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ), // Use OutlineInputBorder for outlined border
                                ),
                                isExpanded: true,
                                value: selectedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedValue = newValue;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                items: csCategoriesController
                                    .caseStudyCategories
                                    .map<DropdownMenuItem<Map<String, String>>>(
                                        (Map<String, String> item) {
                                  return DropdownMenuItem<Map<String, String>>(
                                    value: item,
                                    // child: Text("${item['case_study_type']} - ${item['value']}"),
                                    child: Text("${item['case_study_type']}"),
                                  );
                                }).toList(),
                              );
                      }),
                      const SizedBox(height: 15),
                      Text(
                        "Enter Username",
                        style: AppTextStyle.regular400.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
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
                          controller: editCaseStudyController.detailDescription,
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintText: "Enter Username",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor),
                                  borderRadius: BorderRadius.circular(10))),
                          textAlign: TextAlign.start,
                          style: AppTextStyle.regular500.copyWith(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Enter Case Study Title",
                        style: AppTextStyle.regular400.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
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
                          controller: editCaseStudyController.title,
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: "Enter Case Study Title",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor),
                                  borderRadius: BorderRadius.circular(10))),
                          textAlign: TextAlign.start,
                          style: AppTextStyle.regular500.copyWith(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Enter Case Study Short Description",
                        style: AppTextStyle.regular400.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
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
                          controller: editCaseStudyController.shortDescription,
                          maxLines: 10,
                          decoration: InputDecoration(
                              hintText: "Enter Case Study Short Description",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor),
                                  borderRadius: BorderRadius.circular(10))),
                          textAlign: TextAlign.start,
                          style: AppTextStyle.regular500.copyWith(fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                'Image',
                                style: TextStyle(fontSize: 16),
                              ),
                              leading: Radio(
                                activeColor: Colors.blue,
                                value: 'image',
                                groupValue: videoImg,
                                onChanged: (value) {
                                  setState(() {
                                    videoImg = value as String;
                                    print(value);
                                    print("VideoImg ---- $videoImg");
                                    if (videoImg == 'image') {
                                      isImage = true;
                                      isvideo = false;
                                      isGif = false;
                                      mediaTypeKey = "image";
                                      log("isImage ----- $isImage");
                                      log("isvideo ----- $isvideo");
                                      log("isGif ----- $isGif");
                                    } else {
                                      isImage = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                'Video',
                                style: TextStyle(fontSize: 16),
                              ),
                              leading: Radio(
                                activeColor: Colors.blue,
                                value: 'video',
                                groupValue: videoImg,
                                onChanged: (value) {
                                  setState(() {
                                    videoImg = value as String;
                                    print("Img_video==");
                                    print(value);
                                    print("VideoImg ---- $videoImg");
                                    if (videoImg == 'video') {
                                      isvideo = true;
                                      isImage = false;
                                      isGif = false;
                                      mediaTypeKey = "video";
                                      log("isImage ----- $isImage");
                                      log("isvideo ----- $isvideo");
                                      log("isGif ----- $isGif");
                                    } else {
                                      isvideo = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                'GIF',
                                style: TextStyle(fontSize: 16),
                              ),
                              leading: Radio(
                                activeColor: Colors.blue,
                                value: 'gif',
                                groupValue: videoImg,
                                onChanged: (value) {
                                  setState(() {
                                    videoImg = value as String;
                                    print("Img_gif==");
                                    print(value);
                                    print("VideoImg ---- $videoImg");
                                    if (videoImg == 'gif') {
                                      isGif = true;
                                      isImage = false;
                                      isvideo = false;
                                      mediaTypeKey = "gif";
                                      log("isImage ----- $isImage");
                                      log("isvideo ----- $isvideo");
                                      log("isGif ----- $isGif");
                                    } else {
                                      isGif = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                          visible: isImage == true ? true : false,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: imageData != null
                                    ? Image.memory(
                                        imageData!,
                                        fit: BoxFit.fill,
                                      )
                                    : widget.mediaTypeKey == "image"
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                APIString.latestmediaBaseUrl +
                                                    widget.media!)
                                        : const Center(
                                            child: Icon(
                                            Icons.photo_library,
                                            size: 50,
                                            color: Colors.grey,
                                          )),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    pickImageFiles();
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                  ),
                                  label: const Text(
                                    'Pick Image',
                                    style: TextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Visibility(
                          visible: isvideo == true ? true : false,
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: controller != null &&
                                          controller.value.isInitialized
                                      ? AspectRatio(
                                          // aspectRatio: controller.value.aspectRatio,
                                          aspectRatio: 1 / 0.3,
                                          child: VideoPlayer(controller),
                                        )
                                      : widget.mediaTypeKey == "video"
                                          ? AspectRatio(
                                              // aspectRatio: controller.value.aspectRatio,
                                              aspectRatio: 1 / 0.3,
                                              child: VideoPlayer(controller!),
                                            )
                                          : const Center(
                                              child: Icon(
                                              Icons.photo_library,
                                              size: 50,
                                              color: Colors.grey,
                                            )),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      pickVideoFiles();
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text(
                                      'Pick Video',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Visibility(
                          visible: isGif == true ? true : false,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: gifData != null
                                    ? Image.memory(
                                        gifData!,
                                        fit: BoxFit.fill,
                                      )
                                    : widget.mediaTypeKey == "gif"
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                APIString.latestmediaBaseUrl +
                                                    widget.media!)
                                        : const Center(
                                            child: Icon(
                                            Icons.photo_library,
                                            size: 50,
                                            color: Colors.grey,
                                          )),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    pickGifFiles();
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                  ),
                                  label: const Text(
                                    'Pick Gif',
                                    style: TextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                              onTap: () async {
                                if (validation() == true) {
                                  widget.isEdit == false
                                      ? addCaseStudy()
                                      : editCaseStudy();
                                }
                                // Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Text(
                                    widget.isEdit == false ? "Save" : "Update"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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

  void pickFilesLogo(
      {bool addImage = false, String? numberBannerAutoId}) async {
    // Navigator.of(context).pop(false);
    showLoadingDialog(loader: false, loadingText: true, delay: true);

    try {
      _pathsLogo = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => log("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
      // setState(() {
      hideLoadingDialog();
      pathsFileLogo = _pathsLogo!.first.bytes!;
      pathsFileNameLogo = _pathsLogo!.first.name.removeAllWhitespace;
      setState(() {});
      // });
      log("_paths!.first.bytes  $pathsFileLogo --  ${_pathsLogo!.first.bytes!}");
      log("_paths!.first.name  $pathsFileNameLogo --  ${_pathsLogo!.first.name}");
      log("selected image is ----------> $_pathsLogo");

      // addImage == true
      //     ? addCaseStudy()
      //     : editCaseStudy(numberBannerAutoId: numberBannerAutoId);
    } on PlatformException catch (e) {
      log('Unsupported operation   $e');
    } catch (e) {
      log(e.toString());
      setState(() {
        if (_pathsLogo != null) {
          if (_pathsLogo != null) {
            log("selected image path is -----------> $_pathsLogo");
          }
        }
      });
    }
  }

  /// --- media
  void pickImageFiles() async {
    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;

      pathsFile = paths!.first.bytes!;
      pathsFileName = paths!.first.name;

      setState(() {
        imageData = pathsFile;
      });
    } on PlatformException catch (e) {
      log('Unsupported operation   $e');
    } catch (e) {
      log(e.toString());
      setState(() {
        if (paths != null) {
          if (paths != null) {
            log("selected image path is -----------> $paths");
          }
        }
      });
    }
  }

  void pickGifFiles() async {
    try {
      gifpaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['gif'],
      ))
          ?.files;

      gifpathsFile = gifpaths!.first.bytes!;
      gifpathsFileName = gifpaths!.first.name;

      setState(() {
        gifData = gifpathsFile;
      });
    } on PlatformException catch (e) {
      log('Unsupported operation   $e');
    } catch (e) {
      log(e.toString());
      setState(() {
        if (gifpaths != null) {
          if (gifpaths != null) {
            log("selected image path is -----------> $gifpaths");
          }
        }
      });
    }
  }

  Future<void> _createVideo(Uint8List bytes) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    // _controller = VideoPlayerController.network(url);
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller?.initialize();
    setState(() {});
  }

  Future<void> preVideo({String? link}) async {
    // _controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+link!);
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + link!));
    await _controller?.initialize();
    setState(() {});
  }

  void pickVideoFiles() async {
    try {
      videopaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['mp4', 'mov', 'avi'],
      ))
          ?.files;
      videopathsFile = videopaths!.first.bytes!;
      videopathsFileName = videopaths!.first.name;
      setState(() {
        videoData = videopathsFile;
        _createVideo(videoData!);
      });
    } on PlatformException catch (e) {
      log('Unsupported operation   $e');
    } catch (e) {
      log(e.toString());
      setState(() {
        if (videopaths != null) {
          if (videopaths != null) {
            log("selected image path is -----------> $videopaths");
          }
        }
      });
    }
  }

  Future addCaseStudy() async {
    showLoadingDialog();

    var url = APIString.grobizBaseUrl + APIString.addCaseStudy;
    Uri uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    try {
      if (pathsFileLogo != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              "case_study_image",
              pathsFileLogo,
              contentType: MediaType('application', 'x-tar'),
              filename: pathsFileNameLogo.toString().removeAllWhitespace,
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

    try {
      if (videoImg == 'video') {
        try {
          if (videopathsFile != null) {
            if (kIsWeb) {
              request.files.add(
                http.MultipartFile.fromBytes(
                  'media',
                  videopathsFile,
                  contentType: MediaType('application', 'x-tar'),
                  filename: videopathsFileName.toString(),
                ),
              );
            } else {
              hideLoadingDialog();
              showSnackbar(title: "", message: "Not Allowed");
            }
          }
          request.fields['media'] = '';
        } catch (exception) {
          request.fields['media'] = '';
          print('pic not selected');
        }
      }

      ///for Images file
      if (videoImg == 'image') {
        try {
          if (pathsFile != null) {
            if (kIsWeb) {
              request.files.add(
                http.MultipartFile.fromBytes(
                  'media',
                  pathsFile,
                  contentType: MediaType('application', 'x-tar'),
                  filename: pathsFileName.toString(),
                ),
              );
            } else {
              hideLoadingDialog();
              showSnackbar(title: "", message: "Not Allowed");
            }
          }
          request.fields['media'] = '';
        } catch (exception) {
          request.fields['media'] = '';
          print('pic not selected');
        }
      }

      ///for Gif file
      if (videoImg == 'gif') {
        try {
          if (gifpathsFile != null) {
            if (kIsWeb) {
              request.files.add(
                http.MultipartFile.fromBytes(
                  'media',
                  gifpathsFile,
                  contentType: MediaType('application', 'x-tar'),
                  filename: gifpathsFileName.toString(),
                ),
              );
            } else {
              hideLoadingDialog();
              showSnackbar(title: "", message: "Not Allowed");
            }
          }
          request.fields['media'] = '';
        } catch (exception) {
          request.fields['media'] = '';
          print('pic not selected');
        }
      }
    } catch (exception) {
      request.fields["media"] = '';
    }

    debugPrint(request.fields.toString());
    // request.fields["case_study_type"] = editCaseStudyController.type.text;
    request.fields["case_study_type"] = selectedValue!['case_study_type']!;
    // request.fields["case_study_category"] = editCaseStudyController.category.text;
    request.fields["case_study_category"] = selectedValue!['value']!;
    // request.fields["case_study_category"] = selectedValue!['id']!;
    request.fields["case_study_catagory_id"] = selectedValue!['id']!;

    request.fields["case_study_title"] = editCaseStudyController.title.text;
    request.fields["case_study_short_desciption"] =
        editCaseStudyController.shortDescription.text;
    request.fields["case_study_detail_desciption"] =
        editCaseStudyController.detailDescription.text;
    request.fields["mediaTypeKey"] = mediaTypeKey.toString();

    http.Response response =
        await http.Response.fromStream(await request.send());

    debugPrint("update response$response");
    hideLoadingDialog();
    editCaseStudyController.clearFields();
    _pathsLogo = null;
    pathsFileLogo = null;
    pathsFileNameLogo = null;

    if (response.statusCode == 200) {
      editCaseStudyController.getCaseStudy();
      final resp = jsonDecode(response.body);

      debugPrint(resp.toString());

      int status = resp['status'];
      if (status == 1) {
        showSnackbar(title: "", message: "Added successfully");
        Get.back();
      } else {
        String message = resp['msg'];
      }
    } else if (response.statusCode == 500) {
      hideLoadingDialog();
      showSnackbar(title: "", message: "Server Error");
      if (mounted) {
        setState(() {});
      }
    } else {
      hideLoadingDialog();
      showSnackbar(title: "", message: "Error");

      if (mounted) {
        setState(() {});
      }
    }
  }

  bool validation() {
    if (widget.isEdit == true) {
      if (profile.toString().isEmpty) {
        if (_pathsLogo == null) {
          Fluttertoast.showToast(
            msg: 'Please Select Profile Image',
            backgroundColor: Colors.grey,
          );
        }

        return false;
      }
    } else {
      if (_pathsLogo == null) {
        Fluttertoast.showToast(
          msg: 'Please Select Profile Image',
          backgroundColor: Colors.grey,
        );
        return false;
      }
    }

    if (selectedValue == null) {
      Fluttertoast.showToast(
        msg: 'Please Select Case Study Type',
        backgroundColor: Colors.grey,
      );
      return false;
    }

    if (editCaseStudyController.title.text.isEmpty ||
        editCaseStudyController.title.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Title',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (editCaseStudyController.shortDescription.text.isEmpty ||
        editCaseStudyController.shortDescription.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Short Description',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (editCaseStudyController.detailDescription.text.isEmpty ||
        editCaseStudyController.detailDescription.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Detail Description',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    // else if (videoImg.isEmpty || videoImg == "") {
    else if (mediaTypeKey.isEmpty || mediaTypeKey == "") {
      Fluttertoast.showToast(
        msg: 'Please Select Media type',
        backgroundColor: Colors.grey,
      );
      return false;
    }

    if (mediaTypeKey.isNotEmpty &&
        mediaTypeKey != "" &&
        mediaTypeKey == "image") {
      if (widget.isEdit == true) {
        if (widget.media!.isEmpty) {
          if (widget.mediaTypeKey != "image") {
            if (pathsFileName == null) {
              Fluttertoast.showToast(
                msg: 'Please Select type',
                backgroundColor: Colors.grey,
              );
              return false;
            }
          }
        }
      } else {
        if (pathsFileName == null) {
          Fluttertoast.showToast(
            msg: 'Please Select media',
            backgroundColor: Colors.grey,
          );
          return false;
        }
      }
    }

    if (mediaTypeKey.isNotEmpty &&
        mediaTypeKey != "" &&
        mediaTypeKey == "video") {
      if (widget.isEdit == true) {
        if (widget.media!.isEmpty) {
          if (widget.mediaTypeKey != "video") {
            if (videopathsFileName == null) {
              Fluttertoast.showToast(
                msg: 'Please Select type',
                backgroundColor: Colors.grey,
              );
              return false;
            }
          }
        }
      } else {
        if (videopathsFileName == null) {
          Fluttertoast.showToast(
            msg: 'Please Select media',
            backgroundColor: Colors.grey,
          );
          return false;
        }
      }
    }

    if (mediaTypeKey.isNotEmpty &&
        mediaTypeKey != "" &&
        mediaTypeKey == "gif") {
      if (widget.isEdit == true) {
        if (widget.media!.isEmpty) {
          if (widget.mediaTypeKey != "gif") {
            if (gifpathsFileName == null) {
              Fluttertoast.showToast(
                msg: 'Please Select type',
                backgroundColor: Colors.grey,
              );
              return false;
            }
          }
        }
      } else {
        if (gifpathsFileName == null) {
          Fluttertoast.showToast(
            msg: 'Please Select media',
            backgroundColor: Colors.grey,
          );
          return false;
        }
      }
    }

    return true;
  }

  Future editCaseStudy() async {
    showLoadingDialog();

    var url = APIString.grobizBaseUrl + APIString.editCaseStudy;
    Uri uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    try {
      if (pathsFileLogo != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              "case_study_image",
              pathsFileLogo,
              contentType: MediaType('application', 'x-tar'),
              filename: pathsFileNameLogo.toString().removeAllWhitespace,
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
    }

    try {
      if (videoImg == 'video') {
        try {
          if (videopathsFile != null) {
            if (kIsWeb) {
              request.files.add(
                http.MultipartFile.fromBytes(
                  'media',
                  videopathsFile,
                  contentType: MediaType('application', 'x-tar'),
                  filename: videopathsFileName.toString(),
                ),
              );
            } else {
              hideLoadingDialog();
              showSnackbar(title: "", message: "Not Allowed");
            }
          }
          request.fields['media'] = '';
        } catch (exception) {
          request.fields['media'] = '';
          print('pic not selected');
        }
      }

      ///for Images file
      if (videoImg == 'image') {
        try {
          if (pathsFile != null) {
            if (kIsWeb) {
              request.files.add(
                http.MultipartFile.fromBytes(
                  'media',
                  pathsFile,
                  contentType: MediaType('application', 'x-tar'),
                  filename: pathsFileName.toString(),
                ),
              );
            } else {
              hideLoadingDialog();
              showSnackbar(title: "", message: "Not Allowed");
            }
          }
          request.fields['media'] = '';
        } catch (exception) {
          request.fields['media'] = '';
          print('pic not selected');
        }
      }

      ///for Gif file
      if (videoImg == 'gif') {
        try {
          if (gifpathsFile != null) {
            if (kIsWeb) {
              request.files.add(
                http.MultipartFile.fromBytes(
                  'media',
                  gifpathsFile,
                  contentType: MediaType('application', 'x-tar'),
                  filename: gifpathsFileName.toString(),
                ),
              );
            } else {
              hideLoadingDialog();
              showSnackbar(title: "", message: "Not Allowed");
            }
          }
          request.fields['media'] = '';
        } catch (exception) {
          request.fields['media'] = '';
          print('pic not selected');
        }
      }
    } catch (exception) {
      request.fields["media"] = '';
    }

    request.fields["case_study_auto_id"] = widget.caseStudyAutoId.toString();
    // request.fields["case_study_type"] = editCaseStudyController.type.text;
    request.fields["case_study_type"] = selectedValue!['case_study_type']!;
    // request.fields["case_study_category"] = editCaseStudyController.category.text;
    request.fields["case_study_category"] = selectedValue!['value']!;
    // request.fields["case_study_category"] = selectedValue!['id']!;
    request.fields["case_study_catagory_id"] = selectedValue!['id']!;

    request.fields["case_study_title"] = editCaseStudyController.title.text;
    request.fields["case_study_short_desciption"] =
        editCaseStudyController.shortDescription.text;
    request.fields["case_study_detail_desciption"] =
        editCaseStudyController.detailDescription.text;
    request.fields["mediaTypeKey"] = mediaTypeKey.toString();

    debugPrint(request.fields.toString());

    http.Response response =
        await http.Response.fromStream(await request.send());
    hideLoadingDialog();

    debugPrint("update response$response");
    editCaseStudyController.clearFields();
    _pathsLogo = null;
    pathsFileLogo = null;
    pathsFileNameLogo = null;
    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      debugPrint(resp.toString());
      int status = resp['status'];
      if (status == 1) {
        showSnackbar(title: "", message: "Updated successfully");
        Get.back();
      } else {
        String message = resp['msg'];
      }
    } else if (response.statusCode == 500) {
      showSnackbar(title: "", message: "Server Error");
      if (mounted) {
        setState(() {});
      }
    } else {
      showSnackbar(title: "", message: "Error");
      if (mounted) {
        setState(() {});
      }
    }
  }

  Map<String, String>? selectedValue;
  final List<Map<String, String>> dropdownItems = [
    {
      "case_study_type": "AI",
      "value": "Artificial Intelligence",
    },
    {
      "case_study_type": "Science",
      "value": "Science & Technologies",
    },
    {
      "case_study_type": "Marketing",
      "value": "Marketing Fundamentals",
    },
    {
      "case_study_type": "Finance",
      "value": "Finance Services",
    },
  ];
}
