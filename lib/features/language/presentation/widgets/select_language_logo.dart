import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';

class SelectLanguageLogo extends StatelessWidget {
  const SelectLanguageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImage().splashLogo,
      width: 250.w,
      fit: BoxFit.contain,
    );
  }
}