import 'package:flutter/material.dart';
export 'app_pages.dart';

class NavigationService {

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navigate to a named route
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  // Replace current screen
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  // Go back
  void pop() => navigatorKey.currentState!.pop();

  // Check if can pop
  bool canPop() => navigatorKey.currentState!.canPop();
}
