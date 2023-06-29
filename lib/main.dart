import 'video_two/video_provider.dart';
import 'video_two/video_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nav_key.dart';
import 'video_two/anim_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<VidIndexProvider>(
    //       create: (_) => VidIndexProvider(),
    //     ),
    //     ChangeNotifierProvider<AnimProvider>(
    //       create: (_) => AnimProvider(),
    //     ),
    //     ChangeNotifierProvider<VidControlsProvider>(
    //       create: (_) => VidControlsProvider(),
    //     ),
    //     ChangeNotifierProvider<SliderHandlerProvider>(
    //       create: (_) => SliderHandlerProvider(),
    //     ),
    //   ],
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     navigatorKey: navigatorKey,
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: const VidScreen(),

    //   ),
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoProvider>(
          create: (_) => VideoProvider(),
        ),
        ChangeNotifierProvider<AnimProvider>(
          create: (_) => AnimProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const VideoTwo(),
      ),
    );
  }
}
