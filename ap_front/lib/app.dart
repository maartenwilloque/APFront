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
    Color mainColor = Color.fromRGBO(40, 66, 119, 1);
    Color backgroundColor = const Color(0xFFF1FAFE);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AlbumOpedia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: mainColor,
          seedColor: mainColor,
          background: backgroundColor,
        ),
        useMaterial3: true,
        textTheme: _getTextTheme(mainColor, backgroundColor),
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
      },
    );
  }

  TextTheme _getTextTheme(Color mainColor, Color backGroundColor) {
    TextTheme customTextTheme = TextTheme(
      displayLarge: const TextStyle(
        fontSize: 23,
        fontFamily: "Gill Sans MT Bold",
        color: Colors.white,
      ),
      displayMedium: const TextStyle(
        fontSize: 21,
        fontFamily: "Gill Sans MT Bold",
        color: Colors.white,
      ),
      displaySmall: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: 23,
        fontFamily: "Gill Sans MT Bold",
        color: mainColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 21,
        fontFamily: "Gill Sans MT Bold",
        color: mainColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 19,
        fontFamily: "Gill Sans MT Bold",
        color: mainColor,
      ),
      bodyLarge: const TextStyle(
        fontSize: 17,
        fontFamily: "Gill Sans MT",
        color: Colors.black,
      ),
      bodyMedium: const TextStyle(
        fontSize: 15,
        fontFamily: "Gill Sans MT",
        color: Colors.black,
      ),
      bodySmall: const TextStyle(
        fontSize: 13,
        fontFamily: "Gill Sans MT",
        color: Colors.black,
      ),
    );

    return customTextTheme;
  }
}
