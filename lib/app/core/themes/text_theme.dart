import 'package:flutter/material.dart';

import 'package:pulso_app/app/core/constants/constants.dart';

TextTheme textTheme() => const TextTheme(
      displayLarge: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w600,
        color: ColorConstants.strongGrey,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: ColorConstants.strongGrey,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ColorConstants.strongGrey,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: ColorConstants.strongGrey,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: ColorConstants.strongGrey,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: ColorConstants.strongGrey,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: ColorConstants.strongGrey,
      ),
    );

TextTheme getTextTheme(context) => Theme.of(context).textTheme;
