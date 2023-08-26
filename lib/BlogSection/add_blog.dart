
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
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
import 'BlogListScreen.dart';



class add_Blog extends StatefulWidget {
  add_Blog({Key? key}) : super(key: key);
  @override
  State<add_Blog> createState() => _add_BlogState();
}

class _add_BlogState extends State<add_Blog> {

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

  ///for Profile image file
  List<PlatformFile>? Profilepaths;
  var ProfilepathsFile;
  var profilepathsFileName;
  Uint8List? pimageData;
  TextEditingController username_controller = TextEditingController();
  TextEditingController title_controller = TextEditingController();
  TextEditingController content_controller = TextEditingController();
  TextEditingController blogType_controller = TextEditingController();
  TextEditingController blogBg_controller = TextEditingController();

  final testimonalcontroller = Get.find<EditTestimonalController>();
  bool isApiProcessing = false;
  String VideoImg="";
  bool isvideo=false;
  bool isImage=false;
  bool isGif=false;

  VideoPlayerController? _controller;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Add New Blog",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          //blogTypeKey,media,media_type,blogs_section_color
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
                                      : Center(child:  Icon(
                                    Icons.photo_library,
                                    size: 50,
                                    color: Colors.grey,
                                  )),
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
                            const Text("Enter Title",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: title_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Title",
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
                            const Text("Enter Content",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: content_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Content",
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
                            const Text("Enter Blog Type",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: blogType_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Blog Type",
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
                            const Text("Enter Blog Section Color",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),

                            TextFormField(
                              controller: blogBg_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Blog Section Color",
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
                            Center(child: Text("Select Media type",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                            SizedBox(height: 20,),
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
                                          : Center(child:  Icon(
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

                                      if (controller != null && controller.value.isInitialized)
                                        AspectRatio(
                                          // aspectRatio: controller.value.aspectRatio,
                                          aspectRatio: 1 / 0.3,
                                          child: VideoPlayer(controller),
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
                                          : Center(child:  Icon(
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
                                    add_blog();
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
                                    "Add",
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



  Future add_blog() async {

    var url=APIString.grobizBaseUrl+ APIString.add_blog;

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);
    // title,content,blogTypeKey,media,media_type,userImage,userName,blogs_section_color
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
      print('pic not selected');
    }

    ///for video file
    if(VideoImg=='video'){

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
    if(VideoImg=='image'){
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

    if(VideoImg=='gif'){
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
    //title,content,blogTypeKey,media,media_type,userImage,userName,blogs_section_color
    request.fields["userName"] =username_controller.text;
    request.fields["content"] =content_controller.text;
    request.fields["title"] =title_controller.text;
    request.fields["blogs_section_color"] =blogBg_controller.text;
    request.fields["blogTypeKey"] =blogType_controller.text;
    request.fields["media_type"] =VideoImg;

    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {

      final resp=jsonDecode(response.body);
      print(resp.toString());
      //String message=resp['msg'];
      int status=resp['status'];
      if(status==1){
        Fluttertoast.showToast(msg: " successfully Added", backgroundColor: Colors.grey,);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BlogListScreen()));


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

  bool validation(){
    if(username_controller.text.isEmpty ||username_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Name' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }
    else if(title_controller.text.isEmpty ||title_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter title' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }else if(content_controller.text.isEmpty ||content_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Content' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }else if(blogType_controller.text.isEmpty ||blogType_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Blog Type' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }else if(blogBg_controller.text.isEmpty ||blogBg_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Color' ,
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
