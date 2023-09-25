import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';

import 'package:video_player/video_player.dart';

import 'AddProjectModel.dart';
import 'Edit_latest_project.dart';
import 'add_Project_controller.dart';

class ProjectList extends StatefulWidget {
  final GetProjectData data;
  final int index;
  ProjectList({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final get_latest_project = Get.find<AddProjectController>();
  final editController = Get.find<EditController>();
  bool isvideo = false;
  bool isimage = false;
  String Urluploadvideo = '';
  int total_like = 0;
  bool isImageShown = false;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero,() {
    //   checkisVideo();
    //
    //   // get_latest_project.getProjectData().then((value) {
    //   //   checkisVideo();
    //   // });
    // },);
  }

  ///is video or image
  checkisVideo() {
    if (widget.data.appMediaFileType == "image" ||
        widget.data.appMediaFileType == "gif") {
      isvideo = false;
      isimage = true;
    } else if (widget.data.appMediaFileType == "video") {
      isvideo = true;
      isimage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        SizedBox(
          width: Get.width > 800 ? 700 : 400,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 350,
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(
                          widget.data.appName,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ))),
                    widget.data.appMediaFileType == "video"
                        ?
                        // displayUploadedVideo()
                        Expanded(
                            flex: 4,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: CachedNetworkImage(
                                imageUrl: APIString.bannerMediaUrl +
                                    widget.data.videoThumbnail,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : Expanded(
                            flex: 4,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: CachedNetworkImage(
                                imageUrl: APIString.bannerMediaUrl +
                                    widget.data.appMediaFile,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                    ///for app description
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(
                          widget.data.appShortDescription,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ))),

                    ///update and delete project
                    Expanded(
                        child: Container(
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProjects(
                                            data: widget.data,
                                          ))).whenComplete(() {
                                get_latest_project.getProjectData();
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.edit),
                                      SizedBox(width: 3),
                                      Text("Edit")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDeleteConfirmationDialog(
                                  context, widget.data.id);
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.delete),
                                      SizedBox(width: 3),
                                      Text("Delete")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  ///post video

  Widget displayUploadedVideo() {
    VideoPlayerController _controller = VideoPlayerController.network(
        APIString.bannerMediaUrl + widget.data.appMediaFile);
    bool isVideoPlaying = false;
    setState(() {
      isImageShown = true;
    });
    return SizedBox(
      height: 220,
      child: GestureDetector(
        onTap: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
          isVideoPlaying = !isVideoPlaying;
          // setState(() {});
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
                    // if (!isVideoPlaying)
                    //   Icon(
                    //     Icons.play_circle_fill,
                    //     size: 80,
                    //     color: Colors.white.withOpacity(0.7),
                    //   ),
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
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String p_id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this Campaign?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                get_latest_project.deleteProjectApi(project_id: p_id);
                // get_latest_project.getProjectList.removeWhere((item) => item.id == p_id);
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
