import 'package:adya_poc/video_two/anim_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../feel_dialog.dart';

enum Choice { happy, sad, undefined }

class VideoProvider extends ChangeNotifier {
  Duration totalDuration = const Duration(seconds: 18);
  Duration? currentPosition = Duration.zero;

  int currentVideoIndex = 0;
  Choice choice = Choice.undefined;
  VideoPlayerController vc =
      VideoPlayerController.asset("lib/assets/clip_1.mp4");
  bool showFeelDialog = true;
  bool showReplayDialog = true;
  bool hideBar = false;
  Future<void> init() async {
    vc = VideoPlayerController.asset("lib/assets/clip_1.mp4");
    // notifyListeners();
    await vc.initialize();
    await vc.play();
    notifyListeners();
  }

  void listen(BuildContext context) {
    vc.addListener(() async {
      currentPosition = await vc.position;

      if (vc.value.position >= const Duration(seconds: 9) &&
          showFeelDialog &&
          choice == Choice.undefined) {
        setShowFeelDialogTo(false);
        vc.pause();
        hideBar = true;
        notifyListeners();
        () async {
          showDialog(
            // context: navigatorKey.currentContext!,
            context: context,
            builder: (context) {
              return FeelDialog(
                onHappy: () {
                  setChoice(Choice.happy);
                  setTotalDuration(const Duration(seconds: 34));
                  vc.play();
                  hideBar = false;
                  notifyListeners();
                  Navigator.pop(context);
                },
                onSad: () {
                  setChoice(Choice.sad);
                  setTotalDuration(const Duration(seconds: 27));
                  vc.play();
                  hideBar = false;
                  notifyListeners();
                  Navigator.pop(context);
                },
              );
            },
          );
        }();
      }

      if (vc.value.position == vc.value.duration && currentVideoIndex == 0) {
        switch (choice) {
          case Choice.undefined:
            setCurrentVideoIndex(0);
            setTotalDuration(const Duration(seconds: 18));

            break;
          case Choice.happy:
            setCurrentVideoIndex(1);
            break;
          case Choice.sad:
            setCurrentVideoIndex(2);
            break;
        }
        if (currentVideoIndex == 0) {
          vc = VideoPlayerController.asset('lib/assets/clip_1.mp4');
          notifyListeners();
        } else if (currentVideoIndex == 1) {
          vc = VideoPlayerController.asset('lib/assets/clip_2.mp4');
          // setState(() {});
          // onSet(vc);
          notifyListeners();
        } else if (currentVideoIndex == 2) {
          vc = VideoPlayerController.asset('lib/assets/clip_3.mp4');
          // setState(() {});
          // onSet(vc);
          notifyListeners();
        }
        await vc.initialize();
        await vc.play();
        // notifyListeners();
      }
    });
  }

  // void setCurrentPosition(int v) {
  //   currentPosition = Duration(seconds: v);
  //   notifyListeners();
  // }

  void setChoice(Choice c) {
    choice = c;
    notifyListeners();
  }

  void setCurrentVideoIndex(int v) {
    currentVideoIndex = v;
    notifyListeners();
  }

  void setShowFeelDialogTo(bool b) {
    showFeelDialog = b;
    notifyListeners();
  }

  // void setShowReplayDialogTo(bool b) {
  //   showReplayDialog = b;
  //   notifyListeners();
  // }

  void setTotalDuration(Duration d) {
    totalDuration = d;
    notifyListeners();
  }

  void setVc(VideoPlayerController c) {
    vc = c;
    notifyListeners();
  }

  void resetParameters(BuildContext context) {
    showFeelDialog = true;
    totalDuration = const Duration(seconds: 18);
    currentPosition = Duration.zero;
    currentVideoIndex = 0;
    choice = Choice.undefined;
    showReplayDialog = true;
    vc = VideoPlayerController.asset("lib/assets/clip_1.mp4");
    () async {
      await vc.initialize();
      await vc.play();
      vc.seekTo(Duration.zero);
    }();
    listen(context);
    notifyListeners();
  }

  void resetChoice() {
    totalDuration = const Duration(seconds: 18);
    // currentVideoIndex = 0;
    choice = Choice.undefined;
    showFeelDialog = true;
    // currentPosition = Duration(seconds: v.toInt());
    // showReplayDialog = true;
    notifyListeners();
  }

  Duration setPosition(double val) {
    if (currentVideoIndex != 0) {
      int seconds = val.toInt() - 18;
      currentPosition = Duration(seconds: seconds);
    } else {
      // if (val < 18) {
      //   currentPosition = Duration(seconds: val.toInt() - 18);
      // } else {
      currentPosition = Duration(seconds: val.toInt());
      // }
    }
    notifyListeners();

    return currentPosition!;
  }

  Duration getPosition(BuildContext context, VideoPlayerController c) {
    c.addListener(() async {
      currentPosition = c.value.position;
      print("~~~~~~~" +
          "cv ${currentVideoIndex} " +
          currentPosition!.toString() +
          " $showReplayDialog");
      notifyListeners();
      if (currentVideoIndex == 0 &&
          currentPosition! >= const Duration(seconds: 16, milliseconds: 500)) {
        context.read<AnimProvider>().animationController.reverse();
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          context.read<AnimProvider>().animationController.forward();
        });
      }
    });

    if (currentVideoIndex == 0) {
      if (currentPosition! < Duration.zero) {
        return currentPosition! + const Duration(seconds: 18);
      }
      return currentPosition!;
    } else {
      return currentPosition! + const Duration(seconds: 18);
    }
  }
}
