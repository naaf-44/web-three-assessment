import 'package:flutter/material.dart';

/// BoxDecoration styling for container.
class Decor {
  static containerDecoration(List<Color> colorList, List<double> stopList) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colorList,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: stopList,
      ),
    );
  }
}
