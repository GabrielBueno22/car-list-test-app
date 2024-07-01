import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: GoogleFonts.urbanist(
      color: base.titleLarge!.color,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: GoogleFonts.urbanist(
      color: base.titleMedium!.color,
      fontSize: 22,
    ),
    titleSmall: GoogleFonts.urbanist(
      color: base.titleSmall!.color,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.urbanist(
      color: base.bodyMedium!.color,
      fontSize: 16,
    ),
    bodyLarge: GoogleFonts.urbanist(
      color: base.bodyLarge!.color,
      fontSize: 18,
    ),
    labelLarge: GoogleFonts.urbanist(
      color: base.labelLarge!.color,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.urbanist(
      color: base.bodySmall!.color,
      fontSize: 14,
    ),
    headlineMedium: GoogleFonts.urbanist(
      color: base.headlineMedium!.color,
      fontSize: 20,
    ),
    displaySmall: GoogleFonts.urbanist(
      color: base.displaySmall!.color,
      fontSize: 12,
    ),
    displayMedium: GoogleFonts.urbanist(
      color: base.displayMedium!.color,
      fontSize: 14,
    ),
    displayLarge: GoogleFonts.urbanist(
      color: base.displayLarge!.color,
      fontSize: 16,
    ),
    headlineSmall: GoogleFonts.urbanist(
      color: base.headlineSmall!.color,
      fontSize: 18,
    ),
    labelSmall: GoogleFonts.urbanist(
      color: base.labelSmall!.color,
      fontSize: 14,
    ),
  );
}
