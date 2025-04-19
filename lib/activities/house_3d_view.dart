import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class HouseViewScreen extends StatelessWidget {
  final String modelPath;

  const HouseViewScreen({super.key, required this.modelPath});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Предпросмотр'),
      ),
      body: ModelViewer(
        src: modelPath,
        alt: "A 3D house model",
        autoRotate: true,
        cameraControls: true,
        ar: true,
        backgroundColor: Colors.white,
        loading: Loading.eager,
      ),
    );
  }
}