import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static const String getStarted = "/get-started";
  static const String home = "/home";
  static const String search = "/search";
  static const String detailPhoto = "/detail-photo";
  static const String editPhoto = "/edit-photo";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case getStarted:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );

      case home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Container(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case search:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Container(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case detailPhoto:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Container(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case editPhoto:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Container(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
