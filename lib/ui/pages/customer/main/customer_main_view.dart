/*
 
 */
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/utilities/service_locator.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/customer/main/customer_main_viewmodel.dart';
import 'package:wahiddarbar/ui/widgets/full_busy_overlay.dart';

class CustomerMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerMainViewModel>.reactive(
      // disposeViewModel: false,
      // initialiseSpecialViewModelsOnce: true,
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('user').tr(),
        ),
        body: FullBusyOverlay(
          show: viewModel.isBusy,
          child: SafeArea(
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
                      ListTile(
                        leading: Icon(
                          MdiIcons.accountCheck,
                          color: ThemeColors.Red,
                        ),
                        title: Text(
                          'account',
                          style: TextStyle(fontSize: 18),
                        ).tr(namedArgs: {'mobile': viewModel.user.userName}),
                      ),
                      Visibility(
                        visible: viewModel.inCompleteRegistration,
                        child: ListTile(
                          title: Text(
                            'completeRegistration',
                            style: TextStyle(fontSize: 18),
                          ).tr(),
                          trailing: Icon(
                            Icons.brightness_1,
                            color: Colors.red,
                          ),
                          leading: Icon(
                            MdiIcons.accountEdit,
                            color: ThemeColors.Red,
                          ),
                          onTap: () => viewModel.goToUpdateProfile(context),
                        ),
                      ),
                      Visibility(
                        visible: !viewModel.inCompleteRegistration,
                        child: ListTile(
                          title: Text(
                            'editRegistration',
                            style: TextStyle(fontSize: 18),
                          ).tr(),
                          leading: Icon(
                            MdiIcons.accountEdit,
                            color: ThemeColors.Red,
                          ),
                          onTap: () => viewModel.goToUpdateProfile(context),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'orderList',
                          style: TextStyle(fontSize: 18),
                        ).tr(),
                        leading: Icon(
                          MdiIcons.accountDetails,
                          color: ThemeColors.Red,
                        ),
                        onTap: () => viewModel.goToOrders(context),
                      ),
                      // ListTile(
                      //   title: Text(
                      //     'language'.tr(),
                      //     style: TextStyle(fontSize: 18),
                      //   ),
                      //   leading: Icon(
                      //     MdiIcons.accountCog,
                      //     color: ThemeColors.Red,
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
                      //         .map<DropdownMenuItem<String>>((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value).tr(),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, right: 8),
                                  child: Icon(
                                    MdiIcons.accountCog,
                                    color: ThemeColors.Red,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 8, right: 10),
                                  child: Text(
                                    'changeLanguage'.tr(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                          )
                        ],
                      ),
                      ListTile(
                        title: Text(
                          'logout',
                          style: TextStyle(fontSize: 18),
                        ).tr(),
                        leading: Icon(
                          MdiIcons.accountRemove,
                          color: ThemeColors.Red,
                        ),
                        onTap: () => viewModel.logOutDialog(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => locator<CustomerMainViewModel>(),
    );
  }
}
