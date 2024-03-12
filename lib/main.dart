import 'package:flutter/material.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:flutter/scheduler.dart'; // Import package flutter/scheduler.dart

import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

void setSlowAnimations() {
  timeDilation = 10.0;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // setSlowAnimations();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
