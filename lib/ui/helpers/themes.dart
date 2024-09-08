/*
 
 */

import 'package:flutter/material.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';

class Themes {
  static ThemeData light = ThemeData(
    fontFamily: SM.locale == 'ps-AF' ? 'IRANSans' : 'OpenSans',
    scaffoldBackgroundColor: Colors.grey[50],
    primaryColor: ThemeColors.Yellow,
    backgroundColor: Colors.grey[50],
  );
}
