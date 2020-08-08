import 'package:flutter/material.dart';
import 'dart:math';

class MyColors {

Color backgroundColor() {
  return Color.fromRGBO(72, 67, 92, 1);
}

Color accentColor() {
  return Color.fromRGBO(97, 231, 134, 1);
}

Color lightColor() {
  return Color.fromRGBO(237, 255, 236, 1);
}

Color randomColor() {

var r = Random().nextInt(255);
var g = Random().nextInt(255);
var b = Random().nextInt(255);

return Color.fromRGBO(r, g, b, 1);

}

}