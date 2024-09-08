/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/pages/main/no_internet/no_internet_viewmodel.dart';

class NoInternetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoInternetViewModel>.nonReactive(
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: Text('contact').tr(),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Image.asset(
                            'asset/images/logo-mini.png',
                            scale: 1.5,
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              MdiIcons.alert,
                              color: ThemeColors.Red,
                            ),
                            title: Text('contactUsToOrder').tr(),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              MdiIcons.phone,
                              color: ThemeColors.Red,
                            ),
                            title: Text(
                              '0730026242',
                            ),
                            onTap: () => viewModel.call('0730026242'),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              MdiIcons.phone,
                              color: ThemeColors.Red,
                            ),
                            title: Text(
                              '0797999972',
                            ),
                            onTap: () => viewModel.call('0797999972'),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              MdiIcons.phone,
                              color: ThemeColors.Red,
                            ),
                            title: Text(
                              '0790696369',
                            ),
                            onTap: () => viewModel.call('0790696369'),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => NoInternetViewModel());
  }
}
