// ignore_for_file: must_be_immutable, implementation_imports, depend_on_referenced_packages, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
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

class ImgPickDialog extends StatefulWidget {
  String? imageSize;
  String? keyNameImg;
  String? switchKeyNameImg;
  String? switchKeyNameClr;
  ImgPickDialog({
    Key? key,
    this.imageSize,
    this.keyNameImg,
    this.switchKeyNameImg,
    this.switchKeyNameClr,
  }) : super(key: key);

  @override
  State<ImgPickDialog> createState() => _ImgPickDialogState();
}

class _ImgPickDialogState extends State<ImgPickDialog> {
  EditController editController = Get.find<EditController>();

  List<PlatformFile>? paths;
  var pathsFile;
  var pathsFileName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick an Image'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.imageSize == null
                ? const SizedBox()
                : Text("media size  : height* width - ${widget.imageSize}"),
            SizedBox(height: widget.imageSize == null ? 0 : 10),
            TextButton(
              child: const Text('Pick Image From Gallery'),
              onPressed: () async {
                pickFiles();
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(children: [
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              updateData();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Back'),
            onPressed: () async {
              // updateData();
              Navigator.of(context).pop();
            },
          ),
        ])
      ],
    );
  }

  void pickFiles() async {
    Navigator.of(context).pop(false);
    showLoadingDialog(loader: false, loadingText: true, delay: true);

    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => log("status .... $status"),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   setState(() {
      hideLoadingDialog();
      pathsFile = paths!.first.bytes!;
      pathsFileName = paths!.first.name;
      // });
      // });

      log("_paths!.first.bytes  $pathsFile --  ${paths!.first.bytes!}");
      log("_paths!.first.name  $pathsFileName --  ${paths!.first.name}");
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

    log("file ------> ${file.runtimeType} ${file != null} ");
    log("file1 ------> $pathsFile ${pathsFile.runtimeType} ");
    log("file2 ------> $pathsFileName ${pathsFileName.runtimeType} ");
    try {
      if (pathsFile != null) {
        if (kIsWeb) {
          request.files.add(
            http.MultipartFile.fromBytes(
              widget.keyNameImg!.toString(),
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
      request.fields[widget.keyNameImg!.toString()] = '';
    } catch (exception) {
      request.fields[widget.keyNameImg!.toString()] = '';
      log('pic not selected');
    }
    request.fields["user_auto_id"] = APIString.userAutoId;
    if (widget.switchKeyNameImg.toString().isNotEmpty) {
      request.fields[widget.switchKeyNameImg.toString()] = "1";
    }
    if (widget.switchKeyNameClr.toString().isNotEmpty) {
      request.fields[widget.switchKeyNameClr.toString()] = "0";
    }

    debugPrint(request.fields.toString());

    http.Response response =
        await http.Response.fromStream(await request.send());

    log("updateData bg image response   $response");
    log("response.statusCode   ---- ${response.statusCode}");
    hideLoadingDialog();
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      // editController.getData();
      final resp = jsonDecode(response.body);

      log("bg image resp  ---- ${resp.toString()}");

      int status = resp['status'];
      if (status == 1) {
        log("bg updated successfully ................  ");
        // editController.getData();
        Fluttertoast.showToast(
          msg: "Updated successfully",
          backgroundColor: Colors.grey,
        );
        editController.getData();
        Get.back();
        Get.back();
      } else {
        String message = resp['msg'];
        editController.getData();
        Get.back();
        Get.back();
        log(message);
      }
    } else if (response.statusCode == 500) {
      //log(response.statusCode.toString());

      editController.getData();
      Fluttertoast.showToast(
        msg: "Server Error",
        backgroundColor: Colors.grey,
      );
      Get.back();
      Get.back();
      if (mounted) {
        setState(() {});
      }
    } else {
      log(response.statusCode.toString());

      editController.getData();
      hideLoadingDialog();
      Fluttertoast.showToast(
        msg: response.toString(),
        backgroundColor: Colors.grey,
      );
      Get.back();
      Get.back();
      if (mounted) {
        setState(() {});
      }
    }
  }
}
