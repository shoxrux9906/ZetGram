import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  //default
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);

  ///app
  static const Color primary = Color(0xFF327FEB);
  static const Color dark = Color(0xFF383838);
  static const Color dark_label = Color(0xFF616161);
  static const Color dark80 = Color.fromRGBO(56, 56, 56, 0.8);
  static const Color dark60 = Color.fromRGBO(56, 56, 56, 0.6);
  static const Color dark10 = Color.fromRGBO(56, 56, 56, 0.4);
  static const Color grey = Color(0xFFA9A9A9);
  static const Color grey80 = Color.fromRGBO(169, 169, 169, 0.8);
  static const Color grey60 = Color.fromRGBO(169, 169, 169, 0.6);
  static const Color grey40 = Color.fromRGBO(169, 169, 169, 0.4);
  static const Color grey20 = Color.fromRGBO(169, 169, 169, 0.2);
  static const Color success = Color(0xFF0AB97A);
  static const Color error = Color(0xFFF31629);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white80 = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color white30 = Color.fromRGBO(255, 255, 255, 0.6);
  static const Color screen = Color(0xFFFAFAFA);
  static const Color shimmerBase = Color(0xFFE5E5E5);
  static const Color shimmerHighlight = Color(0xFFFCF9F9);

  ///fonts
  static const String fontNunitoSans = 'NunitoSans';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    //h4 - display1
    fontFamily: fontNunitoSans,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    //h5 - headline
    fontFamily: fontNunitoSans,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontNunitoSans,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    //subtitle2 -> subtitle
    fontFamily: fontNunitoSans,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    //body2
    fontFamily: fontNunitoSans,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    //body1
    fontFamily: fontNunitoSans,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontNunitoSans,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText,
  );
}
