import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;


class EditCheckOutController extends GetxController{

  late VideoPlayerController checkvideoController;

  RxBool ischeckVideoInitialized = false.obs;

}