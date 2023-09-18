import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_chat/common/theme/app_colors.dart';

class AppTheme {
  static ThemeData defaults() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          height: 1.2,
          letterSpacing: -.02,
          fontFeatures: [
            FontFeature.enable("cv11"),
            FontFeature.enable("tnum"),
            FontFeature.enable("lnum"),
          ],
        ),
        displayMedium: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 17,
          height: 1.2,
          letterSpacing: -.01,
        ),
        displaySmall: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.2,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
            ]),
        headlineMedium: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 1.2,
            letterSpacing: .01,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
            ]),
        headlineSmall: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 11,
            height: 1.2,
            letterSpacing: .06,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
              FontFeature.enable("salt"),
            ]),
        titleMedium: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 1.2,
            fontFeatures: [
              FontFeature.enable("cv11"),
            ]),
        titleSmall: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 1.2,
            letterSpacing: -.01,
            fontFeatures: [
              FontFeature.enable("cv11"),
            ]),
        bodyLarge: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.2,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
            ]),
        labelLarge: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.2,
            fontFeatures: [
              FontFeature.enable("cv11"),
            ]),
      ),
    );
  }
}
