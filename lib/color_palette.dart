import 'dart:ui';

class ColorPalette {
  final Color primaryBackground;
  final Color secondaryBackground;
  final Color contrastButton;

  ColorPalette({
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.contrastButton
  });

  static ColorPalette lightColorPalette = ColorPalette(
    primaryBackground: const Color.fromARGB(255, 246, 255, 248),
    secondaryBackground: const Color.fromARGB(255, 232, 242, 240),
    contrastButton: const Color.fromARGB(255, 68, 7, 75)
  );

  static ColorPalette currentColorPalette = lightColorPalette;
}