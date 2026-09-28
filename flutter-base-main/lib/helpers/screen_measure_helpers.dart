import 'package:flutter/material.dart';
import 'package:myeshop/helpers/orientation_extension.dart';

class Measure {
  static double getHorizontalCommonMargin(
    BuildContext context, {
    double potrait = 24,
    double landscape = 16 * 4,
  }) {
    return context.isPortrait() ? potrait : landscape;
  }
}
