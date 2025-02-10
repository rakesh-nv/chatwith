import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static NavigationService instance = NavigationService();

  Future<dynamic> navigateToReplacement(String _routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(_routeName);
  }

  Future<dynamic> navigateTo(String _routeName) {
    return navigatorKey.currentState!.pushNamed(_routeName);
  }

  Future<dynamic> navigateToRoute(String _routeName) {
    return navigatorKey.currentState!.pushNamed(_routeName);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
