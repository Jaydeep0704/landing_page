import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class EditHiwController extends GetxController {
  late VideoPlayerController botController;
  late ChewieController botChewieController;

  late VideoPlayerController editBotController;
  late ChewieController editBotChewieController;

  RxBool isBotVideoInitialized = false.obs;
  RxBool isEditBotVideoInitialized = false.obs;
  RxBool hiwGifShowSwitch = false.obs;

  RxBool isVisible = false.obs;
}
