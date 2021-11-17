import 'dart:io';

import 'package:camera/camera.dart';

import 'VisionDetectorViews/detector_views.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Process'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    tileColor: Theme.of(context).primaryColor,
                    title: const Text(
                      'Face Detector',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FaceDetectorView()));
                    },
                  ),
                  ListTile(
                    tileColor: Theme.of(context).primaryColor,
                    title: const Text(
                      'Text Detector',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TextDetectorView()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
