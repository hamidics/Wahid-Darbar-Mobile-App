/*
 
 */

import 'package:flutter/material.dart';

class ThemeBorders {
  static var enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Colors.grey),
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: ThemeData.light().primaryColor, width: 2),
  );

  static var errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Colors.red, width: 2),
  );

  static var searchBoxEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.black),
  );
}
