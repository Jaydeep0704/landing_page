import 'package:cached_network_image/cached_network_image.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'add_new_blog.dart';
import 'blog_controller.dart';
import 'blog_details_list.dart';
import 'edit_blog.dart';


class BlogListScreen extends StatefulWidget {
  const BlogListScreen({Key? key}) : super(key: key);

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final blogController = Get.find<EditBlogController>();
  final editController = Get.find<EditController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      blogController.getBlogData();
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
          title: Text("Edit Blog",
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
                            MaterialPageRoute(builder: (context) => AddBlog())).whenComplete(() =>  WidgetsBinding.instance.addPostFrameCallback((_){
                          blogController.getBlogData();
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
                              Text("Add New Blog")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Obx(() {
                      if (blogController.blogdata.isNotEmpty) {
                        return SizedBox(
                            height: Get.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:
                              blogController.blogdata.length,
                              itemBuilder: (context, index) {
                                var data =
                                blogController.blogdata[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => EditBlog(
                                                      id: data["blog_auto_id"].toString(),
                                                      name: data["userName"].toString(),
                                                      media: data["media"].toString(),
                                                      mediatype: data["media_type"].toString(),
                                                      bgColor: data["blogs_section_color"].toString(),
                                                      content: data["content"].toString(),
                                                      blogtype: data["blogTypeKey"].toString(),
                                                      title: data["title"].toString(),
                                                      profilimg: data["userImage"].toString(),
                                                    ),
                                                  ),
                                                ).whenComplete(() => WidgetsBinding.instance.addPostFrameCallback((_){
                                                  blogController.getBlogData();
                                                }));
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: IconButton(
                                              onPressed: () {
                                                blogController.deleteBlogApi(id: data["blog_auto_id"].toString());
                                              },
                                              icon: const Icon(Icons.delete_forever),
                                            ),
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
                                        data["content"].toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                child: CachedNetworkImage(
                                                  imageUrl: APIString.latestmediaBaseUrl + data["userImage"].toString(),
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
                                          const SizedBox(width: 10),
                                          Text(
                                            data["userName"].toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w100,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => BlogDetailsList(id: data["blog_auto_id"].toString()),
                                              ),
                                            ).whenComplete(() => WidgetsBinding.instance.addPostFrameCallback((_){
                                              blogController.getBlogData();
                                            }));
                                          },
                                          child: const Text(
                                            "Edit Blog Details...",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
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
  Widget displayUploadedVideo(String videoUrl) {
    VideoPlayerController _controller = VideoPlayerController.network(APIString.latestmediaBaseUrl+videoUrl);
    bool isVideoPlaying = false;

    final double videoAspectRatio = /*_controller.value.aspectRatio > 0 ? _controller.value.aspectRatio :*/ 16 / 9;

    return InkWell(
      onTap: () {
        if (_controller.value.isPlaying) {
          isVideoPlaying=false;
          _controller.pause();
        } else {
          _controller.play();
          isVideoPlaying=true;
        }
        // isVideoPlaying = !isVideoPlaying;
      },
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                //aspectRatio: 16/9,
                // aspectRatio: 1 / 6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    if (!isVideoPlaying)
                      Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white.withOpacity(0.7),
                      ),
                  ],
                ));
            // );

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
}
