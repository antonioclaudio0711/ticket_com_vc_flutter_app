import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  dynamic navigateTo(String route, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamed(
      route,
      arguments: arguments,
    );
  }

  dynamic pushNamedAndRemoveUntil(String route, {dynamic arguments}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  dynamic pushReplacementNamed(String route, {dynamic arguments}) {
    navigatorKey.currentState?.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }
}
