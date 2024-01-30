import 'package:flutter/material.dart';
import 'package:widget_of_the_week/shorebird_cicd/shorebird_cicd.dart';
import 'package:widget_of_the_week/widgets/cached_video_player.dart';
import 'package:widget_of_the_week/widgets/long_press_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CachedVideoPlayerWidget(),
      // home: ShorebirdCicdExample(),
      home: LongPressDialog(),
    );
  }
}
