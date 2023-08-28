// ignore_for_file: use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables, avoid_print, implementation_imports, avoid_web_libraries_in_flutter, unnecessary_import, depend_on_referenced_packages

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:video_player/video_player.dart';

class AddUpdateCaseStudyDetails extends StatefulWidget {
  bool? isEdit = true;
  String? title;
  String? description;
  String? caseStudyAutoId;
  String? caseStudyDetailsAutoId;
  String? media;
  String? mediaTypeKey;
  AddUpdateCaseStudyDetails({super.key,this.mediaTypeKey,this.caseStudyAutoId,this.caseStudyDetailsAutoId,this.description,this.isEdit,this.media,this.title});

  @override
  State<AddUpdateCaseStudyDetails> createState() =>
      _AddUpdateCaseStudyDetailsState();
}

class _AddUpdateCaseStudyDetailsState extends State<AddUpdateCaseStudyDetails> {

  final detailCaseStudyController = Get.find<DetailCaseStudyController>();
  // final editPartnerController = Get.find<EditPartnerController>();
  ///
  String mediaTypeKey = "";

  String videoImg = "";
  bool isvideo = false;
  bool isImage = false;
  bool isGif = false;
  VideoPlayerController? _controller;

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
    if(widget.isEdit == true){
      mediaTypeKey = widget.mediaTypeKey!;
      videoImg = widget.mediaTypeKey!;
      detailCaseStudyController.titleController.text = widget.title!;
      detailCaseStudyController.descController.text =widget.description!;
      // VideoImg = mediaTypeKey.toString();
      if(mediaTypeKey == "image"){
        isImage = true;
        isvideo = false;
        isGif = false;

      }
      else if(mediaTypeKey == "video"){
        isImage = false;
        isvideo = true;
        isGif = false;
        preVideo(link: widget.media!);
      }
      else if(mediaTypeKey == "gif"){
        isImage = false;
        isvideo = false;
        isGif = true;
      }
    }
    else{
      detailCaseStudyController.titleController.clear();
      detailCaseStudyController.descController.clear();
      mediaTypeKey = "";
      videoImg = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.isEdit == false ?"Add Data":"Edit Data"),
          // backgroundColor: AppColors.whiteColor,
          centerTitle: true,),
          body: SingleChildScrollView(
            child: Row(
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
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  width: Get.width > 800 ? 700 : Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text("Title",style: AppTextStyle.regular400.copyWith(fontSize: 16),),
                      const SizedBox(height: 10),
                      Container(
                        // width: Get.width/2,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
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
                       Text("Description",style: AppTextStyle.regular400.copyWith(fontSize: 16),),
                      const SizedBox(height: 10),
                      Container(
                        // width: Get.width/2,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
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
                       Text("Media",style: AppTextStyle.regular400.copyWith(fontSize: 16),),
                      const SizedBox(height: 10),
                      Container(
                        // width: Get.width/2,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
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
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            const Center(child: Text("Select Media type",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                            const SizedBox(height: 20,),
                            Row(
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
                            const SizedBox(height: 10,),
                            Visibility(
                                visible:isImage == true ? true : false,
                                child:
                                Column(
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
                                          :  widget.mediaTypeKey == "image" ?
                                      CachedNetworkImage(imageUrl: APIString.latestmediaBaseUrl + widget.media!)
                                          :const Center(child:  Icon(
                                        Icons.photo_library,
                                        size: 50,
                                        color: Colors.grey,
                                      )),
                                    ),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.05,
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
                                )
                            ),
                            Visibility(
                                visible:isvideo == true ? true : false,
                                child:
                                Center(
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
                                        child: controller != null && controller.value.isInitialized ?
                                        AspectRatio(
                                          // aspectRatio: controller.value.aspectRatio,
                                          aspectRatio: 1 / 0.3,
                                          child: VideoPlayer(controller),
                                        ): widget.mediaTypeKey == "video" ?
                                        AspectRatio(
                                          // aspectRatio: controller.value.aspectRatio,
                                          aspectRatio: 1 / 0.3,
                                          child: VideoPlayer(controller!),
                                        )
                                            :const Center(child:  Icon(
                                          Icons.photo_library,
                                          size: 50,
                                          color: Colors.grey,
                                        )),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.05,
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
                                )
                            ),
                            Visibility(
                                visible: isGif == true ? true : false,
                                child:
                                Column(
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
                                          :  widget.mediaTypeKey == "gif" ?
                                      CachedNetworkImage(imageUrl: APIString.latestmediaBaseUrl + widget.media!)
                                          :const Center(child:  Icon(
                                        Icons.photo_library,
                                        size: 50,
                                        color: Colors.grey,
                                      )),
                                    ),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.05,
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
                                )
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                            onTap: () async {
                              widget.isEdit == false
                                  ?addCaseStudyDetailsApis()
                                  :editCaseStudyDetailsApis();
                              // Navigator.pop(context);
                            },
                                child: Container(

                                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                                child: Text(widget.isEdit == false ?"Save":"Update"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),

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
    _controller = VideoPlayerController.networkUrl(Uri.parse(APIString.latestmediaBaseUrl+link!));
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

  Future addCaseStudyDetailsApis() async {
    showLoadingDialog();
    var url = APIString.grobizBaseUrl + APIString.addCaseStudyDetails;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    // title,content,blogTypeKey,media,media_type,userImage,userName,blogs_section_color
    try {
      ///for video file
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

      request.fields["case_study_auto_id"] = widget.caseStudyAutoId!;
      request.fields["title"] = detailCaseStudyController.titleController.text;
      request.fields["description"] = detailCaseStudyController.descController.text;
      request.fields["mediaTypeKey"] = mediaTypeKey.toString();

      http.Response response =
          await http.Response.fromStream(await request.send());
      hideLoadingDialog();

      if (response.statusCode == 200) {
        final resp = jsonDecode(response.body);
        print(resp.toString());
        //String message=resp['msg'];
        int status = resp['status'];
        if (status == 1) {
          showSnackbar(title: "", message: "Successfully Added");
          Get.back();
        } else {
          showSnackbar(title: "", message: "Something went wrong. Please try later");
        }
      } else if (response.statusCode == 500) {
        showSnackbar(title: "", message: "Server Error");
      }
    } catch (exception) {
      log("error ---- $exception");
    }
  }

  Future editCaseStudyDetailsApis() async {
    showLoadingDialog();
    var url = APIString.grobizBaseUrl + APIString.addCaseStudyDetails;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    try {
      ///for video file
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


      request.fields["case_study_auto_id"] = widget.caseStudyAutoId!;
      request.fields["case_study_details_auto_id"] = widget.caseStudyDetailsAutoId!;
      request.fields["title"] = detailCaseStudyController.titleController.text;
      request.fields["description"] = detailCaseStudyController.descController.text;
      request.fields["mediaTypeKey"] = mediaTypeKey.toString();

      http.Response response = await http.Response.fromStream(await request.send());
      hideLoadingDialog();

      if (response.statusCode == 200) {
        final resp = jsonDecode(response.body);
        print(resp.toString());
        //String message=resp['msg'];
        int status = resp['status'];
        if (status == 1) {
          showSnackbar(title: "", message: "Successfully Updated");
          Get.back();
        } else {
          showSnackbar(title: "", message: "Something went wrong. Please try later");
        }
      }
      else if (response.statusCode == 500) {
        showSnackbar(title: "", message: "Server Error");
      }
    } catch (exception) {
      log("error ---- $exception");
    }
  }




}
