import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/updateTestiMonalScreen.dart';
import 'package:http_parser/src/media_type.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/widget/loading_dialog.dart';
import 'package:video_player/video_player.dart';

import '../view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import '../view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/addTestimonalScreen.dart';
import 'add_blog.dart';
import 'blog_controller.dart';
import 'blog_details_list.dart';
import 'edit_blog.dart';


class BlogDetailsScreen extends StatefulWidget {
  final String id;
  final String name;
  final String title;
  final String content;
  final String blogtype;
  final String bgColor;
  final String media;
  final String profilimg;
  final String mediatype;
  final List<Map<String, String>> blogDetails;
  const BlogDetailsScreen({Key? key,required this.id,required this.name,required this.bgColor,required this.content,
    required this.title,required this.blogtype,required this.profilimg
    ,required this.mediatype,required this.media,required this.blogDetails,}) : super(key: key);

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  final blog_controller = Get.find<EditBlogController>();
  final editController = Get.find<EditController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideo();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   blog_controller.GetBlogData();
    //   blog_controller.GetBlogDetailsData(id: widget.id);
    // });

  }
  @override
  void dispose() {
    blog_controller.videoController.pause();
    blog_controller.videoController.dispose();

    super.dispose();
  }
  void initializeVideo() async {
    blog_controller.videoController = VideoPlayerController.networkUrl(Uri.parse(APIString.mediaBaseUrl +
       widget.media));
    await blog_controller.videoController.initialize().whenComplete(() {
      blog_controller.videoController.setLooping(true);
      blog_controller.videoController.setVolume(0);
      blog_controller.isVideoInitialized.value = true;
      blog_controller.videoController.play();
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: AppColors.whiteColor,
          leading: const BackButton(
            color: AppColors.blackColor,
          ),
          title: Align(
            alignment: Alignment.topLeft,
            child: Text("Grobiz®",
                style: AppTextStyle.regularBold
                    .copyWith(color: Colors.purple, fontSize: 25)),
          ),

        ),
        body: Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              decoration:
              BoxDecoration(color: AppColors.whiteColor, boxShadow: [
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.0),
                    blurRadius: 1,
                    spreadRadius: 2)
              ]),
              width: Get.width > 800 ? 900 : 500,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap:(){

                            },
                            child: Text("Blog",
                                style:  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: AppColors.blackColor,
                                  decoration: TextDecoration.underline
                  )),
                          ),
                          SizedBox(width: 10,),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: AppColors.blackColor,
                            size: 20,
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap:(){

                            },
                            child: Text(widget.blogtype,
                                style:  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.blackColor,

                                )),
                          ),


                        ],
                      ),
                      SizedBox(height: 30,),
                      ///blog type with list
                      // Container(
                      //   height: 30,
                      //   width: Get.width,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: blog_controller.blogtype.length,
                      //     itemBuilder: (context, index) {
                      //       return   Row(
                      //         children: [
                      //           Container(
                      //               decoration: BoxDecoration(
                      //                   color: AppColors.lightBlueColor,
                      //                   border: Border.all(color: AppColors.blueColor,width: 0.8),
                      //                   borderRadius: const BorderRadius.all(Radius.circular(20))
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      //                 child: Text(blog_controller.blogtype[index],style: TextStyle(
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.w100,
                      //                   color: AppColors.blueColor,
                      //
                      //                 ),),
                      //               )),
                      //           SizedBox(width: 10,)
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                      ///blog types
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColors.lightBlueColor,
                                    border: Border.all(color: AppColors.blueColor,width: 0.8),
                                    borderRadius: const BorderRadius.all(Radius.circular(20))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                  child: Text(widget.blogtype,style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.blueColor,

                                  ),),
                                )),
                            SizedBox(width: 10,),
                            // Container(
                            //     decoration: BoxDecoration(
                            //         color: AppColors.lightBlueColor,
                            //         border: Border.all(color: AppColors.blueColor,width: 0.8),
                            //         borderRadius: const BorderRadius.all(Radius.circular(20))
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            //       child: Text("Business",style: TextStyle(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w100,
                            //         color: AppColors.blueColor,
                            //
                            //       ),),
                            //     )),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title,style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,

                            ),),
                            SizedBox(height: 10,),
                            // Text("Here are 9 definitive steps every successful app project follows…",style: TextStyle(
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.w100,
                            //   color: Colors.black,
                            //
                            // ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  child: CachedNetworkImage(
                                    imageUrl: APIString.latestmediaBaseUrl + widget.profilimg,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                    placeholder: (context, url) => Container(
                                      decoration: BoxDecoration(
                                        color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name,style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),),
                                SizedBox(width: 15,),
                                // Text("VP of Product at Builder.ai",style: TextStyle(
                                //   fontSize: 18,
                                //   fontWeight: FontWeight.w100,
                                //   color: Colors.black,
                                //
                                // ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 50.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text("20 July 2023 . ",style: TextStyle(
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black,
                      //
                      //       ),),
                      //       Text("12 minute read",style: TextStyle(
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.w100,
                      //         color: Colors.black,
                      //
                      //       ),),
                      //       // Align(
                      //       //   alignment: Alignment.topRight,
                      //       //   child: Icon(
                      //       //     Icons.facebook,
                      //       //     color: AppColors.blueColor,
                      //       //     size: 30,
                      //       //   ),
                      //       //
                      //       // ),
                      //
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Container(
                          height: 300,
                          width: Get.width,
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              child: widget.mediatype == "image" ||  widget.mediatype == "gif"
                                  ? CachedNetworkImage(
                                imageUrl: APIString.latestmediaBaseUrl + widget.media,
                                fit: BoxFit.fill,
                                height: 300,
                                width: Get.width,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(editController.appDemoBgColor.value.toString())),
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              )
                                  :buildMediaWidget(),
                            ),
                          ),
                        )

                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Flexible(
                          child: Text(widget.content,style: TextStyle(
                            fontSize: 18,
                            height: 2,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,

                          ),),
                        ),
                      ),
                      SizedBox(height: 30,),
                      ///list use here....

                      for (var detail in widget.blogDetails)
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: ListTile(
                            // leading: Text(
                            //   '.',
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            title: Flexible(
                              child: Text(
                                detail['title'] ?? '',
                                style: TextStyle(
                                  fontSize: 25,
                                  height: 2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            subtitle: Flexible(
                              child: Text(
                                detail['description'] ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w100,
                                  height: 2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 50.0),
                      //   child: RichText(
                      //     text: TextSpan(
                      //       text: '• ',
                      //       style: TextStyle(
                      //         fontSize: 50,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black,
                      //       ),
                      //       children: <TextSpan>[
                      //         TextSpan(
                      //           text: 'How to navigate the mobile app development process',
                      //           style: TextStyle(
                      //             fontSize: 30,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 25,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 50.0),
                      //   child: Flexible(
                      //     child: Text("App owners have to put the work in well before"
                      //         " the mobile app development process "
                      //         "begins to give their projects any chance of succeeding"
                      //         "That means having a solid business plan, a clear app "
                      //         "idea and a deep understanding of your audience."
                      //         "But those who have these bases covered will still encounter a minefield. How do you "
                      //         "decide who’s going to design, develop, host and "
                      //         "maintain your mobile application?"
                      //         "But those who have these bases covered will still encounter a "
                      //         "minefield. How do you decide who’s going to "
                      //         "design, develop, host and maintain your "
                      //         "mobile application?",style: TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.w100,
                      //       color: Colors.black,
                      //
                      //     ),),
                      //   ),
                      // ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }
  Widget buildMediaWidget() {
    return Obx(() {
      return blog_controller.isVideoInitialized.value
          ? AspectRatio(
        aspectRatio: blog_controller.videoController.value.aspectRatio,
        child: VideoPlayer(blog_controller.videoController),
      )
          : const Center(child: Text("no video"));
      // : const Center(child: CircularProgressIndicator());
    });
  }
}
