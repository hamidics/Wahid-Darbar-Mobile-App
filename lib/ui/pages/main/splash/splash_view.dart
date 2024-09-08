/*
 
 */

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/pages/main/splash/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        key: viewModel.scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Image.asset(
                  'asset/images/logo-mini.png',
                  scale: 1.5,
                ),
                duration: Duration(seconds: 2),
                crossFadeState: CrossFadeState.showSecond,
              ),
            ),
            AnimatedPositioned(
                child: Image.asset(
                  'asset/images/loader.gif',
                  height: screenSize.height * .15,
                ),
                duration: Duration(milliseconds: 1000),
                bottom: screenSize.height * .05,
                left: viewModel.showLogo
                    ? screenSize.width * .35
                    : screenSize.width * -1),
          ],
        ),
      ),
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (viewModel) => viewModel.initialize(),
    );
  }
}
