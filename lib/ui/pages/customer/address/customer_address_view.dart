/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/customer_models/customer_model.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/customer/address/customer_address_viewmodel.dart';
import 'package:wahiddarbar/ui/widgets/busy_overlay.dart';

class CustomerAddressView extends StatelessWidget {
  const CustomerAddressView({Key key, this.customer}) : super(key: key);

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<CustomerAddressViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('editInformation').tr(),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: BusyOverlay(
            show: viewModel.isBusy,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Visibility(
                        visible: customer.billing.addressOne == '',
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'toContinueYourOrder',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ).tr(),
                              leading: Icon(
                                Icons.warning,
                                color: Colors.red,
                              ),
                            ),
                            Divider(),
                            Utils.createSizedBox(height: 4),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'address',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ).tr(),
                        leading:
                            Icon(Icons.info_outline, color: ThemeColors.Fb),
                      ),
                      Divider(),
                      ListTile(
                        title: Form(
                          key: viewModel.firstNameFormKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'nameValidator'.tr();
                              }
                              return null;
                            },
                            controller: viewModel.firstName,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'name'.tr(),
                            ),
                            onFieldSubmitted: (val) => FocusScope.of(context)
                                .requestFocus(viewModel.lastNameFocusNode),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Form(
                          key: viewModel.lastNameFormKey,
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'lastNameValidator'.tr();
                                }
                                return null;
                              },
                              controller: viewModel.lastName,
                              focusNode: viewModel.lastNameFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'lastName'.tr(),
                              ),
                              onFieldSubmitted: (val) => FocusScope.of(context)
                                  .requestFocus(viewModel.addressFocusNode)),
                        ),
                      ),
                      ListTile(
                        title: Form(
                          key: viewModel.addressFormKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'addressValidator'.tr();
                              }
                              return null;
                            },
                            controller: viewModel.address,
                            focusNode: viewModel.addressFocusNode,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'address'.tr(),
                              hintText: 'addressExample'.tr(),
                            ),
                            maxLines: 3,
                            onFieldSubmitted: (val) => viewModel.submit(),
                          ),
                        ),
                      ),
                      Utils.createSizedBox(height: 20),
                      ListTile(
                        title: Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text('submit').tr(),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(16),
                            onPressed: () => viewModel.submit(),
                            color: ThemeColors.Fb,
                          ),
                        ),
                      ),
                      Utils.createSizedBox(height: screenSize.height * .1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CustomerAddressViewModel(customerModel: customer),
      onModelReady: (viewModel) => viewModel.initialize(),
    );
  }
}
