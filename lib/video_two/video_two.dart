import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../nav_key.dart';
import 'anim_provider.dart';
import 'video_provider.dart';

class VideoTwo extends StatefulWidget {
  const VideoTwo({super.key});

  @override
  State<VideoTwo> createState() => _VideoTwoState();
}

class _VideoTwoState extends State<VideoTwo> with TickerProviderStateMixin {
  // final controller = VideoPlayerController.asset('lib/assets/clip_1.dart');

  @override
  void initState() {
    navigatorKey.currentContext!.read<AnimProvider>().init(this);
    navigatorKey.currentContext!.read<VideoProvider>().init();
    navigatorKey.currentContext!
        .read<AnimProvider>()
        .animationController
        .forward();
    context.read<VideoProvider>().listen(context);

    // listenerOne(value.vc, context, videoProvider, setState: () {
    //   setState(() {});
    // });
    // listenerTwo(
    //   value.vc,
    //   cList[1],
    //   cList[2],
    //   context,
    //   videoProvider,
    // );
    // listenerThree(
    //   value.vc,
    //   cList[1],
    //   cList[2],
    //   context,
    //   videoProvider,
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0.0, end: 1.0).animate(
        navigatorKey.currentContext!.read<AnimProvider>().animationController);
    int zeroCheckPosition(VideoProvider value) {
      if (value.currentVideoIndex != 0 &&
          value.currentPosition!.inSeconds == 0) {
        return 18;
      }
      if (value.currentVideoIndex == 0) {
        if (value.currentPosition! < Duration.zero) {
          return value.currentPosition!.inSeconds + 18;
        }
        return value.currentPosition!.inSeconds;
      } else {
        return value.currentPosition!.inSeconds;
      }
    }

    int getTotalDuration(VideoProvider value) {
      switch (value.choice) {
        case Choice.happy:
          return 34;
        case Choice.sad:
          return 27;
        default:
          return 18;
      }
    }

    return Scaffold(
      body: Consumer<VideoProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              FadeTransition(
                opacity: animation,
                child: VideoPlayer(value.vc),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Consumer<VideoProvider>(
                  builder: (context, value, child) {
                    print("???" +
                        " ${value.currentVideoIndex}  ${value.totalDuration} " +
                        value.currentPosition.toString());
                    if (value.currentVideoIndex != 0 &&
                        value.currentPosition! >=
                            Duration(
                                    seconds:
                                        value.currentVideoIndex == 1 ? 16 : 9) -
                                const Duration(milliseconds: 300)) {
                      value.vc.pause();
                    }
                    double getVal() {
                      if (value.getPosition(context, value.vc) >=
                          value.totalDuration +
                              const Duration(milliseconds: 20)) {
                        log('Here');
                        return 18;
                      } else {
                        // log('THere: ${value.getPos()}');
                        return value
                            .getPosition(context, value.vc)
                            .inSeconds
                            .toDouble();
                      }
                    }

                    return Visibility(
                      visible: !value.hideBar,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Text(
                              "00:${value.getPosition(context, value.vc).inSeconds.toString().padLeft(2, '0')}/00:${value.totalDuration.inSeconds.toString().padLeft(2, '0')}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (value.vc.value.isPlaying) {
                                      value.vc.pause();
                                    } else {
                                      value.vc.play();
                                    }
                                  },
                                  icon: value.vc.value.isPlaying
                                      ? const Icon(
                                          Icons.pause,
                                          size: 34,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.play_arrow,
                                          size: 34,
                                          color: Colors.white,
                                        )),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  // max: value.totalDuration.inSeconds.toDouble(),
                                  max: getTotalDuration(value).toDouble(),
                                  // value: zeroCheckPosition(value).toDouble(),
                                  value: getVal(),
                                  onChanged: (v) {
                                    value.setPosition(v);
                                  },
                                  onChangeStart: (_) {
                                    value.vc.pause();
                                  },
                                  onChangeEnd: (v) async {
                                    handleChangeEnd(
                                      v,
                                      value,
                                      value.getPosition(context, value.vc),
                                      context,
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

Future<void> handleChangeEnd(
  double v,
  VideoProvider value,
  Duration customPosition,
  BuildContext context,
) async {
  // int pos = value.currentPosition!.inSeconds;
  if (v < 18) {
    if (value.currentVideoIndex == 0) {
      if (v < 9) {
        value.resetChoice();
      }
      value.vc.seekTo(Duration(seconds: v.toInt()));
      // ()async{

      await value.vc.play();
      // }();
    }
    if (value.currentVideoIndex == 1 || value.currentVideoIndex == 2) {
      value.setCurrentVideoIndex(0);
      if (v < 9) {
        value.resetChoice();
        // listenerOne(value.vc, cList[1], cList[2], context, value);
      }
      value.setVc(VideoPlayerController.asset("lib/assets/clip_1.mp4"));
      // totalDuration = videoData[0].length;
      () async {
        await value.vc.initialize();
        value.vc.seekTo(Duration(seconds: v.toInt()));
        await value.vc.play();
      }();
      value.listen(context);

      return;
    }
  }
  if (v >= 18) {
    if (value.currentVideoIndex == 1 || value.currentVideoIndex == 2) {
      value.vc.seekTo(Duration(seconds: v.toInt() - 18));
      await value.vc.play();
      return;
    }
    if (value.currentVideoIndex == 0) {
      if (value.choice == Choice.undefined) {
        value.vc.seekTo(const Duration(seconds: 8));
        return;
      }
      if (value.choice == Choice.happy) {
        value.setCurrentVideoIndex(1);
        value.setVc(VideoPlayerController.asset("lib/assets/clip_2.mp4"));
        () async {
          await value.vc.initialize();
          value.vc.seekTo(Duration(seconds: v.toInt() - 18));
          await value.vc.play();
        }();
        value.listen(context);
        return;
      }
      if (value.choice == Choice.sad) {
        value.setCurrentVideoIndex(2);
        value.setVc(VideoPlayerController.asset("lib/assets/clip_3.mp4"));
        () async {
          await value.vc.initialize();
          value.vc.seekTo(Duration(seconds: v.toInt() - 18));
          await value.vc.play();
        }();
        value.listen(context);
        return;
      }
    }
  }
}
