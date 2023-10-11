// ignore_for_file: implementation_imports, prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/showcase_app_controller.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:video_player/video_player.dart';

import 'dart:html' as html;

import 'package:http/http.dart' as http;

import '../../../../../config/api_string.dart';
import '../../../../../widget/common_snackbar.dart';
import '../../../../../widget/loading_dialog.dart';

class AddNewShowCaseApps extends StatefulWidget {
  const AddNewShowCaseApps({Key? key}) : super(key: key);
  @override
  State<AddNewShowCaseApps> createState() => _AddNewShowCaseAppsState();
}

class _AddNewShowCaseAppsState extends State<AddNewShowCaseApps> {
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

  ///for image file
  List<PlatformFile>? paths;
  var pathsFile;
  var pathsFileName;
  Uint8List? imageData;

  TextEditingController projectTileController = TextEditingController();
  final showCaseAppsController = Get.find<ShowCaseAppsController>();
  bool isApiProcessing = false;
  String videoImg = "";
  bool isvideo = false;
  bool isImage = false;
  bool isGif = false;

  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = videoController;
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Add Show Case Apps",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Row(children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: Get.width > 800 ? 700 : 400,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                            child: Text(
                          "Select Image , Video or Gif  for upload",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
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
                                      log(value);
                                      log(videoImg);
                                      if (videoImg == 'image') {
                                        isImage = true;
                                        isvideo = false;
                                        isGif = false;
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
                                      log("Img_video==");
                                      log(value);
                                      log(videoImg);
                                      if (videoImg == 'video') {
                                        isvideo = true;
                                        isImage = false;
                                        isGif = false;
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
                                      log("Img_gif==");
                                      log(value);
                                      log(videoImg);
                                      if (videoImg == 'gif') {
                                        isGif = true;
                                        isImage = false;
                                        isvideo = false;
                                      } else {
                                        isGif = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ), //275

                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Center(
                                child: Text(
                              "Media Size : height*width - 275*650",
                            )),
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
                                  if (controller != null &&
                                      controller.value.isInitialized)
                                    AspectRatio(
                                      // aspectRatio: controller.value.aspectRatio,
                                      aspectRatio: 1 / 0.3,
                                      child: VideoPlayer(controller),
                                    ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
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
                        const SizedBox(
                          height: 20,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Enter Title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        TextFormField(
                          controller: projectTileController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Enter Title",
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.white,
                          child: isApiProcessing == true
                              ? Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  width: 80,
                                  child:
                                      const GFLoader(type: GFLoaderType.circle),
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (validation() == true) {
                                      addShowCaseApi();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent,
                                    ),
                                    height: 40,
                                    padding: const EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Add",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                        )
                      ]),
                ),
                const Expanded(child: SizedBox()),
              ]),
            ),
          ),
        );
      },
    );
  }

  Future addShowCaseApi() async {
    var url = APIString.grobizBaseUrl + APIString.add_userlist;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    // files,file_mediatype, title
    ///for video file
    if (videoImg == 'video') {
      try {
        if (videopathsFile != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'files',
                videopathsFile,
                contentType: MediaType('application', 'x-tar'),
                filename: videopathsFileName.toString(),
              ),
            );
          } else {
            hideLoadingDialog();
            showSnackbar(  message: "Not Allowed");
          }
        }
        request.fields['files'] = '';
      } catch (exception) {
        request.fields['files'] = '';
        log('pic not selected');
      }
    }

    ///for Images file
    if (videoImg == 'image') {
      try {
        if (pathsFile != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'files',
                pathsFile,
                contentType: MediaType('application', 'x-tar'),
                filename: pathsFileName.toString(),
              ),
            );
          } else {
            hideLoadingDialog();
            showSnackbar(  message: "Not Allowed");
          }
        }
        request.fields['files'] = '';
      } catch (exception) {
        request.fields['files'] = '';
        log('pic not selected');
      }
    }

    ///for Gif file

    if (videoImg == 'gif') {
      try {
        if (gifpathsFile != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'files',
                gifpathsFile,
                contentType: MediaType('application', 'x-tar'),
                filename: gifpathsFileName.toString(),
              ),
            );
          } else {
            hideLoadingDialog();
            showSnackbar(  message: "Not Allowed");
          }
        }
        request.fields['files'] = '';
      } catch (exception) {
        request.fields['files'] = '';
        log('pic not selected');
      }
    }
    request.fields["title"] = projectTileController.text;
    request.fields["file_mediatype"] = videoImg;

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      log(resp.toString());
      //String message=resp['msg'];
      int status = resp['status'];
      if (status == 1) {
        Fluttertoast.showToast(
          msg: " successfully Added",
          backgroundColor: Colors.grey,
        );
        showCaseAppsController.getShowCaseApi();
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong.Please try later",
          backgroundColor: Colors.grey,
        );
      }
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(
        msg: "Server Error",
        backgroundColor: Colors.grey,
      );
    }
  }

  void pickImageFiles() async {
    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => log("status .... $status"),
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
        onFileLoading: (FilePickerStatus status) => log("status .... $status"),
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
    videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoController?.initialize();
    setState(() {});
  }

  void pickVideoFiles() async {
    try {
      videopaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => log("status .... $status"),
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

  bool validation() {
    if (projectTileController.text.isEmpty ||
        projectTileController.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Project Title',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (videoImg.isEmpty || videoImg == "") {
      Fluttertoast.showToast(
        msg: 'Please Select type',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
  }
}
