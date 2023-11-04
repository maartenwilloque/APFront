// ignore_for_file: library_private_types_in_public_api

import 'package:ap_front/widgets/arwidget.dart';
import 'package:flutter/material.dart';

//camera page
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        title: Text(
          'Camera Page',
          style: theme.displayLarge,
        ),
        toolbarHeight: 75,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: ArWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dispose();
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
