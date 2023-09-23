import 'package:flutter/material.dart';

class ColorPalette {
  final Color primaryBackground;
  final Color secondaryBackground;
  final Color primary;
  final Color secondary;
  final Color highlight;
  final Color text;
  final Color hintText;
  final Color disabledText;
  final BoxShadow primaryShadow;

  ColorPalette({
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.primary,
    required this.secondary,
    required this.highlight,
    required this.text,
    required this.hintText,
    required this.disabledText,
    required this.primaryShadow,
  });

  static ColorPalette darkColorPalette = ColorPalette(

    primaryBackground: const Color.fromARGB(255, 21, 20, 19),
    secondaryBackground: const Color.fromARGB(255, 28, 27, 26),
    primary: const Color.fromARGB(255, 0, 225, 255),
    secondary: const Color.fromARGB(255, 0, 255, 191),
    highlight: const Color.fromARGB(255, 0, 225, 255),
    text: const Color.fromARGB(255, 255, 255, 255),
    hintText: const Color.fromARGB(255, 116, 116, 116),
    disabledText: const Color.fromARGB(255, 50, 50, 50),

    primaryShadow: const BoxShadow(
      color: Color.fromARGB(0, 37, 37, 37),
      blurRadius: 1.5,
      spreadRadius: 2.5,
    )

  );

  static ColorPalette currentColorPalette = darkColorPalette;
}