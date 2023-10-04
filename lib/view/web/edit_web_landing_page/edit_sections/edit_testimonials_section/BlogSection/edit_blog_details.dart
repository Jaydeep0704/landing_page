// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, non_constant_identifier_names, deprecated_member_use, must_be_immutable, avoid_web_libraries_in_flutter, implementation_imports, depend_on_referenced_packages

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_details_list.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:http_parser/src/media_type.dart';

import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'blog_controller.dart';

class EditBlogDetails extends StatefulWidget {
  // final String id;
  final String blog_id;
  var data;

  EditBlogDetails({Key? key, required this.blog_id, required this.data})
      : super(key: key);
  @override
  State<EditBlogDetails> createState() => _EditBlogDetailsState();
}

class _EditBlogDetailsState extends State<EditBlogDetails> {
  final blog_controller = Get.find<EditBlogController>();

  TextEditingController tileController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String mediaTypeKey = "";

  String VideoImg = "";
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
    super.initState();
    tileController.text = widget.data["title"];
    descController.text = widget.data["description"];
    mediaTypeKey = widget.data["mediaTypeKey"];
    mediaTypeKey = widget.data["mediaTypeKey"];

    if (widget.data["mediaTypeKey"] == "video") {
      VideoImg = "video";
      isvideo = true;
      isImage = false;
      isGif = false;
      preVideo(link: widget.data["media"]);
    }
    if (widget.data["mediaTypeKey"] == "image") {
      VideoImg = "image";
      isvideo = false;
      isImage = true;
      isGif = false;
    }
    if (widget.data["mediaTypeKey"] == "gif") {
      VideoImg = "gif";
      isvideo = false;
      isImage = false;
      isGif = true;
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
            title: const Text("Edit Blog Details",
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
                  width: Get.width > 800 ? 500 : 300,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: tileController,
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
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: descController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 15, 0, 0),
                                hintText: 'Enter Description',
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
                        const Center(
                            child: Text(
                          "Select Media type",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                        const SizedBox(
                          height: 20,
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
                                        mediaTypeKey = "image";
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
                                        mediaTypeKey = "video";
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
                                        mediaTypeKey = "gif";
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
                                      : widget.data["mediaTypeKey"] == "image"
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  APIString.latestmediaBaseUrl +
                                                      widget.data["media"])
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
                                        : widget.data["mediaTypeKey"] == "video"
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
                                      : widget.data["mediaTypeKey"] == "gif"
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  APIString.latestmediaBaseUrl +
                                                      widget.data["media"])
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
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () async {
                              // if(validation()==true){
                              editBlogDetailsApis();
                              // }
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

  bool validation() {
    if (tileController.text.isEmpty || tileController.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Title',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (descController.text.isEmpty || descController.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Description',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (mediaTypeKey.toString().isEmpty) {
      Fluttertoast.showToast(
        msg: 'Media Type Unavailable',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
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
    _controller = VideoPlayerController.network(url);
    await _controller?.initialize();
    setState(() {});
  }

  Future<void> preVideo({String? link}) async {
    _controller =
        VideoPlayerController.network(APIString.latestmediaBaseUrl + link!);
    await _controller?.initialize();
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

  Future editBlogDetailsApis() async {
    showLoadingDialog();

    var url = APIString.grobizBaseUrl + APIString.edit_blog_details;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    try {
      ///for video file
      if (VideoImg == 'video') {
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
        }
      }

      ///for Images file
      if (VideoImg == 'image') {
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
        }
      }

      ///for Gif file
      if (VideoImg == 'gif') {
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
        }
      }

      request.fields["blog_auto_id"] = widget.blog_id;
      request.fields["blog_details_auto_id"] = widget.data["_id"];
      request.fields["title"] = tileController.text;
      request.fields["description"] = descController.text;
      request.fields["mediaTypeKey"] = mediaTypeKey.toString();

      http.Response response =
          await http.Response.fromStream(await request.send());
      hideLoadingDialog();

      if (response.statusCode == 200) {
        final resp = jsonDecode(response.body);
        int status = resp['status'];
        if (status == 1) {
          Fluttertoast.showToast(
            msg: "successfully Added",
            backgroundColor: Colors.grey,
          );
          Get.off(() => BlogDetailsList(id: widget.blog_id.toString()));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BlogDetailsList(id: widget.blog_id.toString())));
        } else {
          Fluttertoast.showToast(
            msg: "Something went wrong. Please try later",
            backgroundColor: Colors.grey,
          );
        }
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
          msg: "Server Error",
          backgroundColor: Colors.grey,
        );
      }
    } catch (exception) {
      log("error ---- $exception");
    }
  }
}
