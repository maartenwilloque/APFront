// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ap_front/pages/nav/bottomnav.dart';

//camera page
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    // Initialize the camera
    availableCameras().then((cameras) {
      if (cameras.isEmpty) {
        setState(() {
          errorMessage = 'No cameras found.';
        });
      } else {
        // Select the first camera in the list
        controller = CameraController(cameras[0], ResolutionPreset.high);
        controller!.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the camera controller when the widget is removed
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontSize: 18),
        ),
      );
    }

    if (controller == null || !controller!.value.isInitialized) {
      return const Center(
          child: CircularProgressIndicator()); // Loading indicator
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: Center(
        child: CameraPreview(controller!),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
