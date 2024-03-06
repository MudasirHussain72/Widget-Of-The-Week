import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_of_the_week/controllers/services/dependency_injection.dart';
import 'package:widget_of_the_week/firebase_options.dart';
import 'package:widget_of_the_week/shorebird_cicd/shorebird_cicd.dart';
import 'package:widget_of_the_week/widgets/cached_video_player.dart';
import 'package:widget_of_the_week/widgets/long_press_dialog.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CachedVideoPlayerWidget(),
      // home: ShorebirdCicdExample(),
      home: LongPressDialog(),
    );
  }
}
