/*
 
 */

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';

class SplashViewModel extends BaseLogicViewModel {
  var showLogo = false;
  void initialize() async {
    await checkInternet();
    await notificationService.initialize();
    Timer(Duration(seconds: 1), () {
      showLogo = true;
      notifyListeners();
    });
    if (isConnected) {
      Timer(Duration(seconds: 3), () {
        SharedPreferences.getInstance().then((value) {
          if (value.getString('userId') != null) {
            navigationService.pushReplacement('home');
          } else {
            navigationService.pushReplacement('login');
          }
        });
      });
    } else {
      Timer(Duration(seconds: 3), () {
        navigationService.pushReplacement('no-internet');
      });
    }
  }
}
