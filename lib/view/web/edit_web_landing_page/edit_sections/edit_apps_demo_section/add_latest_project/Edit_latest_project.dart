// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, avoid_web_libraries_in_flutter, implementation_imports, depend_on_referenced_packages, non_constant_identifier_names, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
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
import 'AddProjectModel.dart';

class EditProjects extends StatefulWidget {
  final GetProjectData data;

  const EditProjects({Key? key, required this.data}) : super(key: key);
  @override
  State<EditProjects> createState() => _EditProjectsState();
}

class _EditProjectsState extends State<EditProjects> {
  ///for gif file
  List<PlatformFile>? gifpaths;
  var gifpathsFile;
  var gifpathsFileName;
  Uint8List? gifData;

  ///for video file
  VideoPlayerController? videoController;
  List<PlatformFile>? videopaths;
  var videopathsFile;
  var videopathsFileName;
  Uint8List? videoData;
  VideoPlayerController? _controller;

  List<PlatformFile>? pathsThumbnail;
  var pathsFileThumbnail;
  var pathsFileNameThumbnail;
  Uint8List? imageDataThumbnail;

  ///for image file
  List<PlatformFile>? paths;
  var pathsFile;
  var pathsFileName;
  Uint8List? imageData;

  TextEditingController project_description_controller =
      TextEditingController();
  TextEditingController project_tile_controller = TextEditingController();
  final editController = Get.find<EditController>();
  bool isApiProcessing = false;
  String VideoImg = "";
  bool isvideo = false;
  bool isImage = false;
  bool isGif = false;
  String videoUrl = "";

  @override
  void initState() {
    super.initState();
    project_description_controller.text = widget.data.appShortDescription;
    project_tile_controller.text = widget.data.appName;
    videoUrl = widget.data.appMediaFile;

    checkisVideo();
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  checkisVideo() {
    if (widget.data.appMediaFileType == "image") {
      isImage = true;
      isvideo = false;
      isGif = false;
      VideoImg = "image";
    } else if (widget.data.appMediaFileType == "video") {
      isImage = false;
      isvideo = true;
      isGif = false;
      VideoImg = "video";
    } else if (widget.data.appMediaFileType == "gif") {
      isImage = false;
      isvideo = false;
      isGif = true;
      VideoImg = "gif";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Update Projects",
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
                                  groupValue: VideoImg,
                                  onChanged: (value) {
                                    setState(() {
                                      VideoImg = value as String;
                                      if (VideoImg == 'image') {
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
                                  groupValue: VideoImg,
                                  onChanged: (value) {
                                    setState(() {
                                      VideoImg = value as String;
                                      if (VideoImg == 'video') {
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
                                  groupValue: VideoImg,
                                  onChanged: (value) {
                                    setState(() {
                                      VideoImg = value as String;
                                      if (VideoImg == 'gif') {
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
                                      : CachedNetworkImage(
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          imageUrl:
                                              APIString.latestmediaBaseUrl +
                                                  widget.data.appMediaFile,
                                          placeholder: (context, url) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  editController
                                                      .appDemoBgColor.value
                                                      .toString())),
                                            ),
                                          ),
                                          // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.contain,
                                        ),
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
                            child: Column(
                              children: [
                                videoData != null
                                    ? (controller != null &&
                                            controller.value.isInitialized)
                                        ? AspectRatio(
                                            aspectRatio: 1 / 0.3,
                                            child: VideoPlayer(controller),
                                          )
                                        : AspectRatio(
                                            aspectRatio: 1 / 0.3,
                                            child: VideoPlayer(controller!),
                                          )
                                    : displayUploadedVideo(),
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
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
                                  child: imageDataThumbnail != null
                                      ? Image.memory(
                                          imageDataThumbnail!,
                                          fit: BoxFit.fill,
                                        )
                                      : CachedNetworkImage(
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          imageUrl:
                                              APIString.latestmediaBaseUrl +
                                                  widget.data.videoThumbnail,
                                          placeholder: (context, url) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  editController
                                                      .appDemoBgColor.value
                                                      .toString())),
                                            ),
                                          ),
                                          // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.contain,
                                        ),
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
                                      pickThumbnailFiles();
                                    },
                                    icon: const Icon(
                                      Icons.camera,
                                    ),
                                    label: const Text(
                                      'Pick Thumbnail Image',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ],
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
                                          fit: BoxFit.contain,
                                        )
                                      : CachedNetworkImage(
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          imageUrl:
                                              APIString.latestmediaBaseUrl +
                                                  widget.data.appMediaFile,
                                          placeholder: (context, url) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  editController
                                                      .appDemoBgColor.value
                                                      .toString())),
                                            ),
                                          ),
                                          // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.contain,
                                        ),
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
                          "Project Title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: project_tile_controller,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Enter Project Title",
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
                        const Text(
                          "Project Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: project_description_controller,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 15, 0, 0),
                                hintText: 'Enter Project Description',
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
                            maxLines: 5,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
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
                                    editProjectApi();
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
                                      "Update",
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

  // Widget displayUploadedVideo() {
  //   if (videoController != null && videoController!.value.isInitialized) {
  //     return AspectRatio(
  //       aspectRatio: videoController!.value.aspectRatio,
  //       child: VideoPlayer(videoController!),
  //     );
  //   } else {
  //     return Center(child: CircularProgressIndicator());
  //   }
  // }

  Future<void> _createVideo(Uint8List bytes) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    _controller = VideoPlayerController.network(url);
    await _controller?.initialize();
    setState(() {});
  }

  void pickVideoFiles() async {
    showLoadingDialog(loader: false, loadingText: true, delay: true);

    try {
      videopaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['mp4', 'mov', 'avi'],
      ))
          ?.files;
      hideLoadingDialog();
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

  Widget displayUploadedVideo() {
    VideoPlayerController controller = VideoPlayerController.network(
        APIString.latestmediaBaseUrl + widget.data.appMediaFile);
    bool isVideoPlaying = false;

    return GestureDetector(
      onTap: () {
        if (controller.value.isPlaying) {
          controller.pause();
        } else {
          controller.play();
        }
        isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
              aspectRatio: 1 / 0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(controller),
                  if (!isVideoPlaying)
                    Icon(
                      Icons.play_circle_fill,
                      size: 80,
                      color: Colors.white.withOpacity(0.7),
                    ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            );
          }
        },
      ),
    );
  }

  Future editProjectApi() async {
    var url = APIString.grobizBaseUrl + APIString.edit_app_created_by_grobiz;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    // app_created_auto_id,app_name,app_short_description,app_media_file, app_media_file_type
    ///for video file
    if (VideoImg == 'video') {
      try {
        if (videopathsFile != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'app_media_file',
                videopathsFile,
                contentType: MediaType('application', 'x-tar'),
                filename: videopathsFileName.toString(),
              ),
            );
          } else {
            hideLoadingDialog();
            showSnackbar(message: "Not Allowed");
          }
        }
        request.fields['app_media_file'] = '';
      } catch (exception) {
        request.fields['app_media_file'] = '';
      }

