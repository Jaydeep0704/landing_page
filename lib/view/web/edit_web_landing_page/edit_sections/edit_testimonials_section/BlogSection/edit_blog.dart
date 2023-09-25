// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, implementation_imports, avoid_web_libraries_in_flutter, non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/related_blog/types/blog_category_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
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

class EditBlog extends StatefulWidget {
  final String id;
  final String name;
  final String title;
  final String content;
  final String blogtype;
  final String blogsSectionColor;
  final String blogCatagoryId;
  final String bgColor;
  final String media;
  final String profilimg;
  final String mediatype;
  const EditBlog(
      {Key? key,
      required this.id,
      required this.name,
      required this.bgColor,
      required this.content,
      required this.title,
      required this.blogsSectionColor,
      required this.blogCatagoryId,
      required this.blogtype,
      required this.profilimg,
      required this.mediatype,
      required this.media})
      : super(key: key);
  // EditCheckOutInfo({Key? key,required this.data}) : super(key: key);
  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  Map<String, String>? selectedValue;
  final blogCategoriesController = Get.find<BlogCategoriesController>();

  ///for Profile image file
  List<PlatformFile>? Profilepaths;
  var ProfilepathsFile;
  var profilepathsFileName;
  Uint8List? pimageData;

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

  ///for image file
  List<PlatformFile>? paths;
  var pathsFile;
  var pathsFileName;
  Uint8List? imageData;
  TextEditingController username_controller = TextEditingController();
  TextEditingController title_controller = TextEditingController();
  TextEditingController content_controller = TextEditingController();
  TextEditingController BlogType_controller = TextEditingController();
  TextEditingController color_controller = TextEditingController();
  final testimonalcontroller = Get.find<EditTestimonialController>();
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
    getData();
    // blogCategoriesController.geBlogCategory().whenComplete(() => print("****"));

    username_controller.text = widget.name;
    title_controller.text = widget.title;
    content_controller.text = widget.content;
    BlogType_controller.text = widget.blogtype;
    color_controller.text = widget.bgColor;
    videoUrl = widget.media;

