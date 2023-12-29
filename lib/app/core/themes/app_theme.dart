import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pulso_app/app/core/themes/themes.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

ThemeData appTheme() => ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: textTheme().apply(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
      ),
      scaffoldBackgroundColor: ColorConstants.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
