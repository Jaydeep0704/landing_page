// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoController extends GetxController {
//   final videoUrls = [
//     'https://grobiz.app/GrobizEcommerceSuperAdminTest/images/Web/new_vid.mp4',
//     'https://grobiz.app/GrobizEcommerceSuperAdminTest/images/Web/new_vid.mp4',
//     'https://grobiz.app/GrobizEcommerceSuperAdminTest/images/Web/VID-20230620-WA0001.mp4',
//     'https://grobiz.app/GrobizEcommerceSuperAdminTest/images/Web/VID-20230620-WA0001.mp4',
//   ];
//
//   List<VideoPlayerController> controllers = [];
//
//   @override
//   void onInit() {
//     super.onInit();
//     initializeControllers();
//   }
//
//   void initializeControllers() {
//     for (String url in videoUrls) {
//       final controller = VideoPlayerController.networkUrl(Uri.parse(url));
//       controller.initialize().then((_) {
//         controller.setLooping(true);
//         controller.setVolume(0);
//         controller.play();
//       });
//       controllers.add(controller);
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }
