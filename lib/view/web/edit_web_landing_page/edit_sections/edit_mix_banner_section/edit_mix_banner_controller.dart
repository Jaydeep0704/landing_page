import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MixBannerController extends GetxController{

  late VideoPlayerController videoController;

  RxBool isVideoInitialized = false.obs;
  RxBool mixBannerFileShowSwitch = false.obs;
}