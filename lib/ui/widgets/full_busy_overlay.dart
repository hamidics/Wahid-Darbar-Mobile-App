/*
 
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';

class FullBusyOverlay extends StatefulWidget {
  final Widget child;
  final bool show;
  const FullBusyOverlay({Key key, this.child, this.show = false})
      : super(key: key);

  @override
  _FullBusyOverlayState createState() => _FullBusyOverlayState();
}

class _FullBusyOverlayState extends State<FullBusyOverlay> {
  var showLogo = false;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        showLogo = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = SM.getSize(context);
    return Material(
      child: Stack(
        children: [
          widget.child,
          IgnorePointer(
            child: Opacity(
              opacity: widget.show ? 1 : 0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                alignment: Alignment.center,
                color: Colors.white,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                        child: Image.asset(
                          'asset/images/loader.gif',
                          height: screenSize.height * .15,
                        ),
                        duration: Duration(milliseconds: 1000),
                        bottom: screenSize.height * .4,
                        left: showLogo
                            ? screenSize.width * .4
                            : screenSize.width * -1)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
