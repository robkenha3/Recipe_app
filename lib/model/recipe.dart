import 'package:flutter/material.dart';

class Recipe {
  String name;
  IconData img;
  int preparationTime;
  double avaliation;

  Recipe({required this.name, required this.img, required this.preparationTime, required this.avaliation});
}
