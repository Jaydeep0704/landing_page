import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
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

import 'add_new_blog.dart';
import 'add_blog_details.dart';
import 'blog_controller.dart';
import 'edit_blog.dart';
import 'edit_blog_details.dart';


class BlogDetailsList extends StatefulWidget {
  final String id;
  const BlogDetailsList({Key? key,required this.id}) : super(key: key);
  @override
  State<BlogDetailsList> createState() => _BlogDetailsListState();
}

class _BlogDetailsListState extends State<BlogDetailsList> {
  final blogController = Get.find<EditBlogController>();
  final editController = Get.find<EditController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      blogController.getBlogDetailsData(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: const BackButton(
            color: AppColors.blackColor,
          ),
          title: Text("Edit Blog Details",
              style: AppTextStyle.regularBold
                  .copyWith(color: AppColors.blackColor, fontSize: 18)),
          centerTitle: true,
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
              width: Get.width > 800 ? 700 : 400,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddBlogDetail(id: widget.id,))).whenComplete(() =>
                            WidgetsBinding.instance.addPostFrameCallback((_){
                          blogController.getBlogDetailsData(id: widget.id);
                        }));
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: AppColors.greyColor.withOpacity(0.5),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: const [
                              Icon(Icons.add),
                              SizedBox(width: 3),
                              Text("Add Blog Details")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Obx(() {
                      if (blogController.blogDetails.isNotEmpty) {
                        return SizedBox(
                            height: Get.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:
                              blogController.blogDetails.length,
                              itemBuilder: (context, index) {
                                var data =
                                blogController.blogDetails[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EditBlogDetails(
                                                    blog_id: widget.id,
                                                    data: data,
                                                  ),
                                                ),
                                              ).whenComplete(() =>
                                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                                    blogController.getBlogDetailsData(id: widget.id);
                                                  }));
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              blogController.deleteBlogDetails(
                                                id: data["blog_auto_id"].toString(),
                                                detailsId: data["_id"].toString(),
                                              );
                                            },
                                            icon: const Icon(Icons.delete_forever),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          data["title"].toString(),
                                          style: AppTextStyle.regularBold.copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Text(
                                        data["description"].toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.blackColor,
                                        ),
                                      ),

                                      Divider(
                                        thickness: 0.8,
                                        color: AppColors.blackColor.withOpacity(0.5),
                                      ),
                                    ],
                                  ),


                                );
                              },
                            ));
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              'No Data ..',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }

}
