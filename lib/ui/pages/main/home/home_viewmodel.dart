

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:wahiddarbar/core/common/connection_service.dart';
import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/pages/customer/main/customer_main_view.dart';
import 'package:wahiddarbar/ui/pages/food/home/food_home_view.dart';
import 'package:wahiddarbar/ui/pages/info/info_view.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_view.dart';

class HomeViewModel extends BaseLogicViewModel {
  PersistentTabController controller;
  // ignore: cancel_subscriptions
  StreamSubscription connectionChangeStream;
  bool _hasNetworkConnection = false;
  bool _fallbackViewOn = false;

  List<Widget> buildScreens() {
    return [
      FoodHomeView(),
      CartView(),
      CustomerMainView(),
      InfoView(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          MdiIcons.home,
        ),
        activeColor: Colors.black,
        inactiveColor: Colors.black,
        title: 'wahiddarbar'.tr(),
      ),
      PersistentBottomNavBarItem(
        icon: (() {
          if (orderService.cart.length == 0) {
            return Icon(
              Icons.shopping_basket,
            );
          } else {
            return Stack(
              children: [
                Icon(
                  Icons.shopping_basket,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Stack(
                    children: <Widget>[
                      Icon(MdiIcons.star, size: 20, color: Colors.white),
                    ],
                  ),
                ),
              ],
            );
          }
        }()),
        activeColor: Colors.black,
        inactiveColor: Colors.black,
        title: 'cart'.tr(),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          MdiIcons.account,
        ),
        activeColor: Colors.black,
        inactiveColor: Colors.black,
        title: 'user'.tr(),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          MdiIcons.cardAccountPhone,
        ),
        activeColor: Colors.black,
        inactiveColor: Colors.black,
        title: 'contact'.tr(),
      ),
    ];
  }

  showSnackbar({String message, Color color}) {
    var snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'IRANSans',
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 32,
            width: 32,
            child: IconButton(
              icon: Icon(
                MdiIcons.check,
                color: Colors.white,
              ),
              onPressed: () => scaffoldKey.currentState.hideCurrentSnackBar(),
            ),
          )
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      backgroundColor: color,
      margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 60.0),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void initialize(BuildContext context) {
    controller = PersistentTabController(initialIndex: 0);
    globalService.homeViewModel = this;
    SM.locale = context.locale.toLanguageTag();
    connectionChangeStream = ConnectionService.getInstance()
        .connectionChange
        .listen(connectionChange);
    notifyListeners();
  }

  void connectionChange(dynamic hasConnection) {
    if (!_hasNetworkConnection) {
      if (!_fallbackViewOn) {
        _fallbackViewOn = true;
        _hasNetworkConnection = !hasConnection;
        showSnackbar(message: 'checkInternet'.tr(), color: Colors.red);
      }
    } else {
      if (_fallbackViewOn) {
        _fallbackViewOn = false;
        _hasNetworkConnection = !hasConnection;
      }
    }
    notifyListeners();
  }

  void goToHome() {
    controller.jumpToTab(0);
  }
}
