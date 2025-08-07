import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    double rotationAngle = 0.785;
    return Transform.translate(
      offset: Offset(0, -10),
      child: Transform.rotate(
        angle: rotationAngle, // 🔄 45 degree rotation
        child: FloatingActionButton(
          onPressed: () {
            debugPrint("FAB pressed");
          },
          backgroundColor: AppColors.darkgreen,
          child: Transform.rotate(
            angle: -rotationAngle,
            child: Image.asset(
              "assets/icons/quran2.png",
              height: 45,
            ),
          ),
        ),
      ),
    );
  }
}
