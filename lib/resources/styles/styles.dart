import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/fonts.dart';

class AppStyles {
  static var mainTheme = ThemeData(
    primaryColor: AppColors.mainColor,
    accentColor: AppColors.mainColor,
    scaffoldBackgroundColor: AppColors.appScreenBackground,
    platform: TargetPlatform.iOS,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    fontFamily: AppFonts.typeRegular,
  );

  TextStyle grayBold(double size) {
    return TextStyle(
        color: AppColors.grayMedium,
        fontSize: size,
        fontFamily: AppFonts.typeBold);
  }

  TextStyle whiteRegular(double size) {
    return TextStyle(
      color: AppColors.white,
      fontSize: size,
    );
  }
}
