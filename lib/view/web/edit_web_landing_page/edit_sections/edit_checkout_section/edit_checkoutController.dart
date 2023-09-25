// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class EditCheckOutController extends GetxController{

  late VideoPlayerController checkVideoController;

  RxBool isCheckVideoInitialized = false.obs;

}