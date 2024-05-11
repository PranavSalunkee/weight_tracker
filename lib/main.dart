import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/welcome/welcome_screen.dart';

import 'constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: Themes.dark.theme,
      theme: ThemeData.light() ,
      title: ProjectStrings.appName,
      home: WelcomeScreen(),
    );
  }
}