    checkIsVideo();
  }

  getData() {
    Future.delayed(
      const Duration(microseconds: 50),
      () => blogCategoriesController.geBlogCategory().whenComplete(() {
        log("-=-=-=-=");

        List<Map<String, String>> data = blogCategoriesController
            .blogsCategories
            .where((p0) => p0["id"] == widget.blogCatagoryId)
            .toList();
        selectedValue = data[0];
        log("selectedValue loaded   $selectedValue");
      }),
    );
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  checkIsVideo() {
    if (widget.mediatype == "image") {
      isImage = true;
      isvideo = false;
      isGif = false;
      VideoImg = "image";
    } else if (widget.mediatype == "video") {
      isImage = false;
      isvideo = true;
      isGif = false;
      VideoImg = "video";
    } else if (widget.mediatype == "gif") {
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
            title: const Text("Update Blog",
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
                        const Center(
                            child: Text(
                          "Select Profile Image",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              pickProfile();
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: pimageData != null
                                  ? Image.memory(
                                      pimageData!,
                                      fit: BoxFit.fill,
                                    )
                                  : CachedNetworkImage(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      imageUrl: APIString.latestmediaBaseUrl +
                                          widget.profilimg,
                                      placeholder: (context, url) => Container(
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(editController
                                              .appDemoBgColor.value
                                              .toString())),
                                        ),
                                      ),
                                      // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    ),
                              // pimageData != null
                              //     ? Image.memory(
                              //   pimageData!,
                              //   fit: BoxFit.fill,
                              // )
                              //     : Center(child:  Icon(
                              //   Icons.photo_library,
                              //   size: 50,
                              //   color: Colors.grey,
                              // )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const Text(
                          "Select Blog Type",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return blogCategoriesController
                                  .blogsCategories.isEmpty
                              ? const Text("Please Wait while Categories Load")
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
                                  items: blogCategoriesController
                                      .blogsCategories
                                      .map<
                                              DropdownMenuItem<
                                                  Map<String, String>>>(
                                          (Map<String, String> item) {
                                    return DropdownMenuItem<
                                        Map<String, String>>(
                                      value: item,
                                      // child: Text("${item['blog_type']} - ${item['value']}"),
                                      child: Text("${item['blog_type']}"),
                                    );
                                  }).toList(),
                                );
                        }),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Enter User Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: username_controller,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Enter User Name",
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
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.3,
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
                          controller: title_controller,
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
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.3,
                        ),
                        const Text(
                          "Enter Content",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: content_controller,
                          maxLines: 10,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Enter Content",
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
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.3,
                        ),
                        // const Text(
                        //   "Enter Blog Type",
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   controller: BlogType_controller,
                        //   decoration: InputDecoration(
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //       contentPadding: const EdgeInsets.all(10),
                        //       hintText: "Enter Blog Type",
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //             color: Colors.grey, width: 1),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       errorBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //             color: Colors.red, width: 1),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //             color: Colors.black, width: 1),
                        //         borderRadius: BorderRadius.circular(10),
                        //       )),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // const Divider(
                        //   color: Colors.grey,
                        //   thickness: 0.3,
                        // ),
                        // const Text(
                        //   "Enter Blog Section Color",
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   controller: color_controller,
                        //   decoration: InputDecoration(
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //       contentPadding: const EdgeInsets.all(10),
                        //       hintText: "Enter Blog Section Color",
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //             color: Colors.grey, width: 1),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       errorBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //             color: Colors.red, width: 1),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //             color: Colors.black, width: 1),
                        //         borderRadius: BorderRadius.circular(10),
                        //       )),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // const Divider(
                        //   color: Colors.grey,
                        //   thickness: 0.3,
                        // ),
                        const Center(
                            child: Text(
                          "Select  Media type",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
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
                                      log(value);
                                      log(VideoImg);
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
                                      log("Img_video==");
                                      log(value);
                                      log(VideoImg);
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
                                      log("Img_gif==");
                                      log(value);
                                      log(VideoImg);
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
                                                  widget.media,
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
                                                  widget.media,
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
                                      editBlog();
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

  Future<void> _createVideo(Uint8List bytes) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller?.initialize();
    setState(() {});
  }

  void pickVideoFiles() async {
    try {
      videopaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            log("status .... $status"),
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

  Widget displayUploadedVideo() {
    VideoPlayerController vController = VideoPlayerController.networkUrl(
        Uri.parse(APIString.latestmediaBaseUrl + widget.media));
    bool isVideoPlaying = false;

    return GestureDetector(
      onTap: () {
        if (vController.value.isPlaying) {
          vController.pause();
        } else {
          vController.play();
        }
        isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: vController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
              aspectRatio: 1 / 0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(vController),
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

  void pickImageFiles() async {
    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            log("status .... $status"),
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
            log("status .... $status"),
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

  void pickProfile() async {
    try {
      Profilepaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            log("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;

      ProfilepathsFile = Profilepaths!.first.bytes!;
      profilepathsFileName = Profilepaths!.first.name;

      setState(() {
        pimageData = ProfilepathsFile;
      });
    } on PlatformException catch (e) {
      log('Unsupported operation   $e');
    } catch (e) {
      log(e.toString());
      setState(() {
        if (Profilepaths != null) {
          if (Profilepaths != null) {
            log("selected image path is -----------> $paths");
          }
        }
      });
    }
  }

  bool validation() {
    if (widget.profilimg.toString().isEmpty) {
      if (pimageData == null) {
        Fluttertoast.showToast(
          msg: 'Please Select Profile Image',
          backgroundColor: Colors.grey,
        );
      }

      return false;
    }
    if (username_controller.text.isEmpty || username_controller.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Name',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (title_controller.text.isEmpty || title_controller.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Title',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (content_controller.text.isEmpty ||
        content_controller.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Content',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    // else if (BlogType_controller.text.isEmpty || BlogType_controller.text == "") {
    else if (selectedValue == null) {
      Fluttertoast.showToast(
        msg: 'Please Select Blog Type',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    /*  else if (color_controller.text.isEmpty || color_controller.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Color',
        backgroundColor: Colors.grey,
      );
      return false;
    }*/
    else if (VideoImg.isEmpty || VideoImg == "") {
      Fluttertoast.showToast(
        msg: 'Please Select type',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
  }

  Future editBlog() async {
    var url = APIString.grobizBaseUrl + APIString.edit_blog;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    // blog_auto_id,title,content,blogTypeKey,
    // media,media_type,userImage,
    // userName,blogs_section_color
    try {
      if (ProfilepathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'userImage',
              ProfilepathsFile,
              contentType: MediaType('application', 'x-tar'),
              filename: profilepathsFileName.toString(),
            ),
          );
        } else {
          hideLoadingDialog();
          showSnackbar(title: "", message: "Not Allowed");
        }
      }
      request.fields['userImage'] = '';
    } catch (exception) {
      request.fields['userImage'] = '';
      log('pic not selected');
    }

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
        log('pic not selected');
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
        log('pic not selected');
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
        log('pic not selected');
      }
    }
    // blog_auto_id,title,content,blogTypeKey,
    // media,media_type,userImage,
    // userName,blogs_section_color
    request.fields["blog_auto_id"] = widget.id;
    request.fields["userName"] = username_controller.text;
    request.fields["content"] = content_controller.text;
    request.fields["title"] = title_controller.text;
    request.fields["media_type"] = VideoImg;

    ///use it as a value of blog category -> blogs_section_color
    ///use it as a blog_type of blog category -> blogTypeKey

    log("selectedValue!['id']!   ${selectedValue!['id']!}");
    log("selectedValue!['blog_type']!   ${selectedValue!['blog_type']!}");

    //selectedValue!['blog_type']!;
    // request.fields["blogs_section_color"] = color_controller.text;
    request.fields["blogs_section_color"] = selectedValue!['value']!;
    // request.fields["blogs_section_color"] = selectedValue!['id']!;
    request.fields["blog_catagory_id"] = selectedValue!['id']!;
// request.fields["blogTypeKey"] = blogType_controller.text;
    request.fields["blogTypeKey"] = selectedValue!['blog_type']!;

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final resp = jsonDecode(response.body);
      log(resp.toString());
      //String message=resp['msg'];
      int status = resp['status'];
      if (status == 1) {
        Fluttertoast.showToast(
          msg: " successfully updated",
          backgroundColor: Colors.grey,
        );
        Get.back();
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BlogListScreen()));
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

  final List<Map<String, String>> dropdownItems = [
    {
      "blog_type": "AI",
      "value": "Artificial Intelligence",
    },
    {
      "blog_type": "Science",
      "value": "Science & Technologies",
    },
    {
      "blog_type": "Marketing",
      "value": "Marketing Fundamentals",
    },
    {
      "blog_type": "Finance",
      "value": "Finance Services",
    },
  ];
}
