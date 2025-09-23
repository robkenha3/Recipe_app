import 'package:flutter/material.dart';
import 'view/searchRecipeBar.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SearchRecipeBar());
  }
}
