import 'dart:developer';

import 'package:adya_poc/video_two/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../feel_dialog.dart';
import '../loading_dialog.dart';
import '../nav_key.dart';

// Future<void> listenerOne(
//     VideoPlayerController controllerOne,
//     // VideoPlayerController controllerTwo,
//     // VideoPlayerController controllerThree,
//     BuildContext context,
//     VideoProvider videoProvider) async {
//   // controllerOne.addListener(() async {
//   videoProvider.setCurrentPosition(controllerOne.value.position.inSeconds);

//   if (controllerOne.value.position >= const Duration(seconds: 9) &&
//       videoProvider.showFeelDialog &&
//       videoProvider.choice == Choice.undefined) {
//     videoProvider.setShowFeelDialogTo(false);
//     controllerOne.pause();
//     // hideControls = true;
//     () async {
//       showDialog(
//         // context: navigatorKey.currentContext!,
//         context: context,
//         builder: (context) {
//           return FeelDialog(
//             onHappy: () {
//               videoProvider.setChoice(Choice.happy);
//               videoProvider.setTotalDuration(const Duration(seconds: 34));
//               // context.read<VideoPageProvider>().hideControls = false;
//               controllerOne.play();
//               // context.read<VideoPageProvider>().listen(context);
//               Navigator.pop(context);
//             },
//             onSad: () {
//               videoProvider.setChoice(Choice.sad);
//               videoProvider.setTotalDuration(const Duration(seconds: 27));
//               // context.read<VideoPageProvider>().hideControls = false;
//               controllerOne.play();
//               // context.read<VideoPageProvider>().listen(context);
//               Navigator.pop(context);
//             },
//           );
//         },
//       );
//     }();
//   }

//   if (controllerOne.value.position == controllerOne.value.duration &&
//       videoProvider.currentVideoIndex == 0) {
//     log("Video-Completed~~~~~~~~");
//     switch (videoProvider.choice) {
//       case Choice.undefined:
//         videoProvider.setCurrentVideoIndex(0);
//         videoProvider.setTotalDuration(Duration(seconds: 18));

//         break;
//       case Choice.happy:
//         videoProvider.setCurrentVideoIndex(1);
//         break;
//       case Choice.sad:
//         videoProvider.setCurrentVideoIndex(2);
//         break;
//     }
//     if (videoProvider.currentVideoIndex == 0) {
//       controllerOne = VideoPlayerController.asset('lib/assets/clip_1.mp4');
//     } else if (videoProvider.currentVideoIndex == 1) {
//       controllerOne = VideoPlayerController.asset('lib/assets/clip_2.mp4');
//       // setState();
//     } else if (videoProvider.currentVideoIndex == 2) {
//       controllerOne = VideoPlayerController.asset('lib/assets/clip_3.mp4');
//       // setState();
//     }
//     await controllerOne.initialize();
//     await controllerOne.play();
//   }
//   // });
// }

