// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, implementation_imports, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UpdateMediaFunction extends StatefulWidget {
  String? imageSize;
  String? keyNameMedia;
  // String? mediaType;
  String? keyMediaType;

  UpdateMediaFunction({
    Key? key,
    this.imageSize,
    this.keyNameMedia,
    this.keyMediaType,
    // this.mediaType,
  }) : super(key: key);

  @override
  State<UpdateMediaFunction> createState() => _UpdateMediaFunctionState();
}

class _UpdateMediaFunctionState extends State<UpdateMediaFunction> {
  EditController editController = Get.find<EditController>();

  List<PlatformFile>? paths;
  var pathsFile;
  var pathsFileName;

  @override
  void initState() {
    super.initState();
    editController.mediaType.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            height: 300,
            width: 400,
            decoration: const BoxDecoration(color: AppColors.whiteColor),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Select Media Type'),
                TextButton(
                  child: const Text('Pick Image From Gallery'),
                  onPressed: () async {
                    editController.mediaType.value = "image";
                    pickFiles();
                  },
                ),
                const SizedBox(height: 15),
                TextButton(
                  child: const Text('Pick Video From Gallery'),
                  onPressed: () async {
                    editController.mediaType.value = "video";
                    pickFiles();
                  },
                ),
                const SizedBox(height: 15),
                TextButton(
                  child: const Text('Pick Gif From Gallery'),
                  onPressed: () async {
                    editController.mediaType.value = "gif";
                    pickFiles();
                  },
                ),
                const SizedBox(height: 15),
                widget.imageSize == null
                    ? const SizedBox()
                    : Text("media size : height*width - ${widget.imageSize}"),
                SizedBox(height: widget.imageSize == null ? 0 : 10),
                const SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () async {
                          updateData();
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () async {
                          // updateData();
                          editController.mediaType.value = "";
                          Navigator.of(context).pop();
                        },
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickFiles() async {
    showLoadingDialog(loader: false, loadingText: true, delay: true);
    log("came from ---- ${editController.mediaType.value}");
    Navigator.of(context).pop(false);
    List<String> allowedExtensions = [];

    // Set the allowed extensions based on the selected file type
    if (editController.mediaType.value == 'image') {
      allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    } else if (editController.mediaType.value == 'video') {
      allowedExtensions = ['mp4', 'mov', 'avi'];
    } else if (editController.mediaType.value == 'gif') {
      allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    }
    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => log("status .... $status"),
        allowedExtensions: allowedExtensions,
      ))
          ?.files;
      hideLoadingDialog();
      pathsFile = paths!.first.bytes!;
      pathsFileName = paths!.first.name;
      // });
      // });

      log("_paths!.first.bytes  $pathsFile     --  ${paths!.first.bytes!}");
      log("_paths!.first.name   $pathsFileName --  ${paths!.first.name}");
      log("selected image is ----------> $paths");
      updateData();
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

  Future updateData({List<int>? file, String? fileName}) async {
    showLoadingDialog();

    var url = APIString.grobizBaseUrl + APIString.update_web_landing_page_data;

    Uri uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);

    // log("file ------> ${file.runtimeType} ${file != null} ");
    log("file1 ------> $pathsFile ${pathsFile.runtimeType} ");
    log("file2 ------> $pathsFileName ${pathsFileName.runtimeType} ");
    try {
      if (pathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              widget.keyNameMedia!.toString(),
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
      request.fields[widget.keyNameMedia!.toString()] = '';
    } catch (exception) {
      request.fields[widget.keyNameMedia!.toString()] = '';
      log('pic not selected');
    }
    request.fields["user_auto_id"] = APIString.userAutoId;
    request.fields[widget.keyMediaType.toString()] =
        editController.mediaType.value;
    // request.fields[widget.keyMediaType.toString()] = widget.mediaType.toString();

    http.Response response =
        await http.Response.fromStream(await request.send());

    log("update response$response");
    final d = jsonDecode(response.body);

    log("status for uploading ---> ${d['status']}");
    log("msg for uploading ---> ${d['msg']}");
    if (response.statusCode == 200) {
      log("inside 200 response ----");
      editController.mediaType.value = "";
      hideLoadingDialog();
      // Navigator.pop(context);
      final resp = jsonDecode(response.body);

      debugPrint(resp.toString());

      int status = resp['status'];
      log("status for uploading ---> $status");
      log("msg for uploading ---> ${resp['msg']}");
      if (status == 1) {
        log("inside status  ---- 1");
        Fluttertoast.showToast(
          msg: "Updated successfully",
          backgroundColor: Colors.grey,
        );
        await editController.getData();
        // Get.back();
      } else {
        String message = resp['msg'];
        log(message);
      }
    } else if (response.statusCode == 500) {
      //log(response.statusCode.toString());
      editController.mediaType.value = "";
      // Navigator.pop(context);
      hideLoadingDialog();
      Fluttertoast.showToast(
        msg: "Server Error",
        backgroundColor: Colors.grey,
      );
      if (mounted) {
        setState(() {});
      }
    } else {
      editController.mediaType.value = "";
      log(response.statusCode.toString());
      // Navigator.pop(context);
      hideLoadingDialog();
      Fluttertoast.showToast(
        msg: response.toString(),
        backgroundColor: Colors.grey,
      );
      if (mounted) {
        setState(() {});
      }
    }
  }
}
