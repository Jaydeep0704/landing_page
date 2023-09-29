import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';

class TopNavBar extends StatelessWidget {
  TopNavBar({super.key, this.padding});
  EdgeInsets? padding;
  final editController = Get.find<EditController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.transparentColor,
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Go back",
                    style: AppTextStyle.regular700.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: AppColors.transparentColor,
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: CachedNetworkImage(
                    width: 50,
                    imageUrl: APIString.mediaBaseUrl +
                        editController.allDataResponse[0]["intro_details"][0]
                                ["Logo_image"]
                            .toString(),
                    placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse(
                          editController.appDemoBgColor.value.toString())),
                    )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
