import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Size getWidgetSize(GlobalKey key) {
  final RenderBox renderBox = key.currentContext?.findRenderObject();
  return renderBox?.size;
}


