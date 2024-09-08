/*
 
 */

import 'package:flutter/widgets.dart';

// ignore: non_constant_identifier_names
final StaticMethods SM = StaticMethods();

class StaticMethods {
  int toInt(Object value) {
    if (value == null)
      return 0;
    else
      return value as int;
  }

  double toDouble(Object value) {
    if (value == null)
      return 0;
    else
      return value as double;
  }

  bool toBool(Object value) {
    if (value == null) return false;
    var strValue = toStr(value);
    return strValue == "true" ||
        strValue == "1" ||
        strValue == "True" ||
        strValue == "بله" ||
        strValue == "دارد";
  }

  String toStr(Object value) {
    if (value == null)
      return '';
    else
      return value.toString();
  }

  Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  String locale;
}
