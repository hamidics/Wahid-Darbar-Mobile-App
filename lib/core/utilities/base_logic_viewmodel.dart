import 'dart:io';

import 'package:wahiddarbar/core/common/navigation_service.dart';
import 'package:wahiddarbar/core/common/notification_service.dart';
import 'package:wahiddarbar/core/services/category_service.dart';
import 'package:wahiddarbar/core/services/customer_service.dart';
import 'package:wahiddarbar/core/services/food_service.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/services/order_service.dart';
import 'package:wahiddarbar/core/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'service_locator.dart';

class BaseLogicViewModel extends BaseViewModel {
  final FoodService foodService = locator<FoodService>();
  final CategoryService categoryService = locator<CategoryService>();
  final OrderService orderService = locator<OrderService>();
  final GlobalService globalService = locator<GlobalService>();
  final UserService userService = locator<UserService>();
  final CustomerService customerService = locator<CustomerService>();
  final NavigationService navigationService = locator<NavigationService>();
  final NotificationService notificationService =
      locator<NotificationService>();

  String successMessage;
  String errorMessage;
  bool isConnected = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  void showError(String message) {
    var snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'IRANSans',
          fontSize: 16,
        ),
      ),
      backgroundColor: Colors.red,
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    notifyListeners();
  }
}
