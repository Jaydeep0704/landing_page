
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
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
import 'edit_testimonalScreen.dart';

class UpdateTestiMonal extends StatefulWidget {
  final String id;
  final String name;
  final String companyName;
  final String position;
  final String mediatype;
  final String medialink;
  final String description;
  final String bannerfile;
  final String profilimg;
  final String bannerfiletype;
  UpdateTestiMonal({Key? key,required this.id,required this.name,required this.description,required this.position,
  required this.companyName,required this.medialink,required this.mediatype,required this.profilimg
    ,required this.bannerfiletype,required this.bannerfile}) : super(key: key);
  // EditCheckOutInfo({Key? key,required this.data}) : super(key: key);
  @override
  State<UpdateTestiMonal> createState() => _UpdateTestiMonalState();
}

class _UpdateTestiMonalState extends State<UpdateTestiMonal> {

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
  String mediatype="";
  bool banertype=false;
  bool youthubetype=false;

  TextEditingController username_controller = TextEditingController();
  TextEditingController medialink_controller = TextEditingController();
  TextEditingController companyname_controller = TextEditingController();
  TextEditingController Description_controller = TextEditingController();
  TextEditingController position_controller = TextEditingController();
  final testimonalcontroller = Get.find<EditTestimonalController>();
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
    username_controller.text=widget.name;
    mediatype=widget.mediatype;
    medialink_controller.text=widget.medialink;
    companyname_controller.text=widget.companyName;
    Description_controller.text=widget.description;
    position_controller.text=widget.position;
    videoUrl=widget.bannerfile;

    checkisVideo();
    checkMediatype();
  }


  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();

  }
  checkMediatype(){
    if(widget.mediatype=="youthtube"){
      youthubetype=true;
      banertype=false;
      mediatype="youthtube";
    }else if(widget.mediatype=="normal"){
      youthubetype=false;
      banertype=true;
      mediatype="normal";
    }
  }
  checkisVideo(){
    if(widget.bannerfiletype=="image"){
      isImage=true;
      isvideo=false;
      isGif= false;
      VideoImg="image";
    }else if(widget.bannerfiletype=="video"){
      isImage=false;
      isvideo=true;
      isGif= false;
      VideoImg="video";
    }else if(widget.bannerfiletype=="gif"){
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
            title: Text("Update Testimonal",
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
                      width: Get.width > 800 ? 500 :300,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text("Select Profile Image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                            SizedBox(height: 20,),
                            Center(
                              child: InkWell(
                                onTap: (){
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
                                    :   CachedNetworkImage(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                imageUrl: APIString.latestmediaBaseUrl + widget.profilimg,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                  ),
                                ),
                                // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                            const Text("Enter User Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: username_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter User Name",
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
                            SizedBox(height: 10,),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                            ),
                            const Text("Enter Media Type",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      'YouthTube',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    leading: Radio(
                                      activeColor: Colors.blue,
                                      value: 'youthtube',
                                      groupValue: mediatype,
                                      onChanged: (value) {
                                        setState(() {
                                          mediatype = value as String;
                                          print(value);
                                          print(mediatype);
                                          if (mediatype == 'youthtube') {
                                            youthubetype=true;
                                            banertype=false;
                                          } else {
                                            youthubetype=false;
                                            banertype=true;
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
                                      'Normal',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    leading: Radio(
                                      activeColor: Colors.blue,
                                      value: 'normal',
                                      groupValue: mediatype,
                                      onChanged: (value) {
                                        setState(() {
                                          mediatype = value as String;
                                          print("Img_video==");
                                          print(value);
                                          print(mediatype);
                                          if (mediatype == 'normal') {
                                            banertype=true;
                                            youthubetype=false;
                                          } else {

                                            banertype=false;
                                            youthubetype=true;
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
                                visible:youthubetype == true ? true : false,
                                child: const Text("Enter Media Link",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                            SizedBox(height: 10,),

                            Visibility(
                              visible:youthubetype == true ? true : false,
                              child: TextFormField(
                                controller: medialink_controller,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    const EdgeInsets.all(
                                        10),
                                    hintText: "Enter Media Link",
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
                            ),
                            SizedBox(height: 10,),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                            ),
                            const Text("Enter Company Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: companyname_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Company Name",
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
                            SizedBox(height: 10,),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                            ),
                            const Text("Enter Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: Description_controller,
                              maxLines: 10,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Description",
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
                            SizedBox(height: 10,),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                            ),
                            const Text("Enter Job Position",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: position_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Job Position",
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
                            SizedBox(height: 10,),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                            ),
                            Visibility(
                                visible:banertype == true ? true : false,
                                child: Center(child: Text("Select Banner Media type",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),))),

                            Visibility(
                              visible:banertype == true ? true : false,
                              child: Row(
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
                                        imageUrl: APIString.latestmediaBaseUrl + widget.bannerfile,
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
                                        imageUrl: APIString.latestmediaBaseUrl + widget.bannerfile,
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
                                    updateTestimonalApi();
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
    VideoPlayerController _controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+widget.bannerfile);
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

  Future updateTestimonalApi() async {

    var url=APIString.grobizBaseUrl+ APIString.edit_testimonials;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    // user_image,user_name,media_link,media_type,Description,company_name,Position,banner(file),banner_mediatype

    try {

      if (ProfilepathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'user_image',
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
      request.fields['user_image'] = '';
    } catch (exception) {
      request.fields['user_image'] = '';
      print('pic not selected');
    }

    ///for video file
    if(VideoImg=='video'){

      try {

        if (videopathsFile != null) {
          if (kIsWeb) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'banner',
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
        request.fields['banner'] = '';
      } catch (exception) {
        request.fields['banner'] = '';
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
                'banner',
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
        request.fields['banner'] = '';
      } catch (exception) {
        request.fields['banner'] = '';
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
                'banner',
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
        request.fields['banner'] = '';
      } catch (exception) {
        request.fields['banner'] = '';
        print('pic not selected');
      }
    }
    // testimonial_auto_id,user_image,user_name,media_link,media_type,
    // Description,company_name,Position,banner(file),banner_mediatype
    request.fields["testimonial_auto_id"] =widget.id;
    request.fields["user_name"] =username_controller.text;
    request.fields["media_link"] =medialink_controller.text;
    request.fields["media_type"] =mediatype;
    request.fields["Description"] =Description_controller.text;
    request.fields["company_name"] =companyname_controller.text;
    request.fields["Position"] =position_controller.text;
    request.fields["banner_mediatype"] =VideoImg;

    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {

      final resp=jsonDecode(response.body);
      print(resp.toString());
      //String message=resp['msg'];
      int status=resp['status'];
      if(status==1){
        Fluttertoast.showToast(msg: " successfully updated", backgroundColor: Colors.grey,);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditTestimonalScreenList()));

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
    if(username_controller.text.isEmpty ||username_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Name' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }else if(companyname_controller.text.isEmpty ||companyname_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Company Name' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }else if(Description_controller.text.isEmpty ||Description_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Description' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }else if(position_controller.text.isEmpty ||position_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Job Position' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }

    return true;
  }
  void pickProfile() async {

    try {
      Profilepaths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))?.files;

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
}
