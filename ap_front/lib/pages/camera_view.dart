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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
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
