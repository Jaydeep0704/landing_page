import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class EditIntroController extends GetxController {
  late VideoPlayerController introBotController;
  late VideoPlayerController introGif1Controller;
  late VideoPlayerController introGif2Controller;

  RxBool introBotSwitch = false.obs;
  RxBool introGif1Switch = false.obs;
  RxBool introGif2Switch = false.obs;
  RxBool introDescBGSwitch = false.obs;

  RxBool appCountBGSwitch = false.obs;
  RxBool webCountBGSwitch = false.obs;

  RxBool isBotVideoInitialized = false.obs;
  RxBool isIntroGif1Initialized = false.obs;
  RxBool isIntroGif2Initialized = false.obs;
}
