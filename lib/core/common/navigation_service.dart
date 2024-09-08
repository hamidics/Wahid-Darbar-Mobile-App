/*
 
 */
import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToNoParam(String routeName) {
    return _navigationKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> resetRoute() {
    return _navigationKey.currentState
        .pushNamedAndRemoveUntil('home', (route) => false);
  }

  Future<dynamic> checkFirstRoute() {
    return _navigationKey.currentState.maybePop();
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    return _navigationKey.currentState
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  Future<dynamic> pushReplacement(String routeName) {
    return _navigationKey.currentState.pushReplacementNamed(routeName);
  }
}
