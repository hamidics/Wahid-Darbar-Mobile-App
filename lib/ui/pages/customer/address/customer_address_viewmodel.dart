/*
 
 */

import 'package:wahiddarbar/core/models/customer_models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerAddressViewModel extends BaseLogicViewModel {
  final CustomerModel customerModel;
  CustomerAddressViewModel({
    this.customerModel,
  });

  final firstName = TextEditingController();
  final firstNameFormKey = GlobalKey<FormState>();

  final lastNameFocusNode = FocusNode();
  final lastName = TextEditingController();
  final lastNameFormKey = GlobalKey<FormState>();

  final addressFocusNode = FocusNode();
  final address = TextEditingController();
  final addressFormKey = GlobalKey<FormState>();

  void initialize() {
    firstName.text = customerModel.billing.firstName;
    lastName.text = customerModel.billing.lastName;
    address.text = customerModel.billing.addressOne;
    notifyListeners();
  }

  void submit() async {
    if (!firstNameFormKey.currentState.validate() ||
        !lastNameFormKey.currentState.validate() ||
        !addressFormKey.currentState.validate()) {
      return;
    }
    setBusy(true);

    customerModel.billing.firstName = firstName.text.trim();
    customerModel.billing.lastName = lastName.text.trim();
    customerModel.billing.addressOne = address.text.trim();
    customerModel.billing.email = '${customerModel.userName}@wahiddarbar.com';
    customerModel.billing.postCode = '';
    customerModel.billing.city = 'Herat';
    customerModel.billing.phone = customerModel.userName;
    customerModel.shipping.firstName = firstName.text.trim();
    customerModel.shipping.lastName = lastName.text.trim();
    customerModel.shipping.addressOne = address.text.trim();
    customerModel.shipping.postCode = '';
    customerModel.shipping.city = 'Herat';
    customerModel.shipping.email = '${customerModel.userName}@wahiddarbar.com';
    customerModel.shipping.phone = customerModel.userName;
    customerModel.email = '${customerModel.userName}@wahiddarbar.com';

    var result = await customerService.update(customerModel);
    if (result.isSuccess == false) {
      print(result.message);
      setBusy(false);
      notifyListeners();
      return;
    }

    await SharedPreferences.getInstance().then((value) {
      value.setBool('registration-complete', true);
    });

    setBusy(false);
    notifyListeners();
    navigationService.pop();
  }

  void setCity(String val) {
    customerModel.billing.city = val;
    customerModel.shipping.city = val;
    notifyListeners();
  }
}
