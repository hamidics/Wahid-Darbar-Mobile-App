/*
 
 */
import 'package:flutter/material.dart';
import 'package:wahiddarbar/ui/pages/food/home/food_home_view.dart';
import 'package:wahiddarbar/ui/pages/food/search/food_search_view.dart';
import 'package:wahiddarbar/ui/pages/main/authentication/authentication_view.dart';
import 'package:wahiddarbar/ui/pages/main/home/home_view.dart';
import 'package:wahiddarbar/ui/pages/main/no_internet/no_internet_view.dart';
import 'package:wahiddarbar/ui/pages/main/splash/splash_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return modifiedRoute(SplashView());
      case 'login':
        return modifiedRoute(AuthenticationView());
      case 'home':
        return modifiedRoute(HomeView());
      case 'food':
        return modifiedRoute(FoodHomeView());
      case 'food-search':
        return modifiedRoute(FoodSearchView());
      case 'no-internet':
        return modifiedRoute(NoInternetView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text(
                      'No Route for ${settings.name}',
                    ),
                  ),
                ));
    }
  }

  static Route modifiedRoute(Object object) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => object,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}
