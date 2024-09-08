/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/info/info_viewmodel.dart';
import 'dart:ui' as ui;

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InfoViewModel>.nonReactive(
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
                          ListTile(
                            leading: Icon(
                              Icons.location_pin,
                              color: ThemeColors.Yellow,
                            ),
                            title: Text(
                              'storeAddress',
                            ).tr(),
                          ),
                          ListTile(
                            leading: Icon(
                              MdiIcons.telegram,
                              color: ThemeColors.Yellow,
                            ),
                            title: Text(
                              'telegram',
                            ).tr(),
                            trailing: Text(
                              'telegramAddress',
                              textDirection: ui.TextDirection.ltr,
                            ).tr(),
                            onTap: () => viewModel.telegramChannel(),
                          ),
                          ListTile(
                            leading: Icon(
                              MdiIcons.telegram,
                              color: ThemeColors.Yellow,
                            ),
                            title: Text(
                              'orderTelegram',
                            ).tr(),
                            trailing: Text(
                              'orderTelegramAddress',
                              textDirection: ui.TextDirection.ltr,
                            ).tr(),
                            onTap: () => viewModel.telegramOrder(),
                          ),
                          ListTile(
                            leading: Icon(
                              MdiIcons.whatsapp,
                              color: ThemeColors.Yellow,
                            ),
                            title: Text(
                              'whatsapp',
                            ).tr(),
                            trailing: Text(
                              '+93 79 069 6369',
                              style: TextStyle(fontSize: 17),
                              textDirection: ui.TextDirection.ltr,
                            ),
                            onTap: () => viewModel.whatsapp(),
                          ),
                          ListTile(
                            leading: Icon(
                              MdiIcons.facebook,
                              color: ThemeColors.Yellow,
                            ),
                            title: Text(
                              'facebook',
                            ).tr(),
                            trailing: Text(
                              'facebookAddress',
                            ).tr(),
                            onTap: () => viewModel.facebook(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'aboutWahiddarbarTitle',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ).tr(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'aboutWahiddarbar',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.justify,
                            ).tr(),
                          ),
                          Utils.createSizedBox(
                              height: MediaQuery.of(context).size.height * .1)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => InfoViewModel());
  }
}
