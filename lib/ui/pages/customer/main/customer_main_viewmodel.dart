/*
 
 */

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/common/navigation_service.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_billing_model.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_model.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_shipping_model.dart';
import 'package:wahiddarbar/core/services/customer_service.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/services/order_service.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/customer/address/customer_address_view.dart';
import 'package:wahiddarbar/ui/pages/customer/order_list/customer_order_list_view.dart';

class CustomerMainViewModel extends FutureViewModel {
  final CustomerService _customerService = locator<CustomerService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final OrderService _orderService = locator<OrderService>();
  final GlobalService _globalService = locator<GlobalService>();

  CustomerModel user = CustomerModel.create(
    avatarUrl: '',
    billing: CustomerBillingModel(),
    email: '',
    firstName: '',
    id: 0,
    isPayingCustomer: false,
    lastName: '',
    role: '',
    userName: '',
    shipping: CustomerShippingModel(),
  );

  bool inCompleteRegistration = false;

  var languages = ['ps_AF', 'en_US'];

  var currentLang;

  void setLanguage(BuildContext context, String language) async {
    if (language == 'en_US') {
      context.locale = EasyLocalization.of(context).supportedLocales[0];
      currentLang = EasyLocalization.of(context).supportedLocales[0];
      SM.locale = currentLang.toLanguageTag();
    } else {
      context.locale = EasyLocalization.of(context).supportedLocales[1];
      currentLang = EasyLocalization.of(context).supportedLocales[1];
      SM.locale = currentLang.toLanguageTag();
    }
    _orderService.cart.clear();
    _orderService.foods.clear();
    _globalService.homeViewModel.notifyListeners();
    _globalService.homeViewModel.goToHome();

    notifyListeners();
  }

  @override
  Future futureToRun() async {
    currentLang =
        EasyLocalization.of(_navigationService.navigationKey.currentContext)
            .locale;
    notifyListeners();
    await initialize();
  }

  Future initialize() async {
    await getUser();
    notifyListeners();
  }

  Future getUser() async {
    setBusy(true);
    var result = await _customerService.retrieve();
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }
    user = result.result;
    userValidation();
    setBusy(false);
    notifyListeners();
  }

  void userValidation() {
    if (user.billing.addressOne == '' || user.shipping.addressOne == '') {
      inCompleteRegistration = true;
    } else {
      inCompleteRegistration = false;
    }
    notifyListeners();
  }

  void goToOrders(BuildContext context) {
    pushNewScreen(
      context,
      screen: CustomerOrderListView(),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.fade,
    );
  }

  void goToUpdateProfile(BuildContext context) async {
    await pushNewScreen(context,
        screen: CustomerAddressView(
          customer: user,
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
    userValidation();
    notifyListeners();
  }

  void logOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('logoutMessage').tr(),
              actions: [
                FlatButton(
                  child: Text('No').tr(),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text('Yes').tr(),
                  onPressed: () => logOut(),
                  color: Colors.red,
                ),
              ],
            ));
  }

  void logOut() async {
    setBusy(true);
    await SharedPreferences.getInstance().then((value) {
      value.clear();
      _navigationService.pushNamedAndRemoveUntil('login');
    });
    setBusy(false);
    notifyListeners();
  }

  openChangeLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'changeLanguage',
                style: TextStyle(color: ThemeColors.Fb),
              ).tr(),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setLanguage(context, 'en_US'),
                    child: ShapeOfView(
                      shape: CircleShape(
                        borderColor: getColor('us'),
                        borderWidth: 2,
                      ),
                      child: Utils.createSingleAssetImageBox(
                          height: 64, width: 64, image: 'asset/images/us.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setLanguage(context, 'ps_AF'),
                    child: ShapeOfView(
                      shape: CircleShape(
                        borderColor: getColor('af'),
                        borderWidth: 2,
                      ),
                      child: Utils.createSingleAssetImageBox(
                          height: 64, width: 64, image: 'asset/images/af.png'),
                    ),
                  ),
                ],
              ),
            ));
  }

  Color getColor(String lang) {
    if (currentLang == Locale('en', 'US') && lang == 'us') {
      return ThemeColors.Red;
    } else if (currentLang == Locale('ps', 'AF') && lang == 'af') {
      return ThemeColors.Red;
    } else {
      return ThemeColors.Grey700;
    }
  }

  double getSize(String lang) {
    if (currentLang == Locale('en', 'US') && lang == 'us') {
      return 4;
    } else if (currentLang == Locale('ps', 'AF') && lang == 'af') {
      return 4;
    } else {
      return 1;
    }
  }
}
