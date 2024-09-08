/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/widgets/busy_overlay.dart';

import 'authentication_viewmodel.dart';

class AuthenticationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
        builder: (context, viewModel, child) => Scaffold(
              key: viewModel.scaffoldKey,
              appBar: AppBar(
                title: Text('enterToWahiddarbar').tr(),
              ),
              resizeToAvoidBottomInset: false,
              resizeToAvoidBottomPadding: false,
              body: SafeArea(
                child: BusyOverlay(
                  show: viewModel.isBusy,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Image.asset(
                              'asset/images/logo-mini.png',
                              scale: 1.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      viewModel.setLanguage(context, 'en_US'),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ShapeOfView(
                                      shape: CircleShape(
                                        borderColor: viewModel.getColor('us'),
                                        borderWidth: viewModel.getSize('us'),
                                      ),
                                      child: Utils.createSingleAssetImageBox(
                                          height: 48,
                                          width: 48,
                                          image: 'asset/images/us.png'),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      viewModel.setLanguage(context, 'ps_AF'),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ShapeOfView(
                                      shape: CircleShape(
                                        borderColor: viewModel.getColor('af'),
                                        borderWidth: viewModel.getSize('af'),
                                      ),
                                      child: Utils.createSingleAssetImageBox(
                                          height: 48,
                                          width: 48,
                                          image: 'asset/images/af.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListTile(
                              title: Form(
                                autovalidateMode: AutovalidateMode.always,
                                child: TextFormField(
                                  validator: (value) =>
                                      viewModel.validateNumber(value),
                                  controller: viewModel.phoneController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'mobile'.tr(),
                                    suffixIcon: Icon(Icons.phone),
                                  ),
                                  onFieldSubmitted: (val) =>
                                      viewModel.sendOtp(context),
                                ),
                              ),
                            ),
                            Utils.createSizedBox(height: 8),
                            ListTile(
                              title: Container(
                                width: double.infinity,
                                child: FlatButton(
                                  child: Text('login').tr(),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(16),
                                  onPressed: () => viewModel.sendOtp(context),
                                  color: ThemeColors.Fb,
                                ),
                              ),
                            ),
                            // ListTile(
                            //   title: Text(
                            //     'language'.tr(),
                            //     style: TextStyle(fontSize: 18),
                            //   ),
                            //   leading: Icon(
                            //     MdiIcons.earth,
                            //     color: ThemeColors.Fb,
                            //   ),
                            //   trailing: DropdownButton<String>(
                            //     value: viewModel.currentLang.toString(),
                            //     iconSize: 20,
                            //     elevation: 16,
                            //     style: TextStyle(
                            //       color: Colors.black,
                            //       fontFamily: 'IRANSans',
                            //       fontSize: 19,
                            //     ),
                            //     underline: Container(
                            //       height: 1,
                            //       color: ThemeColors.Red,
                            //     ),
                            //     onChanged: (String newValue) {
                            //       viewModel.setLanguage(context, newValue);
                            //     },
                            //     items: viewModel.languages
                            //         .map<DropdownMenuItem<String>>(
                            //             (String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value).tr(),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                            // ListTile(
                            //   title: Text(
                            //     'changeLanguage'.tr(),
                            //     style: TextStyle(fontSize: 18),
                            //   ),
                            //   leading: Icon(
                            //     MdiIcons.earth,
                            //     color: ThemeColors.Fb,
                            //   ),
                            //   onTap: () =>
                            //       viewModel.openChangeLanguageDialog(context),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        onModelReady: (viewModel) => viewModel.initialize(context),
        viewModelBuilder: () => AuthenticationViewModel());
  }
}
