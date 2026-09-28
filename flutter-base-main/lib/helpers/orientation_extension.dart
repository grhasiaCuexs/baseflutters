import 'package:flutter/material.dart';
import 'package:myeshop/helpers/screen_measure_helpers.dart';

extension OrientationExt on BuildContext {
  bool isPortrait() => MediaQuery.of(this).orientation == Orientation.portrait;
  double getHorizontalCommonMargin({
    double potrait = 24,
    double landscape = 16 * 4,
  }) =>
      Measure.getHorizontalCommonMargin(
        this,
        potrait: potrait,
        landscape: landscape,
      );
}
