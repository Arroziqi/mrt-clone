import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  static const EdgeInsets page = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );
  static const EdgeInsets card = EdgeInsets.all(md);
  static const EdgeInsets button = EdgeInsets.symmetric(
    vertical: 14.0,
    horizontal: 16.0,
  );
}