// Future<void> listenerOne(
//   VideoPlayerController controllerOne,
//   // VideoPlayerController controllerTwo,
//   // VideoPlayerController controllerThree,
//   BuildContext context,
//   VideoProvider videoProvider, {
//   required VoidCallback setState,
// }) async {
//   controllerOne.addListener(() async {
//     log("---pos---${controllerOne.value.position}---curPos---${videoProvider.currentPosition}");
//     videoProvider.setCurrentPosition(controllerOne.value.position.inSeconds);
//     await Future.delayed(const Duration(milliseconds: 400));
//     if (videoProvider.currentVideoIndex == 0 &&
//         videoProvider.currentPosition >= const Duration(seconds: 9) &&
//         videoProvider.showFeelDialog) {
//       log("---curPosIf---${videoProvider.currentPosition}");
//       videoProvider.setShowFeelDialogTo(false);
//       controllerOne.pause();
//       showDialog(
//         context: navigatorKey.currentContext!,
//         barrierDismissible: false,
//         builder: (ctx) {
//           return FeelDialog(
//             onHappy: () {
//               // videoProvider.setTotalDuration(const Duration(seconds: 34));
//               Navigator.pop(context);
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   Future.delayed(const Duration(seconds: 2), () {
//                     videoProvider.setChoice(Choice.happy);
//                     Navigator.pop(context);
//                     controllerOne.play();
//                     // controllerOne.seekTo(position)
//                     // controllerTwo.play();
//                   });
//                   return const LoadingDialog();
//                 },
//               );

//               Future.delayed(const Duration(milliseconds: 50), () {
//                 videoProvider.setTotalDuration(const Duration(seconds: 34));
//                 // videoProvider.setCurrentVideoIndex(1);
//               });
//             },
//             onSad: () {
//               // videoProvider.setTotalDuration(const Duration(seconds: 27));
//               Navigator.pop(context);

//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   Future.delayed(const Duration(seconds: 2), () {
//                     videoProvider.setChoice(Choice.sad);
//                     Navigator.pop(context);
//                     controllerOne.play();
//                   });
//                   return const LoadingDialog();
//                 },
//               );

//               Future.delayed(const Duration(milliseconds: 50), () {
//                 videoProvider.setTotalDuration(const Duration(seconds: 27));
//                 // videoProvider.setCurrentVideoIndex(1);
//               });
//             },
//           );
//         },
//       );
//     }
//     if (videoProvider.currentVideoIndex == 0 &&
//         videoProvider.currentPosition >= const Duration(seconds: 18)) {
//       if (videoProvider.choice == Choice.happy) {
//         // controllerOne.pause();
//         videoProvider.setCurrentVideoIndex(1);
//         // controllerOne.seekTo(Duration.zero);
//         controllerOne = VideoPlayerController.asset('lib/assets/clip_2.mp4');
//         setState();
//         await controllerOne.initialize();
//         await controllerOne.play();
//         // controllerTwo.play();
//       }
//       if (videoProvider.choice == Choice.sad) {
//         controllerOne.pause();
//         videoProvider.setCurrentVideoIndex(2);
//         controllerOne = VideoPlayerController.asset('lib/assets/clip_3.mp4');
//         setState();
//         await controllerOne.initialize();
//         await controllerOne.play();
//       }
//     }

//     if (videoProvider.currentVideoIndex != 0 &&
//         videoProvider.currentPosition >= videoProvider.totalDuration) {
//       showDialog(
//         context: navigatorKey.currentContext!,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Play Again ?"),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     videoProvider.resetParameters();
//                     Navigator.pop(context);
//                     controllerOne.play();
//                   },
//                   child: const Text("Yes")),
//             ],
//           );
//         },
//       );
//     }
//   });
// }

// Future<void> listenerTwo(
//   VideoPlayerController controllerOne,
//   VideoPlayerController controllerTwo,
//   VideoPlayerController controllerThree,
//   BuildContext context,
//   VideoProvider videoProvider,
// ) async {
//   controllerTwo.addListener(() async {
//     if (videoProvider.currentVideoIndex == 1) {
//       videoProvider.setCurrentPosition(controllerTwo.value.position.inSeconds);
//     }
//     await Future.delayed(const Duration(milliseconds: 400));
//     if (videoProvider.currentVideoIndex != 0 &&
//         videoProvider.currentPosition >= videoProvider.totalDuration &&
//         videoProvider.showReplayDialog) {
//       videoProvider.setShowReplayDialogTo(false);
//       showDialog(
//         context: navigatorKey.currentContext!,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Play Again ?"),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     controllerTwo.seekTo(Duration.zero);
//                     videoProvider.resetParameters();

//                     Navigator.pop(context);
//                     controllerOne.play();
//                   },
//                   child: const Text("Yes")),
//             ],
//           );
//         },
//       );
//     }
//   });
// }

// Future<void> listenerThree(
//   VideoPlayerController controllerOne,
//   VideoPlayerController controllerTwo,
//   VideoPlayerController controllerThree,
//   BuildContext context,
//   VideoProvider videoProvider,
// ) async {
//   controllerThree.addListener(() async {
//     log("message");
//     if (videoProvider.currentVideoIndex == 2) {
//       videoProvider
//           .setCurrentPosition(controllerThree.value.position.inSeconds);
//     }
//     await Future.delayed(const Duration(milliseconds: 400));
//     if (videoProvider.currentVideoIndex != 0 &&
//         videoProvider.currentPosition >= videoProvider.totalDuration &&
//         videoProvider.showReplayDialog) {
//       videoProvider.setShowReplayDialogTo(false);
//       showDialog(
//         context: navigatorKey.currentContext!,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Play Again ?"),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     controllerThree.seekTo(Duration.zero);
//                     videoProvider.resetParameters();
//                     Navigator.pop(context);
//                     controllerOne.play();
//                   },
//                   child: const Text("Yes")),
//             ],
//           );
//         },
//       );
//     }
//   });
// }
