import 'package:flutter/material.dart';

class MyDimensions {
  MyDimensions._();
  // MyDimen should only have constants and helper methods.
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
