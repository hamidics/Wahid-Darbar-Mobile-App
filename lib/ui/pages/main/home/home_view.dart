

import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        key: viewModel.scaffoldKey,
        body: PersistentTabView(
          controller: viewModel.controller,
          screens: viewModel.buildScreens(),
          items: viewModel.navBarItems(),
          confineInSafeArea: true,
          backgroundColor: ThemeColors.Yellow,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          hideNavigationBar: false,
          margin: EdgeInsets.all(0.0),
          popActionScreens: PopActionScreensType.once,
          bottomScreenMargin: 0.0,
          decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
          ),
          popAllScreensOnTapOfSelectedTab: false,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: false,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style13,
          iconSize: 30,
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialize(context),
    );
  }
}
