/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wahiddarbar/core/models/order_models/order_line_item_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_food_item_model.dart';
import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:wahiddarbar/ui/pages/customer/address/customer_address_view.dart';
import 'package:wahiddarbar/ui/pages/order/review/cart_review_view.dart';

class CartViewModel extends BaseLogicViewModel {
  List<OrderLineItemModel> lineItems = List<OrderLineItemModel>();
  List<OrderFoodItemModel> foods = List<OrderFoodItemModel>();

  var totalPrice = '';

  void initialize() {
    lineItems = orderService.cart;
    foods = orderService.foods;
    calculateTotalPrice();
    notifyListeners();
  }

  void add(OrderFoodItemModel food) {
    orderService.addQuantity(food.foodId);
    calculateTotalPrice();
    globalService.homeViewModel.notifyListeners();
    notifyListeners();
  }

  void remove(OrderFoodItemModel food) {
    orderService.remove(food.foodId);
    calculateTotalPrice();
    globalService.homeViewModel.notifyListeners();
    notifyListeners();
  }

  void removeItem(OrderFoodItemModel food) {
    orderService.removeItem(food.foodId);
    calculateTotalPrice();
    globalService.homeViewModel.notifyListeners();
    notifyListeners();
  }

  void calculateTotalPrice() {
    totalPrice = orderService.getTotalPrice();
    notifyListeners();
  }

  void goToCheckOut(BuildContext context) async {
    setBusy(true);

    var checkAvailablity = await userService.checkAvailablity();
    if (checkAvailablity.isSuccess == false) {
      print(checkAvailablity.message);
      setBusy(false);
      notifyListeners();
      return;
    }
    if (checkAvailablity.result == false) {
      var text = 'closedText'.tr();
      globalService.homeViewModel
          .showSnackbar(color: Colors.red, message: text);
    }

    var result = await customerService.retrieve();
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }

    await SharedPreferences.getInstance().then((value) async {
      if (value.getBool('registration-complete') != null) {
        pushNewScreen(
          context,
          screen: CartReviewView(
            customer: result.result,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      } else {
        await pushNewScreen(
          context,
          screen: CustomerAddressView(
            customer: result.result,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
        pushNewScreen(
          context,
          screen: CartReviewView(
            customer: result.result,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      }
    });

    setBusy(false);
    notifyListeners();
  }
}
