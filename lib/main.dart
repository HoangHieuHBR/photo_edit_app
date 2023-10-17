import 'package:flutter/material.dart';
import 'package:photo_edit_app/main_module.dart';

import 'config/config.dart';

void main() {
  MainModule.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Editor App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.getStarted,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
