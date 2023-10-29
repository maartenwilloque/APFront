import 'package:flutter/material.dart';
import 'package:ap_front/pages/home_page.dart';
import 'package:ap_front/pages/camera_view.dart';
import 'package:ap_front/pages/review.dart';
import '/pages/history.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AlbumOpedia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 21, 6, 46),
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Album-Opedia'),
        routes: {
          '/camera': (context) => const CameraPage(),
          '/review': (context) => const ReviewPage(),
          '/history': (context) => const HistoryPage(
                title: 'Review History',
              ),
          '/home': (context) =>
              const MyHomePage(title: 'Flutter Album-Opedia Home '),
        });
  }
}