      try {
        if (pathsFileThumbnail != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'video_thumbnail',
                pathsFileThumbnail,
                contentType: MediaType('application', 'x-tar'),
                filename: pathsFileNameThumbnail.toString(),
              ),
            );
          } else {
            hideLoadingDialog();
            showSnackbar(message: "Not Allowed");
          }
        }
        request.fields['video_thumbnail'] = '';
      } catch (exception) {
        request.fields['video_thumbnail'] = '';
      }
    }

    ///for Images file
    if (VideoImg == 'image') {
      try {
        if (pathsFile != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'app_media_file',
                pathsFile,
                contentType: MediaType('application', 'x-tar'),
                filename: pathsFileName.toString(),
              ),
            );
          } else {
            hideLoadingDialog();
            showSnackbar(message: "Not Allowed");
          }
        }
        request.fields['app_media_file'] = '';
      } catch (exception) {
        request.fields['app_media_file'] = '';
      }
    }

    ///for Gif file

    if (VideoImg == 'gif') {
      try {
        if (gifpathsFile != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'app_media_file',
                gifpathsFile,
                contentType: MediaType('application', 'x-tar'),
                filename: gifpathsFileName.toString(),
              ),
            );
          } else {
            hideLoadingDialog();
            showSnackbar(message: "Not Allowed");
          }
        }
        request.fields['app_media_file'] = '';
      } catch (exception) {
        request.fields['app_media_file'] = '';
      }
    }
    // app_created_auto_id,app_name,app_short_description,app_media_file, app_media_file_type
    request.fields["app_created_auto_id"] = widget.data.id;
    request.fields["app_name"] = project_tile_controller.text;
    request.fields["app_short_description"] =
        project_description_controller.text;
    request.fields["app_media_file_type"] = VideoImg;

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      //String message=resp['msg'];
      int status = resp['status'];
      if (status == 1) {
        Fluttertoast.showToast(
          msg: "Update App successfully",
          backgroundColor: Colors.grey,
        );
        Get.back();
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
    showLoadingDialog(loader: false, loadingText: true, delay: true);

    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
      hideLoadingDialog();
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

  void pickThumbnailFiles() async {
    showLoadingDialog(loader: false, loadingText: true, delay: true);

    try {
      pathsThumbnail = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
      hideLoadingDialog();
      pathsFileThumbnail = pathsThumbnail!.first.bytes!;
      pathsFileNameThumbnail = pathsThumbnail!.first.name;

      setState(() {
        imageDataThumbnail = pathsFileThumbnail;
      });
    } on PlatformException catch (e) {
      log('Unsupported operation   $e');
    } catch (e) {
      log(e.toString());
      setState(() {
        if (pathsThumbnail != null) {
          if (pathsThumbnail != null) {
            log("selected image path is -----------> $pathsThumbnail");
          }
        }
      });
    }
  }

  void pickGifFiles() async {
    showLoadingDialog(loader: false, loadingText: true, delay: true);

    try {
      gifpaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['gif'],
      ))
          ?.files;
      hideLoadingDialog();
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

// void pickVideoFiles() async {
//    showLoadingDialog(loader: false,loadingText: true,delay: true);
//   try {
//     videopaths = (await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowMultiple: false,
//       onFileLoading: (FilePickerStatus status) =>
//           print("status .... $status"),
//       allowedExtensions: ['mp4', 'mov', 'avi'],
//     ))?.files;
//hideLoadingDialog();
//     videopathsFile = videopaths!.first.bytes!;
//     videopathsFileName = videopaths!.first.name;
//
//     setState(() {
//       videoController = VideoPlayerController.file(File(videopathsFileName))
//         ..initialize().then((_) {
//           setState(() {});
//         });
//     });
//
//   } on PlatformException catch (e) {
//     log('Unsupported operation   $e');
//   } catch (e) {
//     log(e.toString());
//     setState(() {
//       if (videopaths != null) {
//         if (videopaths != null) {
//           log("selected image path is -----------> $videopaths");
//         }
//       }
//     });
//   }
// }
}
