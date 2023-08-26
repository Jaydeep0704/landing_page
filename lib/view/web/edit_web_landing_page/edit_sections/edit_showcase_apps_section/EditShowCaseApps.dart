
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/showcase_app_controller.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:chewie/chewie.dart';
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
import '../../../edit_web_landing_page/edit_controller/edit_controller.dart';

class EditShowCaseApps extends StatefulWidget {
  final String id;
  final String title;

  final String fileData;
  final String filetype;
  EditShowCaseApps({Key? key,required this.id,required this.title
    ,required this.filetype,required this.fileData}) : super(key: key);
  // EditCheckOutInfo({Key? key,required this.data}) : super(key: key);
  @override
  State<EditShowCaseApps> createState() => _EditShowCaseAppsState();
}

class _EditShowCaseAppsState extends State<EditShowCaseApps> {

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

  TextEditingController project_tile_controller = TextEditingController();
  final showCaseappscontroller = Get.find<ShowCaseAppsController>();
  final editController = Get.find<EditController>();
  bool isApiProcessing = false;
  String VideoImg="";
  bool isvideo=false;
  bool isImage=false;
  bool isGif=false;
  String videoUrl="";



  @override
  void initState() {
    super.initState();
    project_tile_controller.text=widget.title;
    videoUrl=widget.fileData;

    checkisVideo();
  }


  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();

  }

  checkisVideo(){
    if(widget.filetype=="image"){
      isImage=true;
      isvideo=false;
      isGif= false;
      VideoImg="image";
    }else if(widget.filetype=="video"){
      isImage=false;
      isvideo=true;
      isGif= false;
      VideoImg="video";
    }else if(widget.filetype=="gif"){
      isImage=false;
      isvideo=false;
      isGif= true;
      VideoImg="gif";
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
            title: Text("Update Show Case Apps",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Row(
                  children:[
                    Expanded(
                        child:
                        SizedBox()
                    ),
                    SizedBox(
                      width: Get.width > 800 ? 700 :400,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text("Select Image , Video or Gif  for upload",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                            SizedBox(height: 10,),
                            Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
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
                                          print(value);
                                          print(VideoImg);
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
                                    title: Text(
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
                                          print("Img_video==");
                                          print(value);
                                          print(VideoImg);
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
                                    title: Text(
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
                                          print("Img_gif==");
                                          print(value);
                                          print(VideoImg);
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
                            SizedBox(height: 10,),
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
                                          :   CachedNetworkImage(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width,
                                        imageUrl: APIString.latestmediaBaseUrl + widget.fileData,
                                        placeholder: (context, url) => Container(
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                          ),
                                        ),
                                        // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
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
                                Column(
                                  children: [

                                    videoData != null
                                        ? (controller != null && controller.value.isInitialized)
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
                                        fit: BoxFit.contain,
                                      )
                                          :   CachedNetworkImage(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width,
                                        imageUrl: APIString.latestmediaBaseUrl + widget.fileData,
                                        placeholder: (context, url) => Container(
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                          ),
                                        ),
                                        // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
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
                            SizedBox(height: 20,),

                            SizedBox(height: 20,),
                            const Text("Enter Title",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),

                            SizedBox(height: 10,),

                            TextFormField(
                              controller: project_tile_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter  Title",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  )
                              ),
                            ),

                            SizedBox(height: 20,),






                            Container(
                              padding: EdgeInsets.all(16),
                              color: Colors.white,
                              child: isApiProcessing == true
                                  ? Container(
                                height: 60,
                                alignment: Alignment.center,
                                width: 80,
                                child: const GFLoader(type: GFLoaderType.circle),
                              )
                                  : InkWell(
                                onTap: () async {
                                  if(validation()==true){
                                    Edit_ShowCaset_Api();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueAccent,
                                  ),
                                  height: 40,
                                  padding: EdgeInsets.all(4),
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
                          ]
                      ),
                    ),
                    Expanded(
                        child:
                        SizedBox()
                    ),
                  ]

              ),
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

    try {
      videopaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['mp4', 'mov', 'avi'],
      ))?.files;
      videopathsFile = videopaths!.first.bytes!;
      videopathsFileName = videopaths!.first.name;
      setState(() {
        videoData=videopathsFile;
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
    VideoPlayerController _controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+widget.fileData);
    bool isVideoPlaying = false;

    return GestureDetector(
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
        isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
              aspectRatio: 1 / 0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
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

  Future Edit_ShowCaset_Api() async {

    var url=APIString.grobizBaseUrl+ APIString.edit_userlist;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    // userlist_auto_id,files,file_mediatype, title
    ///for video file
    if(VideoImg=='video'){

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
            showSnackbar(title: "", message: "Not Allowed");
          }
        }
        request.fields['files'] = '';
      } catch (exception) {
        request.fields['files'] = '';
        print('pic not selected');
      }

    }
    ///for Images file
    if(VideoImg=='image'){
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
            showSnackbar(title: "", message: "Not Allowed");
          }
        }
        request.fields['files'] = '';
      } catch (exception) {
        request.fields['files'] = '';
        print('pic not selected');
      }

    }

    ///for Gif file

    if(VideoImg=='gif'){
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
            showSnackbar(title: "", message: "Not Allowed");
          }
        }
        request.fields['files'] = '';
      } catch (exception) {
        request.fields['files'] = '';
        print('pic not selected');
      }
    }
    // userlist_auto_id,files,file_mediatype, title
    request.fields["userlist_auto_id"] =widget.id;
    request.fields["title"] =project_tile_controller.text;
    request.fields["file_mediatype"] =VideoImg;

    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {

      final resp=jsonDecode(response.body);
      print(resp.toString());
      //String message=resp['msg'];
      int status=resp['status'];
      if(status==1){
        Fluttertoast.showToast(msg: "successfully Updated", backgroundColor: Colors.grey,);
        showCaseappscontroller.getShowCaseApi();

      }
      else{
        Fluttertoast.showToast(msg: "Something went wrong.Please try later", backgroundColor: Colors.grey,);
      }
    }
    else if(response.statusCode==500){

      Fluttertoast.showToast(msg: "Server Error", backgroundColor: Colors.grey,);
    }
  }

  void pickImageFiles() async {

    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))?.files;

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
      ))?.files;

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
//
//   try {
//     videopaths = (await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowMultiple: false,
//       onFileLoading: (FilePickerStatus status) =>
//           print("status .... $status"),
//       allowedExtensions: ['mp4', 'mov', 'avi'],
//     ))?.files;
//
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

  bool validation(){
    if(project_tile_controller.text.isEmpty ||project_tile_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Project Title' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }
    else if(VideoImg.isEmpty ||VideoImg=="" ){
      Fluttertoast.showToast(
        msg:  'Please Select type' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
  }

}
