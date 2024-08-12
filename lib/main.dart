import 'package:flutter/services.dart';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/views/screen_views/screen_controller_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    //Setting SysemUIOverlay
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light)
    );
    
    //Setting SystmeUIMode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);
    
    return MaterialApp(
      theme: ThemeData(
        fontFamily: AppStyle.currentStyle.fontFamily
      ),
      home: const Scaffold(
        body: ScreenControllerView()
      ),
    );
  }
}