import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class EditHiwController extends GetxController{

  late VideoPlayerController botController;


  RxBool isBotVideoInitialized = false.obs;
  RxBool hiwGifShowSwitch = false.obs;
}