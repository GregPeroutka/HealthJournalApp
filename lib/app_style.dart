import 'dart:ui';

class AppStyle {

  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color backgroundColor3;
  final Color highlightColor1;
  final Color highlightColor2;
  final Color textColor1;
  final Color textColor2;
  final Color textColor3;
  final Color contrastTextColor1;

  final double squareBorderRadius;
  final double completelyRoundRadius;

  final String fontFamily;

  final double fontSize1;
  final double fontSize2;
  final double fontSize3;
  final double fontSize4;
  final double fontSize5;

  AppStyle({
    required this.backgroundColor1, 
    required this.backgroundColor2, 
    required this.backgroundColor3, 
    required this.highlightColor1, 
    required this.highlightColor2, 
    required this.textColor1, 
    required this.textColor2, 
    required this.textColor3, 
    required this.contrastTextColor1,

    required this.squareBorderRadius,
    required this.completelyRoundRadius,

    required this.fontFamily,
  
    required this.fontSize1,
    required this.fontSize2,
    required this.fontSize3,
    required this.fontSize4,
    required this.fontSize5,
  });

  static const Color _defaultColor = Color.fromARGB(100, 255, 0, 0);

  static final AppStyle _darkStyle = AppStyle(
    backgroundColor1: const Color.fromARGB(255, 21, 20, 19),
    backgroundColor2: const Color.fromARGB(255, 28, 27, 26),
    backgroundColor3: _defaultColor,
    highlightColor1: const Color.fromARGB(255, 0, 225, 255),
    highlightColor2: const Color.fromARGB(255, 0, 255, 191),
    textColor1: const Color.fromARGB(255, 255, 255, 255),
    textColor2: const Color.fromARGB(255, 116, 116, 116),
    textColor3: const Color.fromARGB(255, 50, 50, 50),
    contrastTextColor1: const Color.fromARGB(255, 0, 0, 0),

    squareBorderRadius: 20,
    completelyRoundRadius: 10000,

    fontFamily: 'Rubik',

    fontSize1: 54,
    fontSize2: 44,
    fontSize3: 36,
    fontSize4: 24,
    fontSize5: 12
  );

  static AppStyle get currentStyle => _darkStyle; 

}