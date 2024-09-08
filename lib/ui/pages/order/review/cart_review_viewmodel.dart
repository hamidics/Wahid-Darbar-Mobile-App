/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_coupon_line_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_fee_line_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_food_item_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/models/order_models/order_shipping_line_model.dart';
import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/pages/customer/address/customer_address_view.dart';

class CartReviewViewModel extends BaseLogicViewModel {
  final CustomerModel customerModel;
  CartReviewViewModel({Key key, this.customerModel});

  List<OrderFoodItemModel> finalCart = List<OrderFoodItemModel>();

  ScrollController scrollController = ScrollController();
  TextEditingController customerNotes = TextEditingController();

  String totalPrice = '';

  void initialize() {
    finalCart = orderService.foods;
    totalPrice = orderService.getTotalPrice();
  }

  void editAddress(BuildContext context) async {
    await pushNewScreen(
      context,
      screen: CustomerAddressView(
        customer: customerModel,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.fade,
    );

    totalPrice = orderService.getTotalPrice();
    notifyListeners();
  }

  void submit(BuildContext context) async {
    setBusy(true);

    int _userId;
    await SharedPreferences.getInstance()
        .then((value) => _userId = int.parse(value.getString('userId')));

    var _customerNotes = customerNotes.text.trim();

    var _shippingLines = List<OrderShippingLineModel>();

    var model = OrderModel.create(
      customerNote: _customerNotes,
      customerId: _userId,
      billing: customerModel.billing,
      shipping: customerModel.shipping,
      lineItems: orderService.cart,
      shippingLines: _shippingLines,
      feeLines: List<OrderFeeLineModel>(),
      couponLines: List<OrderCouponLineModel>(),
    );

    var result = await orderService.create(model);
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }
    setBusy(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              content: Text('orderAccepted').tr(),
              title: Icon(
                MdiIcons.check,
                color: Colors.green,
              ),
              actions: [
                FlatButton(
                  child: Text("confirm").tr(),
                  textColor: Colors.white,
                  color: ThemeColors.Fb,
                  onPressed: () => goToHome(),
                )
              ],
            ));
    // pushNewScreen(
    //   context,
    //   screen: CartFinalizeView(
    //     order: result.result,
    //   ),
    //   pageTransitionAnimation: PageTransitionAnimation.slideUp,
    //   withNavBar: false,
    // );
  }

  void goToHome() {
    orderService.cart.clear();
    orderService.foods.clear();
    globalService.homeViewModel.notifyListeners();
    navigationService.resetRoute();
  }
}
