import 'package:flutter/material.dart';
import 'package:stroi_komf/activities/house_3d_view.dart';

class View3DButton extends StatelessWidget {
  final String modelPath;

  const View3DButton({super.key, required this.modelPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HouseViewScreen(modelPath: modelPath),
            ),
          );
        },
        icon: const Icon(Icons.threed_rotation),
        label: const Text('3D просмотр'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}